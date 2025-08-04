import 'package:flutter_weather_app/model/weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherCacheService {
  static const _weatherCacheKey = 'weather_data_cache';

  /// Saves the weather data as a JSON string in the SharedPreferences.
  Future<void> saveWeatherData(WeatherData data) async {
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
  Future<WeatherData?> loadWeatherData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_weatherCacheKey);
      return jsonString != null ? WeatherData.fromJsonString(jsonString) : null;
    } catch (e) {
      print('Fehler beim Laden der Wetterdaten aus dem Cache: $e');
      return null;
    }
  }
}
