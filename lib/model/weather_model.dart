import 'dart:convert';

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

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature': temperature,
      'windSpeed': windSpeed,
      'condition': condition,
      'precipitationProbability': precipitationProbability,
    };
  }

  factory HourlyWeatherData.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherData(
      time: json['time'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      condition: json['condition'] as String,
      precipitationProbability: (json['precipitationProbability'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'HourlyWeatherData(time: $time, temperature: $temperature, condition: $condition)';
  }
}

class DailyWeatherData {
  final DateTime day;
  final double maxTemp;
  final double minTemp;
  final double minPrecipitationProbability;
  final double maxPrecipitationProbability;
  final String condition;

  DailyWeatherData({
    required this.day,
    required this.maxTemp,
    required this.minTemp,
    required this.minPrecipitationProbability,
    required this.maxPrecipitationProbability,
    required this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day.toIso8601String(),
      'maxTemp': maxTemp,
      'minTemp': minTemp,
      'minPrecipitationProbability': minPrecipitationProbability,
      'maxPrecipitationProbability': maxPrecipitationProbability,
      'condition': condition,
    };
  }

  factory DailyWeatherData.fromJson(Map<String, dynamic> json) {
    return DailyWeatherData(
      day: DateTime.parse(json['day'] as String),
      maxTemp: (json['maxTemp'] as num).toDouble(),
      minTemp: (json['minTemp'] as num).toDouble(),
      minPrecipitationProbability: (json['minPrecipitationProbability'] as num).toDouble(),
      maxPrecipitationProbability: (json['maxPrecipitationProbability'] as num).toDouble(),
      condition: json['condition'] as String,
    );
  }
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

  /// Serialisiert die Wetterdaten in eine Map, die für JSON geeignet ist.
  Map<String, dynamic> toJson() {
    return {
      "stationName": stationName,
      "temperature": temperature,
      "windSpeed": windSpeed,
      "humidity": humidity,
      "pressure": pressure,
      "dewPoint": dewPoint,
      "visibility": visibility,
      "condition": condition,
      "icon": icon,
      "hourlyForecast": hourlyForecast.map((e) => e.toJson()).toList(),
      "dailyForecast": dailyForecast.map((e) => e.toJson()).toList(),
    };
  }

  /// Deserialisiert eine Map (aus JSON) in ein WeatherData-Objekt.
  factory WeatherData.fromJson(Map<String, dynamic> jsonMap) {
    return WeatherData(
      stationName: jsonMap['stationName'] as String,
      temperature: (jsonMap['temperature'] as num).toDouble(),
      windSpeed: (jsonMap['windSpeed'] as num).toDouble(),
      humidity: (jsonMap['humidity'] as num).toDouble(),
      pressure: (jsonMap['pressure'] as num).toDouble(),
      dewPoint: (jsonMap['dewPoint'] as num).toDouble(),
      visibility: (jsonMap['visibility'] as num).toDouble(),
      condition: jsonMap['condition'] as String,
      icon: jsonMap['icon'] as String,
      hourlyForecast: (jsonMap['hourlyForecast'] as List)
          .map((e) => HourlyWeatherData.fromJson(e as Map<String, dynamic>))
          .toList(),
      dailyForecast: (jsonMap['dailyForecast'] as List)
          .map((e) => DailyWeatherData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJsonString() => json.encode(toJson());

  factory WeatherData.fromJsonString(String source) =>
      WeatherData.fromJson(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherData(stationName: $stationName, temperature: $temperature, condition: $condition)';
  }
}
