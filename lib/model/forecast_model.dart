import 'dart:convert';

/// Contains the dart model classes for the Open-Meteo Forecast API.
///
/// This file defines classes to represent the JSON response,
/// including `Forecast`, `CurrentData`, `HourlyData` and their units.
/// The main class that encapsulates the entire API response.
class Forecast {
  final double latitude;
  final double longitude;
  final double generationtimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentUnits? currentUnits;
  final CurrentData? current;
  final HourlyUnits? hourlyUnits;
  final HourlyData? hourly;
  final DailyUnits? dailyUnits;
  final DailyData? daily;

  static const String apiUrlBase = 'https://api.open-meteo.com/v1/forecast';

  Forecast({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    this.currentUnits,
    this.current,
    this.hourlyUnits,
    this.hourly,
    this.dailyUnits,
    this.daily,
  });

  /// Creates a [Forecast] instance from a JSON map.
  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      generationtimeMs: (json['generationtime_ms'] as num).toDouble(),
      utcOffsetSeconds: json['utc_offset_seconds'] as int,
      timezone: json['timezone'] as String,
      timezoneAbbreviation: json['timezone_abbreviation'] as String,
      elevation: (json['elevation'] as num).toDouble(),
      currentUnits: json['current_units'] != null ? CurrentUnits.fromJson(json['current_units']) : null,
      current: json['current'] != null ? CurrentData.fromJson(json['current']) : null,
      hourlyUnits: json['hourly_units'] != null ? HourlyUnits.fromJson(json['hourly_units']) : null,
      hourly: json['hourly'] != null ? HourlyData.fromJson(json['hourly']) : null,
      dailyUnits: json['daily_units'] != null ? DailyUnits.fromJson(json['daily_units']) : null,
      daily: json['daily'] != null ? DailyData.fromJson(json['daily']) : null,
    );
  }

  /// Konvertiert die [Forecast]-Instanz in eine JSON-Map.
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'generationtime_ms': generationtimeMs,
      'utc_offset_seconds': utcOffsetSeconds,
      'timezone': timezone,
      'timezone_abbreviation': timezoneAbbreviation,
      'elevation': elevation,
      'current_units': currentUnits?.toJson(),
      'current': current?.toJson(),
      'hourly_units': hourlyUnits?.toJson(),
      'hourly': hourly?.toJson(),
      'daily_units': dailyUnits?.toJson(),
      'daily': daily?.toJson(),
    };
  }

  /// Konvertiert die [Forecast]-Instanz in einen JSON-String.
  String toJsonString() => json.encode(toJson());

  /// Erstellt eine [Forecast]-Instanz aus einem JSON-String.
  factory Forecast.fromJsonString(String jsonString) =>
      Forecast.fromJson(json.decode(jsonString) as Map<String, dynamic>);
}

/// Represents the units for the current weather data.
class CurrentUnits {
  final String? time;
  final String? interval;
  final String? temperature2m;
  final String? relativeHumidity2m;
  final String? precipitation;
  final String? windSpeed10m;
  final String? windDirection10m;
  final String? cloudCover;
  // Add further units here as nullable string if required.

  CurrentUnits({
    this.time,
    this.interval,
    this.temperature2m,
    this.relativeHumidity2m,
    this.precipitation,
    this.windSpeed10m,
    this.windDirection10m,
    this.cloudCover,
  });

  factory CurrentUnits.fromJson(Map<String, dynamic> json) {
    return CurrentUnits(
      time: json['time'] as String?,
      interval: json['interval'] as String?,
      temperature2m: json['temperature_2m'] as String?,
      relativeHumidity2m: json['relative_humidity_2m'] as String?,
      precipitation: json['precipitation'] as String?,
      windSpeed10m: json['wind_speed_10m'] as String?,
      windDirection10m: json['wind_direction_10m'] as String?,
      cloudCover: json['cloud_cover'] as String?,
    );
  }

  /// Konvertiert die [CurrentUnits]-Instanz in eine JSON-Map.
  Map<String, dynamic> toJson() {
    return {'time': time, 'interval': interval, 'temperature_2m': temperature2m, 'wind_speed_10m': windSpeed10m};
  }
}

/// Represents the current weather data.
class CurrentData {
  final String? time;
  final int? interval;
  final double? temperature2m;
  final int? relativeHumidity2m;
  final double? precipitation;
  final double? windSpeed10m;
  final int? windDirection10m;
  final int? cloudCover;
  // Add further data fields with the appropriate type here if required.

  CurrentData({
    this.time,
    this.interval,
    this.temperature2m,
    this.relativeHumidity2m,
    this.precipitation,
    this.windSpeed10m,
    this.windDirection10m,
    this.cloudCover,
  });

