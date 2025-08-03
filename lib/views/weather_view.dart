import 'package:flutter/material.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';
import 'package:flutter_weather_app/utils/weather_condition_enum.dart';
import 'package:flutter_weather_app/widgets/daily_forecast_precipitation_chart.dart';
import 'package:flutter_weather_app/widgets/daily_forecast_temp_chart.dart';
import 'package:flutter_weather_app/utils/hourly_weather_condition_enum.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

ListView buildWeatherView(BuildContext context, weatherData, Size size, ThemeData theme) {
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
          Text(
            '${weatherData.temperature}°C',
            style: TextStyle(fontSize: 40, color: theme.colorScheme.onSurface, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            DateFormat('EE, dd.MMM', AppLocalizations.of(context)!.localeName).format(DateTime.now()),
            style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurface),
          ),
        ],
      ),
      Row(children: [Text(weatherData.stationName, style: theme.textTheme.headlineSmall)]),
      Text(AppLocalizations.of(context)!.details),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildInfoTile('${weatherData.temperature}°C', AppLocalizations.of(context)!.temperature, size, theme),
              buildInfoTile('${weatherData.windSpeed} m/s', AppLocalizations.of(context)!.windSpeed, size, theme),
              buildInfoTile('${weatherData.humidity}%', AppLocalizations.of(context)!.humidity, size, theme),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildInfoTile('${weatherData.pressure} hPa', AppLocalizations.of(context)!.pressure, size, theme),
              buildInfoTile('${weatherData.dewPoint}°C', AppLocalizations.of(context)!.dewPoint, size, theme),
              buildInfoTile(
                '${weatherData.visibility.toStringAsFixed(2)} km',
                AppLocalizations.of(context)!.visibility,
                size,
                theme,
              ),
            ],
          ),
        ],
      ),
      SizedBox(height: 10),
      Text(AppLocalizations.of(context)!.hourly, style: TextStyle(fontSize: 18, color: theme.colorScheme.onSurface)),
      SizedBox(
        height: 160,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: weatherData.hourlyForecast.length,
          itemBuilder: (context, index) {
            final hourlyData = weatherData.hourlyForecast[index];
            final hourlyCondition = HourlyWeatherCondition.fromString(hourlyData.condition);
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Container(
                width: 100,
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      hourlyData.time,
                      style: TextStyle(fontSize: 16, color: theme.colorScheme.onSurface, fontWeight: FontWeight.bold),
                    ),
                    Text('${hourlyData.precipitationProbability}%', style: TextStyle(color: Colors.blue)),
                    Icon(hourlyCondition.icon, size: 32, color: theme.colorScheme.primary),
                    Text('${hourlyData.temperature}°C', style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      SizedBox(height: 10),
      Text(AppLocalizations.of(context)!.dailyTemp, style: TextStyle(fontSize: 18, color: theme.colorScheme.onSurface)),
      DailyForecastTempChart(dailyForecast: weatherData.dailyForecast),
      Text(
        AppLocalizations.of(context)!.dailyPrecipitation,
        style: TextStyle(fontSize: 18, color: theme.colorScheme.onSurface),
      ),
      DailyForecastPrecipitaionChart(dailyForecast: weatherData.dailyForecast),
    ],
  );
}

Container buildInfoTile(String upperTxt, String lowerTxt, Size size, ThemeData theme) {
  return Container(
    height: size.width * 0.3,
    width: size.width * 0.3,
    decoration: BoxDecoration(
      border: Border.all(color: theme.colorScheme.onSurface),
      borderRadius: BorderRadius.circular(8.0),
    ),
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          upperTxt,
          style: TextStyle(fontSize: 18, color: theme.colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        Text(
          lowerTxt,
          style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
