import 'package:flutter_weather_app/model/weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherCacheService {
  static const _weatherCacheKey = 'weather_data_cache';

  /// Speichert die Wetterdaten als JSON-String in den SharedPreferences.
  Future<void> saveWeatherData(WeatherData data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = data.toJsonString();
      await prefs.setString(_weatherCacheKey, jsonString);
    } catch (e) {
      // Fehler beim Speichern könnten protokolliert werden, sollten aber die App nicht zum Absturz bringen.
      print('Fehler beim Speichern der Wetterdaten im Cache: $e');
    }
  }

  /// Lädt die Wetterdaten aus den SharedPreferences und deserialisiert sie.
  /// Gibt `null` zurück, wenn keine Daten gefunden wurden oder ein Fehler auftritt.
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
