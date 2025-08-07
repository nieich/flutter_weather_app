import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';
import 'package:flutter_weather_app/model/forecast_model.dart';
import 'package:flutter_weather_app/services/forecast_cache_service.dart';
import 'package:flutter_weather_app/services/forecast_service.dart';
import 'package:flutter_weather_app/services/location_service.dart';
import 'package:flutter_weather_app/views/weather_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationService _locationService = LocationService();
  final ForecastService _forecastService = ForecastService();
  final ForcastCacheService _forecastCacheService = ForcastCacheService();

  late AppLocalizations l10n;

  Forecast? __forecastData;
  Placemark? _placemark;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    l10n = AppLocalizations.of(context)!;
  }

  Future<void> _loadInitialData() async {
    // 1. load data from the cache to display it immediately.
    final cachedData = await _forecastCacheService.loadWeatherData();
    if (mounted && cachedData != null) {
      setState(() {
        __forecastData = cachedData;
        _isLoading = false; // We have data, the main load indicator can go.
      });
    }

    // 2. request fresh data in the background.
    await _refreshWeatherData();

    // 3. make sure that the charging status is complete, even if an error has occurred.
    if (mounted && _isLoading) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshWeatherData() async {
    try {
      final position = await _locationService.getCurrentPosition();

      // Fetch forecast and placemark in parallel for better performance.
      final results = await Future.wait([
        _forecastService.fetchForecast(position.latitude, position.longitude),
        _locationService.getPlacemark(position.latitude, position.longitude),
      ]);

      final freshData = results[0] as Forecast;
      final placemark = results[1] as Placemark;

      // Save the new data in the cache.
      await _forecastCacheService.saveForecastData(freshData);

      if (mounted) {
        setState(() {
          __forecastData = freshData;
          _placemark = placemark;
          _error = null; // Reset error on success
        });
      }
    } catch (e) {
      if (mounted) {
        final errorMessage = '${l10n.error}: $e';
        // Only display the error if no old data is available.
        if (__forecastData == null) {
          setState(() {
            _error = errorMessage;
          });
        }
        // Inform the user about the failed refresh.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.weatherDataRefreshFailed)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      //decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    // Show a loading indicator when the app starts and there is no cache.
    if (_isLoading && __forecastData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Show an error message if something went wrong and we have no data.
    if (_error != null && __forecastData == null) {
      return RefreshIndicator(
        onRefresh: _refreshWeatherData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(heightFactor: 5, child: Text('$_error\n\n${l10n.pullDownToRefresh}')),
        ),
      );
    }

    // If we have data (from the cache or fresh), we display it.
    if (__forecastData != null) {
      return RefreshIndicator(
        onRefresh: _refreshWeatherData,
        child: buildWeatherView(context, __forecastData!, _placemark, MediaQuery.of(context).size, Theme.of(context)),
      );
    }

    // Fallback if no data is available.
    return Center(child: Text(l10n.noWeatherDataAvail));
  }
}
