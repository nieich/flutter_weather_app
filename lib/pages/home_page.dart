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
    // 1. Lade Daten aus dem Cache, um sie sofort anzuzeigen.
    final cachedData = await _cacheService.loadWeatherData();
    if (mounted && cachedData != null) {
      setState(() {
        _weatherData = cachedData;
        _isLoading = false; // Wir haben Daten, der Haupt-Ladeindikator kann weg.
      });
    }

    // 2. Fordere im Hintergrund frische Daten an.
    await _refreshWeatherData();

    // 3. Stelle sicher, dass der Ladezustand beendet ist, auch wenn ein Fehler aufgetreten ist.
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

      // Speichere die neuen Daten im Cache.
      await _cacheService.saveWeatherData(freshData);

      if (mounted) {
        setState(() {
          _weatherData = freshData;
          _error = null; // Fehler zurücksetzen bei Erfolg
        });
      }
    } catch (e) {
      if (mounted) {
        final errorMessage = 'Fehler: $e';
        // Zeige den Fehler nur an, wenn keine alten Daten vorhanden sind.
        if (_weatherData == null) {
          setState(() {
            _error = errorMessage;
          });
        }
        // Informiere den Benutzer über den fehlgeschlagenen Refresh.
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
    // Zeige einen Ladeindikator, wenn die App startet und kein Cache vorhanden ist.
    if (_isLoading && _weatherData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Zeige eine Fehlermeldung, wenn etwas schiefgelaufen ist und wir keine Daten haben.
    if (_error != null && _weatherData == null) {
      return RefreshIndicator(
        onRefresh: _refreshWeatherData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(heightFactor: 5, child: Text('$_error\n\nZum Aktualisieren nach unten ziehen.')),
        ),
      );
    }

    // Wenn wir Daten haben (aus dem Cache oder frisch), zeigen wir sie an.
    if (_weatherData != null) {
      return RefreshIndicator(
        onRefresh: _refreshWeatherData,
        child: buildWeatherView(context, _weatherData!, MediaQuery.of(context).size, Theme.of(context)),
      );
    }

    // Fallback, falls keine Daten vorhanden sind.
    return const Center(child: Text('Keine Wetterdaten verfügbar.'));
  }
}
