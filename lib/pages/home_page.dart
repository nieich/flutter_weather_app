import 'package:flutter/material.dart';
import 'package:flutter_weather_app/services/location_service.dart';
import 'package:flutter_weather_app/services/weather_service.dart';
import 'package:flutter_weather_app/tmp/weather_data.dart';
import 'package:flutter_weather_app/views/weather_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();
  late Future<WeatherData> _weatherDataFuture;

  Future<WeatherData> _getWeatherData() async {
    try {
      // 1. Standort abrufen
      final position = await _locationService.getCurrentPosition();
      // 2. Wetter für diesen Standort abrufen
      return await _weatherService.fetchWeather(position.latitude, position.longitude);
    } catch (e) {
      // Fehler an die UI weitergeben
      throw Exception('Fehler beim Abrufen der Wetterdaten: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _weatherDataFuture = _getWeatherData();
  }

  Future<void> _refreshWeatherData() async {
    // Löst einen Rebuild mit einem neuen Future aus und zeigt so den
    // Ladeindikator im FutureBuilder erneut an.
    setState(() {
      _weatherDataFuture = _getWeatherData();
    });
    await _weatherDataFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<WeatherData>(
        future: _weatherDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Erlaube "Pull-to-Refresh" auch auf dem Fehlerbildschirm.
            return RefreshIndicator(
              onRefresh: _refreshWeatherData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Center(
                  heightFactor: 5,
                  child: Text('Fehler: ${snapshot.error}\n\nZum Aktualisieren nach unten ziehen.'),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            final weatherData = snapshot.data!;
            return RefreshIndicator(
              onRefresh: _refreshWeatherData,
              child: buildWeatherView(weatherData, MediaQuery.of(context).size, Theme.of(context)),
            );
          } else {
            return const Center(child: Text('Keine Wetterdaten verfügbar.'));
          }
        },
      ),
    );
  }
}
