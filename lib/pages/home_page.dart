import 'package:flutter/material.dart';
import 'package:flutter_weather_app/provider/unit_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';
import 'package:flutter_weather_app/model/forecast_model.dart';
import 'package:flutter_weather_app/services/forecast_cache_service.dart';
import 'package:flutter_weather_app/services/forecast_service.dart';
import 'package:flutter_weather_app/services/location_service.dart';
import 'package:flutter_weather_app/views/weather_view.dart';
import 'package:provider/provider.dart';

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
  bool _isRefreshing = false;
  DateTime? _lastRefreshTime;
  // Cooldown period before allowing another refresh.
  final _refreshCooldown = const Duration(minutes: 1);

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
      });
    }

    // 2. request fresh data in the background.
    await _refreshWeatherData();

    await Future.delayed(const Duration(seconds: 10));

    // 3. make sure that the charging status is complete, even if an error has occurred.
    if (mounted && _isLoading) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshWeatherData() async {
    if (_isRefreshing) {
      return;
    }

    final now = DateTime.now();
    if (_lastRefreshTime != null && now.difference(_lastRefreshTime!) < _refreshCooldown) {
      final timeToWait = _refreshCooldown - now.difference(_lastRefreshTime!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.pleaseWaitSeconds(timeToWait.inSeconds)),
            action: SnackBarAction(
              label: l10n.ok,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
      return;
    }

    // Set flag to prevent concurrent refreshes.
    _isRefreshing = true;

    try {
      final unitProvider = Provider.of<UnitProvider>(context, listen: false);
      final position = await _locationService.getCurrentPosition();

      // Fetch forecast and placemark in parallel for better performance.
      final results = await Future.wait([
        _forecastService.fetchForecast(
          lat: position.latitude,
          lon: position.longitude,
          temperatureUnit: unitProvider.temperatureUnit,
          windSpeedUnit: unitProvider.windSpeedUnit,
          precipitationUnit: unitProvider.precipitationUnit,
        ),
        _locationService.getPlacemark(position.latitude, position.longitude),
      ]);

      final freshData = results[0] as Forecast;
      final placemark = results[1] as Placemark?;

      // Save the new data in the cache.
      await _forecastCacheService.saveForecastData(freshData);

      if (mounted) {
        setState(() {
          __forecastData = freshData;
          _placemark = placemark;
          _lastRefreshTime = DateTime.now();
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.weatherDataRefreshFailed),
            action: SnackBarAction(
              label: l10n.ok,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    } finally {
      // Reset flag in a finally block to ensure it's always reset.
      _isRefreshing = false;
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
        child: Stack(
          children: [
            buildWeatherView(context, __forecastData!, _placemark, MediaQuery.of(context).size, Theme.of(context)),
            if (_isRefreshing)
              IgnorePointer(
                ignoring: _isRefreshing, // Make sure to only ignore when it's visible
                child: _buildLoadingOverlay(),
              ),
          ],
        ),
      );
    }

    // Fallback if no data is available.
    return Center(child: Text(l10n.noWeatherDataAvail));
  }

  // A custom widget for the loading overlay
  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.5), // Semi-transparent background
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