  factory CurrentData.fromJson(Map<String, dynamic> json) {
    return CurrentData(
      time: json['time'] as String?,
      interval: json['interval'] as int?,
      temperature2m: (json['temperature_2m'] as num?)?.toDouble(),
      relativeHumidity2m: json['relative_humidity_2m'] as int?,
      precipitation: (json['precipitation'] as num?)?.toDouble(),
      windSpeed10m: (json['wind_speed_10m'] as num?)?.toDouble(),
      windDirection10m: json['wind_direction_10m'] as int?,
      cloudCover: json['cloud_cover'] as int?,
    );
  }

  /// Konvertiert die [CurrentData]-Instanz in eine JSON-Map.
  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'interval': interval,
      'temperature_2m': temperature2m,
      'relative_humidity_2m': relativeHumidity2m,
      'precipitation': precipitation,
      'wind_speed_10m': windSpeed10m,
      'wind_direction_10m': windDirection10m,
      'cloud_cover': cloudCover,
    };
  }
}

/// Represents the units for the hourly forecast data.
class HourlyUnits {
  final String? time;
  final String? temperature2m;
  final String? precipitationProbability;
  // Add further units here as nullable string if required.

  HourlyUnits({this.time, this.temperature2m, this.precipitationProbability});

  /// Creates a [HourlyUnits] instance from a JSON map.
  factory HourlyUnits.fromJson(Map<String, dynamic> json) {
    return HourlyUnits(
      time: json['time'] as String?,
      temperature2m: json['temperature_2m'] as String?,
      precipitationProbability: json['precipitation_probability'] as String?,
    );
  }

  /// Converts the [HourlyUnits] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {'time': time, 'temperature_2m': temperature2m, 'precipitation_probability': precipitationProbability};
  }
}

/// Represents the hourly forecast data as lists.
class HourlyData {
  final List<String>? time;
  final List<double>? temperature2m;
  final List<int>? precipitationProbability;
  // Add further data fields here as a list with the appropriate type if required.

  HourlyData({this.time, this.temperature2m, this.precipitationProbability});

  /// Creates a [HourlyData] instance from a JSON map.
  factory HourlyData.fromJson(Map<String, dynamic> json) {
    return HourlyData(
      time: (json['time'] as List<dynamic>?)?.cast<String>().toList(),
      temperature2m: (json['temperature_2m'] as List<dynamic>?)?.cast<double>().toList(),
      precipitationProbability: (json['precipitation_probability'] as List<dynamic>?)?.cast<int>().toList(),
    );
  }

  /// Converts the [HourlyData] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {'time': time, 'temperature_2m': temperature2m, 'precipitation_probability': precipitationProbability};
  }
}

/// Repräsentiert die Einheiten für die täglichen Vorhersagedaten.
class DailyUnits {
  final String? time;
  final String? temperature2mMax;
  final String? temperature2mMin;
  // Füge hier bei Bedarf weitere Einheiten als nullable String hinzu.

  DailyUnits({this.time, this.temperature2mMax, this.temperature2mMin});

  factory DailyUnits.fromJson(Map<String, dynamic> json) {
    return DailyUnits(
      time: json['time'] as String?,
      temperature2mMax: json['temperature_2m_max'] as String?,
      temperature2mMin: json['temperature_2m_min'] as String?,
    );
  }

  /// Konvertiert die [DailyUnits]-Instanz in eine JSON-Map.
  Map<String, dynamic> toJson() {
    return {'time': time, 'temperature_2m_max': temperature2mMax, 'temperature_2m_min': temperature2mMin};
  }
}

/// Repräsentiert die täglichen Vorhersagedaten als Listen.
class DailyData {
  final List<String>? time;
  final List<double>? temperature2mMax;
  final List<double>? temperature2mMin;
  // Füge hier bei Bedarf weitere Datenfelder als Liste mit dem passenden Typ hinzu.

  DailyData({this.time, this.temperature2mMax, this.temperature2mMin});

  factory DailyData.fromJson(Map<String, dynamic> json) {
    return DailyData(
      time: (json['time'] as List<dynamic>?)?.cast<String>().toList(),
      temperature2mMax: (json['temperature_2m_max'] as List<dynamic>?)?.cast<double>().toList(),
      temperature2mMin: (json['temperature_2m_min'] as List<dynamic>?)?.cast<double>().toList(),
    );
  }

  /// Konvertiert die [DailyData]-Instanz in eine JSON-Map.
  Map<String, dynamic> toJson() {
    return {'time': time, 'temperature_2m_max': temperature2mMax, 'temperature_2m_min': temperature2mMin};
  }
}
