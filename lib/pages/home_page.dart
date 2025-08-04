import 'package:flutter/material.dart';
import 'package:flutter_weather_app/services/weather_cache_service.dart';
import 'package:flutter_weather_app/services/location_service.dart';
import 'package:flutter_weather_app/services/weather_service.dart';
import 'package:flutter_weather_app/model/weather_model.dart';
import 'package:flutter_weather_app/views/weather_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();
  final WeatherCacheService _cacheService = WeatherCacheService();

  WeatherData? _weatherData;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    // 1. load data from the cache to display it immediately.
    final cachedData = await _cacheService.loadWeatherData();
    if (mounted && cachedData != null) {
      setState(() {
        _weatherData = cachedData;
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
      final freshData = await _weatherService.fetchWeather(position.latitude, position.longitude);

      // Save the new data in the cache.
      await _cacheService.saveWeatherData(freshData);

      if (mounted) {
        setState(() {
          _weatherData = freshData;
          _error = null; // Reset error on success
        });
      }
    } catch (e) {
      if (mounted) {
        final errorMessage = 'Fehler: $e';
        // Only display the error if no old data is available.
        if (_weatherData == null) {
          setState(() {
            _error = errorMessage;
          });
        }
        // Inform the user about the failed refresh.
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Aktualisierung der Wetterdaten fehlgeschlagen.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(16.0), child: _buildContent());
  }

  Widget _buildContent() {
    // Show a loading indicator when the app starts and there is no cache.
    if (_isLoading && _weatherData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Show an error message if something went wrong and we have no data.
    if (_error != null && _weatherData == null) {
      return RefreshIndicator(
        onRefresh: _refreshWeatherData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(heightFactor: 5, child: Text('$_error\n\nZum Aktualisieren nach unten ziehen.')),
        ),
      );
    }

    // If we have data (from the cache or fresh), we display it.
    if (_weatherData != null) {
      return RefreshIndicator(
        onRefresh: _refreshWeatherData,
        child: buildWeatherView(context, _weatherData!, MediaQuery.of(context).size, Theme.of(context)),
      );
    }

    // Fallback if no data is available.
    return const Center(child: Text('Keine Wetterdaten verfügbar.'));
  }
}
