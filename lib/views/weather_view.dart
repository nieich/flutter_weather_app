import 'package:flutter/material.dart';
import 'package:flutter_weather_app/tmp/weather_data.dart';
import 'package:flutter_weather_app/utils/weather_condition_enum.dart';
import 'package:flutter_weather_app/widgets/daily_forecast_chart.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

ListView buildWeatherView(WeatherData weatherData, Size size) {
  final random = math.Random();
  final randomImageIndex = random.nextInt(2) + 1; // Zufällige Zahl zwischen 1 und 2
  final imagePath = WeatherCondition.fromString(weatherData.icon).assetPath.replaceAll('_X', '_$randomImageIndex');

  return ListView(
    children: [
      Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${weatherData.temperature}°C', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        ],
      ),
      Row(
        children: [
          Text(
            DateFormat('EE, dd.MMM').format(DateTime.now()),
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            weatherData.stationName,
            style: const TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Text('Detail'),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: size.width * 0.3,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${weatherData.temperature}°C', style: const TextStyle(fontSize: 18, color: Colors.black54)),
                    const SizedBox(height: 5),
                    Text('Temperature', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              ),
              Container(
                height: size.width * 0.3,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${weatherData.windSpeed} m/s', style: const TextStyle(fontSize: 18, color: Colors.black54)),
                    const SizedBox(height: 5),
                    Text('Wind Speed', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              ),
              Container(
                height: size.width * 0.3,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${weatherData.humidity}%', style: const TextStyle(fontSize: 18, color: Colors.black54)),
                    const SizedBox(height: 5),
                    Text('Humidity', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: size.width * 0.3,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${weatherData.pressure} hPa', style: const TextStyle(fontSize: 18, color: Colors.black54)),
                    const SizedBox(height: 5),
                    Text('Pressure', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              ),
              Container(
                height: size.width * 0.3,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${weatherData.dewPoint}°C', style: const TextStyle(fontSize: 18, color: Colors.black54)),
                    const SizedBox(height: 5),
                    Text('Dew Point', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              ),
              Container(
                height: size.width * 0.3,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${weatherData.visibility} km', style: const TextStyle(fontSize: 18, color: Colors.black54)),
                    const SizedBox(height: 5),
                    Text('Visibility', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      SizedBox(height: 10),
      Text('Stündlich', style: const TextStyle(fontSize: 18)),
      SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: weatherData.hourlyForecast.length,
          itemBuilder: (context, index) {
            final hourlyData = weatherData.hourlyForecast[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Container(
                width: 100,
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(hourlyData.time, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Icon(Icons.wb_sunny, size: 32, color: Colors.orangeAccent), // Platzhalter-Icon
                    Text('${hourlyData.temperature}°C', style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      SizedBox(height: 10),
      DailyForecastChart(dailyForecast: weatherData.dailyForecast),
    ],
  );
}
