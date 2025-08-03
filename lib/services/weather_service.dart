// lib/services/weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_weather_app/tmp/weather_data.dart';
import 'package:intl/intl.dart'; // Deine Model-Klasse

final String _baseUrl = "https://api.brightsky.dev/";
final String _curWeather = "current_weather";
final String _forecast = "weather";

class WeatherService {
  // Hauptmethode, die alle Wetterdaten abruft.
  // Führt die API-Aufrufe für aktuelles Wetter und Vorhersage parallel aus.
  Future<WeatherData> fetchWeather(double lat, double lon) async {
    print('Fetching weather data for lat: $lat, lon: $lon');
    try {
      // Starte beide Netzwerk-Anfragen gleichzeitig und warte, bis beide abgeschlossen sind.
      final results = await Future.wait([_fetchCurrentWeather(lat, lon), _fetchFullForecast(lat, lon)]);

      // Weise die Ergebnisse den entsprechenden Variablen zu.
      final currentWeatherData = results[0];
      final forecastData = results[1];

      // Extrahiere die relevanten Teile aus den JSON-Antworten.
      final weatherData = currentWeatherData['weather'];
      final sourceData = currentWeatherData['sources'][0];
      final hourlyForecastList = forecastData['weather'] as List;

      // Verarbeite die Rohdaten der Vorhersage lokal, ohne weitere API-Aufrufe.
      final now = DateTime.now();
      final hourlyForecast = _processHourlyForecast(hourlyForecastList, now);
      final dailyForecast = _processDailyForecast(hourlyForecastList);

      // Baue das finale WeatherData-Objekt zusammen und gib es zurück.
      return WeatherData(
        stationName: sourceData['station_name'],
        temperature: (weatherData['temperature'] as num?)?.toDouble() ?? 0.0,
        humidity: (weatherData['relative_humidity'] as num?)?.toDouble() ?? 0.0,
        windSpeed: (weatherData['wind_speed_10min'] as num?)?.toDouble() ?? 0.0,
        pressure: (weatherData['pressure_msl'] as num?)?.toDouble() ?? 0.0,
        dewPoint: (weatherData['dew_point'] as num?)?.toDouble() ?? 0.0,
        visibility: ((weatherData['visibility'] as num?)?.toDouble() ?? 0.0) / 1000, // in km
        condition: weatherData['condition'] ?? 'N/A',
        icon: weatherData['icon'] ?? 'N/A',
        hourlyForecast: hourlyForecast,
        dailyForecast: dailyForecast,
      );
    } catch (e) {
      // Fange alle Fehler (Netzwerk, Parsing, etc.) und wirf eine einheitliche Exception.
      throw Exception('Wetterdaten konnten nicht geladen werden: $e');
    }
  }

  // Private Hilfsmethode zum Abrufen des aktuellen Wetters.
  Future<Map<String, dynamic>> _fetchCurrentWeather(double lat, double lon) async {
    final response = await http.get(Uri.parse('$_baseUrl$_curWeather?lat=$lat&lon=$lon'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Aktuelles Wetter konnte nicht geladen werden. Statuscode: ${response.statusCode}');
    }
  }

  // Private Hilfsmethode zum Abrufen der kompletten 8-Tage-Vorhersage.
  Future<Map<String, dynamic>> _fetchFullForecast(double lat, double lon) async {
    final DateTime now = DateTime.now();
    final String formattedStart = DateFormat("yyyy-MM-dd").format(now);
    final String formattedEnd = DateFormat("yyyy-MM-dd").format(now.add(const Duration(days: 8)));

    final response = await http.get(
      Uri.parse('$_baseUrl$_forecast?date=$formattedStart&last_date=$formattedEnd&lat=$lat&lon=$lon'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Vorhersagedaten konnten nicht geladen werden. Statuscode: ${response.statusCode}');
    }
  }

  // Verarbeitet die Rohdaten der Vorhersage, um eine stündliche Liste für die nächsten 24h zu erstellen.
  List<HourlyWeatherData> _processHourlyForecast(List<dynamic> hourlyData, DateTime now) {
    return hourlyData
        .map((item) => {'timestamp': DateTime.parse(item['timestamp']), 'data': item})
        .where((entry) => !entry['timestamp']!.isBefore(now))
        .take(24)
        .map((entry) {
          final item = entry['data']!;
          return HourlyWeatherData(
            time: DateFormat("HH:mm").format(entry['timestamp']!),
            temperature: (item['temperature'] as num?)?.toDouble() ?? 0.0,
            condition: item['condition'] ?? 'N/A',
            windSpeed: (item['wind_speed'] as num?)?.toDouble() ?? 0.0,
            precipitationProbability: (item['precipitation_probability'] as num?)?.toDouble() ?? 0.0,
          );
        })
        .toList();
  }

  // Verarbeitet die Rohdaten der Vorhersage, um eine tägliche Liste zu erstellen.
  List<DailyWeatherData> _processDailyForecast(List<dynamic> hourlyData) {
    if (hourlyData.isEmpty) return [];

    final Map<String, List<dynamic>> groupedByDay = {};

    // Gruppiere die stündlichen Daten nach Tag
    for (var item in hourlyData) {
      final timestamp = DateTime.parse(item['timestamp']);
      final dayKey = DateFormat('yyyy-MM-dd').format(timestamp);
      if (groupedByDay[dayKey] == null) {
        groupedByDay[dayKey] = [];
      }
      groupedByDay[dayKey]!.add(item);
    }

    final List<DailyWeatherData> dailyForecasts = [];

    // Verarbeite die Daten für jeden Tag
    groupedByDay.forEach((dayKey, dayData) {
      if (dayData.isEmpty) return;

      double minTemp = double.maxFinite;
      double maxTemp = -double.maxFinite;

      for (var item in dayData) {
        final temp = (item['temperature'] as num?)?.toDouble() ?? 0.0;
        if (temp < minTemp) minTemp = temp;
        if (temp > maxTemp) maxTemp = temp;
      }

      double minPrecipitaion = double.maxFinite;
      double maxPrecipitaion = -double.maxFinite;

      for (var item in dayData) {
        final precipitaion = (item['precipitation_probability'] as num?)?.toDouble() ?? 0.0;
        if (precipitaion < minPrecipitaion) minPrecipitaion = precipitaion;
        if (precipitaion > maxPrecipitaion) maxPrecipitaion = precipitaion;
      }

      // Nimm die Wetterbedingung um die Mittagszeit als repräsentativ
      final noonData = dayData.firstWhere(
        (item) => DateTime.parse(item['timestamp']).hour >= 12,
        orElse: () => dayData.first,
      );
      final String condition = noonData['condition'] ?? 'N/A';

      final date = DateTime.parse(dayData.first['timestamp']);
      // Wochentag auf Deutsch formatieren (erfordert Initialisierung in main.dart)

      dailyForecasts.add(
        DailyWeatherData(
          day: date,
          minTemp: minTemp,
          maxTemp: maxTemp,
          minPrecipitationProbability: minPrecipitaion,
          maxPrecipitationProbability: maxPrecipitaion,
          condition: condition,
        ),
      );
    });

    return dailyForecasts;
  }
}
