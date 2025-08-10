import 'dart:convert';

/// Contains the dart model classes for the Open-Meteo Forecast API.
///
/// This file defines classes to represent the JSON response,
/// including `Forecast`, `CurrentData`, `HourlyData` and their units.
/// The main class that encapsulates the entire API response.
class Forecast {
  // Represents the latitude and longitude of the location.
  final double latitude;
  final double longitude;
  // Represents the time taken to generate the response in milliseconds.
  final double generationtimeMs;
  // Represents the UTC offset in seconds.
  final int utcOffsetSeconds;
  // Represents the timezone of the location.
  final String timezone;
  // Represents the timezone abbreviation.
  final String timezoneAbbreviation;
  // Represents the elevation of the location in meters.
  final double elevation;
  // Optional fields for current, hourly, and daily data.
  final CurrentUnits currentUnits;

  /// Represents the current weather data.
  final CurrentData current;

  /// Represents the units for the hourly forecast data.
  final HourlyUnits hourlyUnits;

  /// Represents the hourly forecast data.
  final HourlyData hourly;

  /// Represents the units for the daily forecast data.
  final DailyUnits dailyUnits;

  /// Represents the daily forecast data.
  final DailyData daily;

  static const String apiUrlBase = 'https://api.open-meteo.com/v1/forecast';

  Forecast({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentUnits,
    required this.current,
    required this.hourlyUnits,
    required this.hourly,
    required this.dailyUnits,
    required this.daily,
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
      currentUnits: CurrentUnits.fromJson(json['current_units']),
      current: CurrentData.fromJson(json['current']),
      hourlyUnits: HourlyUnits.fromJson(json['hourly_units']),
      hourly: HourlyData.fromJson(json['hourly']),
      dailyUnits: DailyUnits.fromJson(json['daily_units']),
      daily: DailyData.fromJson(json['daily']),
    );
  }

  /// Converts the [Forecast] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'generationtime_ms': generationtimeMs,
      'utc_offset_seconds': utcOffsetSeconds,
      'timezone': timezone,
      'timezone_abbreviation': timezoneAbbreviation,
      'elevation': elevation,
      'current_units': currentUnits.toJson(),
      'current': current.toJson(),
      'hourly_units': hourlyUnits.toJson(),
      'hourly': hourly.toJson(),
      'daily_units': dailyUnits.toJson(),
      'daily': daily.toJson(),
    };
  }

  /// Converts the [Forecast] instance into a JSON string.
  String toJsonString() => json.encode(toJson());

  /// Creates a [Forecast] instance from a JSON string.
  factory Forecast.fromJsonString(String jsonString) =>
      Forecast.fromJson(json.decode(jsonString) as Map<String, dynamic>);
}

/// Represents the units for the current weather data.
class CurrentUnits {
  final String time;
  final String interval;
  final String temperature2m;
  final String relativeHumidity2m;
  final String precipitation;
  final String windSpeed10m;
  final String windDirection10m;
  final String cloudCover;
  // Add further units here as nullable string if required.

  CurrentUnits({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.precipitation,
    required this.windSpeed10m,
    required this.windDirection10m,
    required this.cloudCover,
  });

  factory CurrentUnits.fromJson(Map<String, dynamic> json) {
    return CurrentUnits(
      time: json['time'] as String,
      interval: json['interval'] as String,
      temperature2m: json['temperature_2m'] as String,
      relativeHumidity2m: json['relative_humidity_2m'] as String,
      precipitation: json['precipitation'] as String,
      windSpeed10m: json['wind_speed_10m'] as String,
      windDirection10m: json['wind_direction_10m'] as String,
      cloudCover: json['cloud_cover'] as String,
    );
  }

  /// Konvertiert die [CurrentUnits]-Instanz in eine JSON-Map.
  Map<String, dynamic> toJson() {
    return {'time': time, 'interval': interval, 'temperature_2m': temperature2m, 'wind_speed_10m': windSpeed10m};
  }
}

/// Represents the current weather data.
class CurrentData {
  // Represents the time of the current data.
  final String time;
  // Represents the interval of the current data in [CurrentUnits.interval].
  final int interval;
  // Represents the wmo code
  final int weatherCode;
  // Represents the temperature at 2 meters above ground level.
  final double temperature2m;
  // Represents the relative humidity at 2 meters above ground level.
  final int relativeHumidity2m;
  // Represents the precipitation amount.
  final double precipitation;
  // Represents the wind speed at 10 meters above ground level.
  final double windSpeed10m;
  // Represents the wind direction at 10 meters above ground level.
  final int windDirection10m;
  // Represents the cloud cover.
  final int cloudCover;
  // Add further data fields with the appropriate type here if required.

  CurrentData({
    required this.time,
    required this.interval,
    required this.weatherCode,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.precipitation,
    required this.windSpeed10m,
    required this.windDirection10m,
    required this.cloudCover,
  });

