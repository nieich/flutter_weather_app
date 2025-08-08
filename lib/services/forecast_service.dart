import 'dart:convert';
import 'package:flutter_weather_app/model/forecast_model.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

/// Service for retrieving weather forecast data from the Open-Meteo API.
class ForecastService {
  /// Retrieves the weather data for the given coordinates.
  Future<Forecast> fetchForecast(double lat, double lon) async {
    Logger logger = Logger('ForecastService');
    logger.info('Fetching weather data for lat: $lat, lon: $lon');
    try {
      // We now build the URL securely and dynamically with Uri.https.
      // This is better than string manipulation, as it handles special characters correctly, for example.
      // API Calcs = 14Days + 10Variables * 1 Location = 1 API Call
      // ach day more adds a fraction; each Variable more adds 0.1 and everything times count of location
      // Current Cost: 1.3
      final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
        'latitude': lat.toString(),
        'longitude': lon.toString(),
        'daily': 'temperature_2m_max,temperature_2m_min,precipitation_probability_max',
        'hourly': 'temperature_2m,precipitation_probability,visibility,surface_pressure',
        'current': 'temperature_2m,relative_humidity_2m,precipitation,wind_speed_10m,wind_direction_10m,cloud_cover',
        'timezone': 'auto',
      });

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // We parse the JSON string and pass it on to our forecast model.
        final Map<String, dynamic> data = json.decode(response.body);
        return Forecast.fromJson(data);
      } else {
        throw Exception('Wetterdaten konnten nicht geladen werden. Statuscode: ${response.statusCode}');
      }
    } catch (e) {
      // Catch all errors (network, parsing, etc.) and throw a single exception.
      throw Exception('Wetterdaten konnten nicht geladen werden: $e');
    }
  }
}
