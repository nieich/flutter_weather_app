// lib/services/weather_service.dart
import 'dart:convert';
import 'package:flutter_weather_app/model/forecast_model.dart';
import 'package:http/http.dart' as http;

/// Service zum Abrufen von Wettervorhersagedaten von der Open-Meteo API.
class ForecastService {
  /// Ruft die Wetterdaten für die gegebenen Koordinaten ab.
  Future<Forecast> fetchWeather(double lat, double lon) async {
    print('Fetching weather data for lat: $lat, lon: $lon');
    try {
      // Wir bauen die URL jetzt sicher und dynamisch mit Uri.https.
      // Das ist besser als String-Manipulation, da es z.B. Sonderzeichen korrekt behandelt.
      final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
        'latitude': lat.toString(),
        'longitude': lon.toString(),
        'daily': 'temperature_2m_max,temperature_2m_min',
        'hourly': 'temperature_2m,precipitation_probability',
        'current': 'temperature_2m,relative_humidity_2m,precipitation,wind_speed_10m,wind_direction_10m,cloud_cover',
        'timezone': 'auto',
      });

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Wir parsen den JSON-String und geben ihn an unser Forecast-Model weiter.
        final Map<String, dynamic> data = json.decode(response.body);
        return Forecast.fromJson(data);
      } else {
        throw Exception('Wetterdaten konnten nicht geladen werden. Statuscode: ${response.statusCode}');
      }
    } catch (e) {
      // Fange alle Fehler (Netzwerk, Parsing, etc.) und wirf eine einheitliche Exception.
      throw Exception('Wetterdaten konnten nicht geladen werden: $e');
    }
  }
}
