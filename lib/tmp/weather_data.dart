class HourlyWeatherData {
  final String time;
  final double temperature;
  final double windSpeed;
  final String condition;
  final double precipitationProbability;

  HourlyWeatherData({
    required this.time,
    required this.temperature,
    required this.windSpeed,
    required this.condition,
    required this.precipitationProbability,
  });

  @override
  String toString() {
    return 'HourlyWeatherData(time: $time, temperature: $temperature, condition: $condition)';
  }
}

class DailyWeatherData {
  final DateTime day;
  final double maxTemp;
  final double minTemp;
  final String condition;

  DailyWeatherData({required this.day, required this.maxTemp, required this.minTemp, required this.condition});
}

class WeatherData {
  final String stationName;
  final double temperature;
  final double windSpeed;
  final double humidity;
  final double pressure;
  final double dewPoint;
  final double visibility;
  final String condition;
  final String icon;
  final List<HourlyWeatherData> hourlyForecast;
  final List<DailyWeatherData> dailyForecast;

  WeatherData({
    required this.stationName,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.pressure,
    required this.dewPoint,
    required this.visibility,
    required this.condition,
    required this.icon,
    this.hourlyForecast = const [],
    this.dailyForecast = const [],
  });

  @override
  String toString() {
    return 'WeatherData(stationName: $stationName, temperature: $temperature, condition: $condition)';
  }
}
