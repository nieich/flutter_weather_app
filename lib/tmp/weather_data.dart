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

class WeatherDataList {
  final List<WeatherData> data = [];

  void addWeatherData(WeatherData weatherData) {
    data.add(weatherData);
  }
}

final WeatherDataList weatherDataList = WeatherDataList();

void addData() {
  weatherDataList.addWeatherData(
    WeatherData(
      stationName: 'Station A',
      temperature: 22.5,
      windSpeed: 5.0,
      humidity: 60.0,
      pressure: 1012.0,
      dewPoint: 18.0,
      visibility: 10.0,
      condition: 'Sunny',
      icon: 'clear-day',
      hourlyForecast: [
        HourlyWeatherData(
          time: '08:00',
          temperature: 20.0,
          windSpeed: 3.0,
          condition: 'Sunny',
          precipitationProbability: 10.0,
        ),
        HourlyWeatherData(
          time: '09:00',
          temperature: 25.0,
          windSpeed: 4.5,
          condition: 'Partly Cloudy',
          precipitationProbability: 5.0,
        ),
        HourlyWeatherData(
          time: '10:00',
          temperature: 23.0,
          windSpeed: 2.5,
          condition: 'Cloudy',
          precipitationProbability: 15.0,
        ),
        HourlyWeatherData(
          time: '11:00',
          temperature: 24.0,
          windSpeed: 3.5,
          condition: 'Sunny',
          precipitationProbability: 8.0,
        ),
        HourlyWeatherData(
          time: '12:00',
          temperature: 26.0,
          windSpeed: 5.0,
          condition: 'Sunny',
          precipitationProbability: 2.0,
        ),
        HourlyWeatherData(
          time: '13:00',
          temperature: 27.0,
          windSpeed: 6.0,
          condition: 'Sunny',
          precipitationProbability: 0.0,
        ),
      ],
      dailyForecast: [
        DailyWeatherData(day: DateTime.now().add(Duration(days: 1)), maxTemp: 24, minTemp: 15, condition: 'Sunny'),
        DailyWeatherData(
          day: DateTime.now().add(Duration(days: 2)),
          maxTemp: 22,
          minTemp: 14,
          condition: 'Partly Cloudy',
        ),
        DailyWeatherData(day: DateTime.now().add(Duration(days: 3)), maxTemp: 23, minTemp: 16, condition: 'Cloudy'),
        DailyWeatherData(day: DateTime.now().add(Duration(days: 4)), maxTemp: 20, minTemp: 13, condition: 'Rainy'),
        DailyWeatherData(day: DateTime.now().add(Duration(days: 5)), maxTemp: 25, minTemp: 17, condition: 'Sunny'),
        DailyWeatherData(day: DateTime.now().add(Duration(days: 6)), maxTemp: 26, minTemp: 18, condition: 'Sunny'),
        DailyWeatherData(
          day: DateTime.now().add(Duration(days: 7)),
          maxTemp: 24,
          minTemp: 16,
          condition: 'Partly Cloudy',
        ),
      ],
    ),
  );

  weatherDataList.addWeatherData(
    WeatherData(
      stationName: 'Station B',
      temperature: 18.3,
      windSpeed: 3.5,
      humidity: 55.0,
      pressure: 1015.0,
      dewPoint: 15.5,
      visibility: 12.0,
      condition: 'Cloudy',
      icon: 'clear-day',
      hourlyForecast: [
        HourlyWeatherData(
          time: '08:00',
          temperature: 17.0,
          windSpeed: 2.0,
          condition: 'Cloudy',
          precipitationProbability: 20.0,
        ),
        HourlyWeatherData(
          time: '12:00',
          temperature: 19.0,
          windSpeed: 3.0,
          condition: 'Partly Cloudy',
          precipitationProbability: 10.0,
        ),
        HourlyWeatherData(
          time: '16:00',
          temperature: 18.5,
          windSpeed: 4.0,
          condition: 'Rainy',
          precipitationProbability: 30.0,
        ),
      ],
    ),
  );
}
