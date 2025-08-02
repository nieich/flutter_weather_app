import 'package:flutter/material.dart';

enum HourlyWeatherCondition {
  dry(Icons.wb_sunny),
  fog(Icons.dehaze),
  rain(Icons.water_drop_outlined),
  sleet(Icons.cloudy_snowing),
  snow(Icons.ac_unit),
  hail(Icons.grain),
  thunderstorm(Icons.thunderstorm_outlined),
  unknown(Icons.help_outline);

  const HourlyWeatherCondition(this.icon);

  final IconData icon;

  static HourlyWeatherCondition fromString(String? apiCondition) {
    switch (apiCondition) {
      case 'dry':
        return HourlyWeatherCondition.dry;
      case 'fog':
        return HourlyWeatherCondition.fog;
      case 'rain':
        return HourlyWeatherCondition.rain;
      case 'sleet':
        return HourlyWeatherCondition.sleet;
      case 'snow':
        return HourlyWeatherCondition.snow;
      case 'hail':
        return HourlyWeatherCondition.hail;
      case 'thunderstorm':
        return HourlyWeatherCondition.thunderstorm;
      default:
        return HourlyWeatherCondition.unknown;
    }
  }
}
