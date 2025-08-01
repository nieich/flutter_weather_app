// lib/services/weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_weather_app/tmp/weather_data.dart';
import 'package:intl/intl.dart'; // Deine Model-Klasse

final String _baseUrl = "https://api.brightsky.dev/";
final String _curWeather = "current_weather";
final String _forecast = "weather";

class WeatherService {
  // Ersetze dies durch deinen echten API-Schlüssel von einem Wetterdienst
  //final String _baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<WeatherData> fetchWeather(double lat, double lon) async {
    // Baue die URL mit den nötigen Parametern zusammen
    final response = await http.get(Uri.parse('$_baseUrl$_curWeather?lat=$lat&lon=$lon'));

    if (response.statusCode == 200) {
      // Wenn der Server eine 200 OK-Antwort zurückgibt,
      // parse das JSON.
      final data = jsonDecode(response.body);
      final weatherData = data['weather'];
      final sourceData = data['sources'][0];

      // Wandle die JSON-Daten in dein WeatherData-Objekt um.
      // Hinweis: Die stündlichen und täglichen Vorhersagen kommen oft von anderen API-Endpunkten.
      return WeatherData(
        stationName: sourceData['station_name'],
        temperature: (weatherData['temperature'] as num?)?.toDouble() ?? 0.0,
        humidity: (weatherData['relative_humidity'] as num?)?.toDouble() ?? 0.0,
        windSpeed: (weatherData['wind_speed_10min'] as num?)?.toDouble() ?? 0.0,
        pressure: (weatherData['pressure_msl'] as num?)?.toDouble() ?? 0.0,
        dewPoint: (weatherData['dew_point'] as num?)?.toDouble() ?? 0.0,
        visibility: ((weatherData['visibility'] as num?)?.toDouble() ?? 0.0) / 1000, // in km
        condition: weatherData['condition'] ?? 'N/A',
        hourlyForecast: await fetchHourlyForecast(lat, lon), // Diese müssten separat geladen werden
        dailyForecast: await fetchDailyForecast(lat, lon),
      );
    } else {
      // Wenn die Antwort nicht OK war, wirf eine Ausnahme, um den Fehler zu behandeln.
      throw Exception('Wetterdaten konnten nicht geladen werden. Statuscode: ${response.statusCode}');
    }
  }
}

Future<List<HourlyWeatherData>> fetchHourlyForecast(double lat, double lon) async {
  final DateTime now = DateTime.now();
  final String formattedNow = DateFormat("yyyy-MM-dd").format(now);
  //Needs to be +2 days as it will stop at 0:00 otherwise
  final String formattedTomorrow = DateFormat("yyyy-MM-dd").format(now.add(Duration(days: 2)));

  final response = await http.get(
    Uri.parse('$_baseUrl$_forecast?date=$formattedNow&last_date=$formattedTomorrow&lat=$lat&lon=$lon'),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final hourlyData = data['weather'] as List;

    // Filtere die Liste, um nur zukünftige Vorhersagen zu erhalten (max. 24).
    // Wir mappen zuerst, um das Parsen des Timestamps nicht doppelt auszuführen.
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
  } else {
    throw Exception('Stündliche Wetterdaten konnten nicht geladen werden. Statuscode: ${response.statusCode}');
  }
}

Future<List<DailyWeatherData>> fetchDailyForecast(double lat, double lon) async {
  final DateTime now = DateTime.now();
  final String formattedStart = DateFormat("yyyy-MM-dd").format(now);
  //Needs to be +8 days as it will stop at 0:00 otherwise
  final String formattedEnd = DateFormat("yyyy-MM-dd").format(now.add(Duration(days: 8)));

  final response = await http.get(
    Uri.parse('$_baseUrl$_forecast?date=$formattedStart&last_date=$formattedEnd&lat=$lat&lon=$lon'),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final hourlyData = data['weather'] as List;

    // 1. Gruppiere die stündlichen Daten nach Tag
    final Map<String, List<dynamic>> groupedByDay = {};
    for (var item in hourlyData) {
      // Extrahiere den Datumsteil des Timestamps als Schlüssel (z.B. "2023-10-27")
      final dayKey = (item['timestamp'] as String).substring(0, 10);
      if (groupedByDay[dayKey] == null) {
        groupedByDay[dayKey] = [];
      }
      groupedByDay[dayKey]!.add(item);
    }

    // 2. Verarbeite jede Tagesgruppe, um Min/Max-Temp und die Hauptwetterlage zu ermitteln
    final List<DailyWeatherData> dailyForecasts = [];
    groupedByDay.forEach((dayString, dayHourlyData) {
      if (dayHourlyData.isEmpty) return;

      double maxTemp = -double.infinity;
      double minTemp = double.infinity;
      Map<String, int> conditionCounts = {};

      for (var hourlyItem in dayHourlyData) {
        final temp = (hourlyItem['temperature'] as num?)?.toDouble() ?? 0.0;
        if (temp > maxTemp) maxTemp = temp;
        if (temp < minTemp) minTemp = temp;

        final condition = hourlyItem['condition'] as String?;
        if (condition != null) {
          conditionCounts[condition] = (conditionCounts[condition] ?? 0) + 1;
        }
      }

      // Finde die häufigste Wetterbedingung für den Tag
      String dominantCondition = conditionCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;

      dailyForecasts.add(
        DailyWeatherData(
          day: DateTime.parse(dayString),
          maxTemp: maxTemp,
          minTemp: minTemp,
          condition: dominantCondition,
        ),
      );
    });

    return dailyForecasts;
  } else {
    throw Exception('Tägliche Wetterdaten konnten nicht geladen werden. Statuscode: ${response.statusCode}');
  }
}
