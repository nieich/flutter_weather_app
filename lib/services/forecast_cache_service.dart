import 'package:flutter_weather_app/model/forecast_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForcastCacheService {
  static const _weatherCacheKey = 'weather_data_cache';

  /// Saves the weather data as a JSON string in the SharedPreferences.
  Future<void> saveForecastData(Forecast data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = data.toJsonString();
      await prefs.setString(_weatherCacheKey, jsonString);
    } catch (e) {
      // Errors when saving could be logged, but should not cause the app to crash.
      print('Fehler beim Speichern der Wetterdaten im Cache: $e');
    }
  }

  /// Loads the weather data from the SharedPreferences and deserializes it.
  /// Returns `null` if no data was found or an error occurs.
  Future<Forecast?> loadWeatherData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_weatherCacheKey);
      return jsonString != null ? Forecast.fromJsonString(jsonString) : null;
    } catch (e) {
      print('Fehler beim Laden der Wetterdaten aus dem Cache: $e');
      return null;
    }
  }
}