  factory CurrentData.fromJson(Map<String, dynamic> json) {
    return CurrentData(
      time: json['time'] as String,
      interval: json['interval'] as int,
      weatherCode: json['wmo_code'] as int,
      temperature2m: (json['temperature_2m'] as num).toDouble(),
      relativeHumidity2m: json['relative_humidity_2m'] as int,
      precipitation: (json['precipitation'] as num).toDouble(),
      windSpeed10m: (json['wind_speed_10m'] as num).toDouble(),
      windDirection10m: json['wind_direction_10m'] as int,
      cloudCover: json['cloud_cover'] as int,
    );
  }

  /// Converts the [CurrentData] instance into a JSON map.
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
  final String time;
  final String temperature2m;
  final String precipitationProbability;
  final String visibility;
  final String surfacePressure;
  // Add further units here as nullable string if required.

  HourlyUnits({
    required this.time,
    required this.temperature2m,
    required this.precipitationProbability,
    required this.visibility,
    required this.surfacePressure,
  });

  /// Creates a [HourlyUnits] instance from a JSON map.
  factory HourlyUnits.fromJson(Map<String, dynamic> json) {
    return HourlyUnits(
      time: json['time'] as String,
      temperature2m: json['temperature_2m'] as String,
      precipitationProbability: json['precipitation_probability'] as String,
      visibility: json['visibility'] as String,
      surfacePressure: json['surface_pressure'] as String,
    );
  }

  /// Converts the [HourlyUnits] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {'time': time, 'temperature_2m': temperature2m, 'precipitation_probability': precipitationProbability};
  }
}

/// Represents the hourly forecast data as lists.
class HourlyData {
  // Represents the time of the hourly data.
  final List<String> time;
  // Represents the temperature at 2 meters above ground level as a list.
  final List<double> temperature2m;
  // Represents the precipitation probability as a list.
  final List<int> precipitationProbability;
  // Represents the visibility
  final List<double> visibility;
  // Represents the surface pressure
  final List<double> surfacePressure;

  HourlyData({
    required this.time,
    required this.temperature2m,
    required this.precipitationProbability,
    required this.visibility,
    required this.surfacePressure,
  });

  /// Creates a [HourlyData] instance from a JSON map.
  factory HourlyData.fromJson(Map<String, dynamic> json) {
    return HourlyData(
      time: (json['time'] as List<dynamic>).cast<String>().toList(),
      temperature2m: (json['temperature_2m'] as List<dynamic>).cast<double>().toList(),
      precipitationProbability: (json['precipitation_probability'] as List<dynamic>).cast<int>().toList(),
      visibility: (json['visibility'] as List<dynamic>).cast<double>().toList(),
      surfacePressure: (json['surface_pressure'] as List<dynamic>).cast<double>().toList(),
    );
  }

  /// Converts the [HourlyData] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m': temperature2m,
      'precipitation_probability': precipitationProbability,
      'visibility': visibility,
      'surface_pressure': surfacePressure,
    };
  }
}

/// Represents the units for the daily forecast data.
class DailyUnits {
  final String time;
  final String temperature2mMax;
  final String temperature2mMin;
  final String maxPrecipitationProbability;

  DailyUnits({
    required this.time,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.maxPrecipitationProbability,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) {
    return DailyUnits(
      time: json['time'] as String,
      temperature2mMax: json['temperature_2m_max'] as String,
      temperature2mMin: json['temperature_2m_min'] as String,
      maxPrecipitationProbability: json['precipitation_probability_max'] as String,
    );
  }

  /// Converts the [DailyUnits] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m_max': temperature2mMax,
      'temperature_2m_min': temperature2mMin,
      'precipitation_probability_max': maxPrecipitationProbability,
    };
  }
}

/// Represents the daily forecast data as lists.
class DailyData {
  final List<String> time;
  final List<double> temperature2mMax;
  final List<double> temperature2mMin;
  final List<int> maxPrecipitationProbability;

  DailyData({
    required this.time,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.maxPrecipitationProbability,
  });

  factory DailyData.fromJson(Map<String, dynamic> json) {
    return DailyData(
      time: (json['time'] as List<dynamic>).cast<String>().toList(),
      temperature2mMax: (json['temperature_2m_max'] as List<dynamic>).cast<double>().toList(),
      temperature2mMin: (json['temperature_2m_min'] as List<dynamic>).cast<double>().toList(),
      maxPrecipitationProbability: (json['precipitation_probability_max'] as List<dynamic>).cast<int>().toList(),
    );
  }

  /// Converts the [DailyData] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m_max': temperature2mMax,
      'temperature_2m_min': temperature2mMin,
      'precipitation_probability_max': maxPrecipitationProbability,
    };
  }
}
