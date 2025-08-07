import 'package:flutter/material.dart';

enum WeatherCode {
  clear(
    code: 0,
    displayName: 'Clear Sky',
    icon: Icons.wb_sunny_outlined,
    assetPath: 'assets/images/clear-day/clear-day_X.jpg',
  ),
  mainlyClear(
    code: 1,
    displayName: 'Mainly Clear',
    icon: Icons.wb_sunny,
    assetPath: 'assets/images/clear-day/clear-day_X.jpg',
  ),
  partlyCloudy(
    code: 2,
    displayName: 'Partly Cloudy',
    icon: Icons.wb_cloudy,
    assetPath: 'assets/images/partly-cloudy-day/partly_cloudy_day_X.jpg',
  ),
  overcast(
    code: 3,
    displayName: 'Overcast',
    icon: Icons.cloud,
    assetPath: 'assets/images/partly-cloudy-day/partly_cloudy_day_X.jpg',
  ),

  // Fog and Drizzle
  fog(code: 45, displayName: 'Fog', icon: Icons.foggy, assetPath: 'assets/images/fog/fog_X.jpg'),
  depositingRimeFog(
    code: 48,
    displayName: 'Depositing Rime Fog',
    icon: Icons.foggy,
    assetPath: 'assets/images/fog/fog_X.jpg',
  ),
  drizzleLight(
    code: 51,
    displayName: 'Drizzle Light',
    icon: Icons.water_drop_outlined,
    assetPath: 'assets/images/fog/fog_X.jpg',
  ),
  drizzleModerate(
    code: 54,
    displayName: 'Drizzle Moderate',
    icon: Icons.water_drop_outlined,
    assetPath: 'assets/images/rain/rain_X.jpg',
  ),
  drizzleDense(
    code: 55,
    displayName: 'Drizzle Dense',
    icon: Icons.water_drop_outlined,
    assetPath: 'assets/images/rain/rain_X.jpg',
  ),
  freezingDrizzleLight(
    code: 56,
    displayName: 'Freezing Drizzle Light',
    icon: Icons.ac_unit,
    assetPath: 'assets/images/rain/rain_X.jpg',
  ),
  freezingDrizzleDense(
    code: 57,
    displayName: 'Freezing Drizzle Dense',
    icon: Icons.ac_unit,
    assetPath: 'assets/images/rain/rain_X.jpg',
  ),

  // Rain
  rainSlight(
    code: 61,
    displayName: 'Rain Slight',
    icon: Icons.umbrella_outlined,
    assetPath: 'assets/images/rain/rain_X.jpg',
  ),
  rainModerate(
    code: 63,
    displayName: 'Rain Moderate',
    icon: Icons.umbrella_outlined,
    assetPath: 'assets/images/rain/rain_X.jpg',
  ),
  rainHeavy(code: 65, displayName: 'Rain Heavy', icon: Icons.umbrella, assetPath: 'assets/images/rain/rain_X.jpg'),
  freezingRainLight(
    code: 66,
    displayName: 'Freezing Rain Light',
    icon: Icons.ac_unit,
    assetPath: 'assets/images/rain/rain_X.jpg',
  ),
  freezingRainHeavy(
    code: 67,
    displayName: 'Freezing Rain Heavy',
    icon: Icons.ac_unit,
    assetPath: 'assets/images/rain/rain_X.jpg',
  ),

  // Snow
  snowFallSlight(
    code: 71,
    displayName: 'Snow Fall Slight',
    icon: Icons.snowing,
    assetPath: 'assets/images/snow/snow_X.jpg',
  ),
  snowFallModerate(
    code: 73,
    displayName: 'Snow Fall Moderate',
    icon: Icons.snowing,
    assetPath: 'assets/images/snow/snow_X.jpg',
  ),
  snowFallHeavy(
    code: 75,
    displayName: 'Snow Fall Heavy',
    icon: Icons.snowing,
    assetPath: 'assets/images/snow/snow_X.jpg',
  ),
  snowGrains(code: 77, displayName: 'Snow Grains', icon: Icons.snowing, assetPath: 'assets/images/snow/snow_X.jpg'),

  // Showers
  rainShowersSlight(
    code: 80,
    displayName: 'Rain Showers Slight',
    icon: Icons.shower_outlined,
    assetPath: 'assets/images/rain/rain_X.jpg',
  ),
  rainShowersModerate(
    code: 81,
    displayName: 'Rain Showers Moderate',
    icon: Icons.shower_outlined,
    assetPath: 'assets/images/rain/rain_X.jpg',
  ),
  rainShowersViolent(
    code: 82,
    displayName: 'Rain Showers Violent',
    icon: Icons.shower,
    assetPath: 'assets/images/rain/rain_X.jpg',
  ),
  snowShowersSlight(
    code: 85,
    displayName: 'Snow Showers Slight',
    icon: Icons.snowing,
    assetPath: 'assets/images/snow/snow_X.jpg',
  ),
  snowShowersHeavy(
    code: 86,
    displayName: 'Snow Showers Heavy',
    icon: Icons.snowing,
    assetPath: 'assets/images/snow/snow_X.jpg',
  ),

  // Thunderstorm
  thunderstormSlight(
    code: 95,
    displayName: 'Thunderstorm Slight',
    icon: Icons.thunderstorm_outlined,
    assetPath: 'assets/images/thunderstorm/thunderstorm_X.jpg',
  ),
  thunderstormWithHailSlight(
    code: 96,
    displayName: 'Thunderstorm With Hail Slight',
    icon: Icons.thunderstorm,
    assetPath: 'assets/images/thunderstorm/thunderstorm_X.jpg',
  ),
  thunderstormWithHailModerate(
    code: 99,
    displayName: 'Thunderstorm With Hail Moderate',
    icon: Icons.thunderstorm,
    assetPath: 'assets/images/thunderstorm/thunderstorm_X.jpg',
  ),

  // Unknown
  unknown(
    code: -1,
    displayName: 'Unknown',
    icon: Icons.question_mark_outlined,
    assetPath: 'assets/images/unknown/unknown_X.jpg',
  );

  const WeatherCode({required this.code, required this.displayName, required this.icon, required this.assetPath});
  final int code;
  final String displayName;
  final IconData icon;
  final String assetPath;

  factory WeatherCode.fromCode(int? code) {
    return WeatherCode.values.firstWhere((element) => element.code == code, orElse: () => WeatherCode.unknown);
  }
}
