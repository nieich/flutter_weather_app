enum WeatherCondition {
  // Definiere die Enum-Werte und übergebe die Daten an den Konstruktor
  clearDay('Clear Day', 'assets/images/clear-day/clear-day_X.jpg'),
  clearNight('Clear Night', 'assets/images/clear-night/clear-night_X.jpg'),
  cloudy('Cloudy', 'assets/images/cloudy/cloudy_X.jpg'),
  fog('Fog', 'assets/images/fog/fog_X.jpg'),
  hail('Hail', 'assets/images/hail/hail_X.jpg'),
  partlyCloudyDay('Partly Cloudy', 'assets/images/partly-cloudy-day/partly_cloudy_day_X.jpg'),
  partlyCloudyNight('Partly Cloudy', 'assets/images/partly-cloudy-night/partly_cloudy_night_X.jpg'),
  rain('Rain', 'assets/images/rain/rain_X.jpg'),
  sleet('Sleet', 'assets/images/sleet/sleet_X.jpg'),
  snow('Snow', 'assets/images/snow/snow_X.jpg'),
  thunderstorm('Thunderstorm', 'assets/images/thunderstorm/thunderstorm_X.jpg'),
  wind('Wind', 'assets/images/wind/wind_X.jpg'),
  unknown('Unknown', 'assets/images/unknown/unknown_X.jpg');

  // Konstruktor muss 'const' sein
  const WeatherCondition(this.displayName, this.assetPath);

  // Felder müssen 'final' sein
  final String displayName;
  final String assetPath;

  // Eine Hilfsmethode, um aus einem API-String das passende Enum zu finden
  static WeatherCondition fromString(String? apiCondition) {
    switch (apiCondition) {
      case 'clear-day':
        return WeatherCondition.clearDay;
      case 'clear-night':
        return WeatherCondition.clearNight;
      case 'cloudy':
        return WeatherCondition.cloudy;
      case 'fog':
        return WeatherCondition.fog;
      case 'hail':
        return WeatherCondition.hail;
      case 'partly-cloudy-day':
        return WeatherCondition.partlyCloudyDay;
      case 'partly-cloudy-night':
        return WeatherCondition.partlyCloudyNight;
      case 'rain':
        return WeatherCondition.rain;
      case 'sleet':
        return WeatherCondition.sleet;
      case 'snow':
        return WeatherCondition.snow;
      case 'thunderstorm':
        return WeatherCondition.thunderstorm;
      case 'wind':
        return WeatherCondition.wind;
      default:
        return WeatherCondition.unknown;
    }
  }
}
