import 'package:flutter/foundation.dart';
import 'package:flutter_weather_app/utils/precipitation_unit_enum.dart';
import 'package:flutter_weather_app/utils/temperature_unit_enum.dart';
import 'package:flutter_weather_app/utils/wind_speed_unit_enum.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnitProvider with ChangeNotifier {
  static const String _temperatureUnitKey = 'temperature_unit';
  static const String _windSpeedUnitKey = 'wind_speed_unit';
  static const String _precipitationUnitKey = 'precipitation_unit';

  TemperatureUnitEnum _temperatureUnit = TemperatureUnitEnum.celsius;
  WindSpeedUnitEnum _windSpeedUnit = WindSpeedUnitEnum.kmh;
  PrecipitationUnitEnum _precipitationUnit = PrecipitationUnitEnum.mm;

  UnitProvider() {
    _loadUnits();
  }

  TemperatureUnitEnum get temperatureUnit => _temperatureUnit;
  WindSpeedUnitEnum get windSpeedUnit => _windSpeedUnit;
  PrecipitationUnitEnum get precipitationUnit => _precipitationUnit;

  Future<void> _loadUnits() async {
    final logger = Logger('UnitProvider');
    final prefs = await SharedPreferences.getInstance();

    final temperatureUnitName = prefs.getString(_temperatureUnitKey);
    if (temperatureUnitName != null) {
      try {
        _temperatureUnit = TemperatureUnitEnum.values.byName(temperatureUnitName);
      } catch (e) {
        logger.info('Unknown temperature unit: $temperatureUnitName, defaulting to celsius.');
        _temperatureUnit = TemperatureUnitEnum.celsius;
      }
    }

    final windSpeedUnitName = prefs.getString(_windSpeedUnitKey);
    if (windSpeedUnitName != null) {
      try {
        _windSpeedUnit = WindSpeedUnitEnum.values.byName(windSpeedUnitName);
      } catch (e) {
        logger.info('Unknown wind speed unit: $windSpeedUnitName, defaulting to kmh.');
        _windSpeedUnit = WindSpeedUnitEnum.kmh;
      }
    }

    final precipitationUnitName = prefs.getString(_precipitationUnitKey);
    if (precipitationUnitName != null) {
      try {
        _precipitationUnit = PrecipitationUnitEnum.values.byName(precipitationUnitName);
      } catch (e) {
        logger.info('Unknown precipitation unit: $precipitationUnitName, defaulting to mm.');
        _precipitationUnit = PrecipitationUnitEnum.mm;
      }
    }
    notifyListeners();
  }

  Future<void> setTemperatureUnit(TemperatureUnitEnum unit) async {
    _temperatureUnit = unit;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_temperatureUnitKey, unit.name);
    notifyListeners();
  }

  Future<void> setWindSpeedUnit(WindSpeedUnitEnum unit) async {
    _windSpeedUnit = unit;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_windSpeedUnitKey, unit.name);
    notifyListeners();
  }

  Future<void> setPrecipitationUnit(PrecipitationUnitEnum unit) async {
    _precipitationUnit = unit;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_precipitationUnitKey, unit.name);
    notifyListeners();
  }
}
