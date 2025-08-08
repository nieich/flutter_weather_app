import 'package:flutter/material.dart';
import 'package:flutter_weather_app/widgets/daily_forecast_precipitation_chart.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';
import 'package:flutter_weather_app/model/forecast_model.dart';
import 'package:flutter_weather_app/utils/weather_code_enum.dart';
import 'package:flutter_weather_app/widgets/daily_forecast_temp_chart.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

/// Formats the location name from a [Placemark] object for display.
String _formatLocation(Placemark? placemark) {
  if (placemark == null) return '...';
  // Prioritize city, then county, then state. Fallback to a generic message.
  return placemark.locality ?? placemark.subAdministrativeArea ?? placemark.administrativeArea ?? 'Unknown Location';
}

ListView buildWeatherView(
  BuildContext context,
  Forecast forecastData,
  Placemark? placemark,
  Size size,
  ThemeData theme,
) {
  final random = math.Random();
  final randomImageIndex = random.nextInt(2) + 1; // Zufällige Zahl zwischen 1 und 2
  final imagePath = WeatherCode.fromCode(
    forecastData.current?.weatherCode,
  ).assetPath.replaceAll('_X', '_$randomImageIndex');

  // Filter hourly data to show the next 24 hours starting from the current hour.
  final now = DateTime.now();
  final currentHour = DateTime(now.year, now.month, now.day, now.hour);
  final hourly = forecastData.hourly;
  List<int> hourlyIndices = [];

  if (hourly?.time != null && hourly!.time!.isNotEmpty) {
    // Find the index of the first forecast entry that is not before the current hour.
    final startIndex = hourly.time!.indexWhere((timeString) {
      return !DateTime.parse(timeString).isBefore(currentHour.add(const Duration(hours: 1)));
    });

    if (startIndex != -1) {
      final endIndex = math.min(startIndex + 24, hourly.time!.length);
      hourlyIndices = List.generate(endIndex - startIndex, (i) => startIndex + i);
    }
  }

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
            '${forecastData.current?.temperature2m}${forecastData.currentUnits?.temperature2m}',
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
      Row(children: [Text(_formatLocation(placemark), style: theme.textTheme.headlineSmall)]),
      Text(AppLocalizations.of(context)!.details),
      buildInfoTiles(context, forecastData, size, theme),
      SizedBox(height: 10),
      Text(AppLocalizations.of(context)!.hourly, style: TextStyle(fontSize: 18, color: theme.colorScheme.onSurface)),
      SizedBox(
        height: 160,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: hourlyIndices.length,
          itemBuilder: (context, i) {
            final index = hourlyIndices[i];
            final String time = DateFormat(
              "HH:mm",
              AppLocalizations.of(context)!.localeName,
            ).format(DateTime.parse(forecastData.hourly!.time![index]));
            final temperature = forecastData.hourly!.temperature2m![index];
            final precipitationProbability = forecastData.hourly!.precipitationProbability![index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Container(
                width: 100,
                decoration: BoxDecoration(color: theme.colorScheme.secondary, borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      time,
                      style: TextStyle(fontSize: 16, color: theme.colorScheme.onSecondary, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$precipitationProbability${forecastData.hourlyUnits?.precipitationProbability}',
                      style: TextStyle(color: Colors.blue),
                    ),
                    Icon(Icons.sunny, size: 32, color: theme.colorScheme.onSecondary),
                    Text(
                      '$temperature${forecastData.hourlyUnits?.temperature2m}',
                      style: TextStyle(fontSize: 18, color: theme.colorScheme.onSecondary),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      SizedBox(height: 10),
      Text(AppLocalizations.of(context)!.dailyTemp, style: TextStyle(fontSize: 18, color: theme.colorScheme.onSurface)),
      DailyForecastTempChart(dailyForecast: forecastData.daily!, dailyUnits: forecastData.dailyUnits!),
      Text(
        AppLocalizations.of(context)!.dailyPrecipitation,
        style: TextStyle(fontSize: 18, color: theme.colorScheme.onSurface),
      ),
      DailyForecastPrecipitaionChart(dailyForecast: forecastData.daily!),
    ],
  );
}

Column buildInfoTiles(BuildContext context, Forecast forecastData, Size size, ThemeData theme) {
  final index = forecastData.hourly?.time?.indexOf(DateFormat("yyyy-MM-dd'T'HH:00").format(DateTime.now()).toString());
  final visibilty = forecastData.hourly!.visibility?[index!];
  final surfacePressure = forecastData.hourly?.surfacePressure?[index!];

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildInfoTile(
            '${forecastData.current?.cloudCover} ${forecastData.currentUnits?.cloudCover}',
            AppLocalizations.of(context)!.cloudCover,
            size,
            theme,
          ),
          buildInfoTile(
            '${forecastData.current?.precipitation} ${forecastData.currentUnits?.precipitation}',
            AppLocalizations.of(context)!.precipitation,
            size,
            theme,
          ),
          buildInfoTile(
            '${forecastData.current?.relativeHumidity2m} ${forecastData.currentUnits?.relativeHumidity2m}',
            AppLocalizations.of(context)!.humidity,
            size,
            theme,
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildInfoTile(
            '${forecastData.current?.windSpeed10m} ${forecastData.currentUnits?.windSpeed10m}',
            AppLocalizations.of(context)!.windSpeed,
            size,
            theme,
          ),
          buildInfoTile(
            '$surfacePressure ${forecastData.hourlyUnits?.surfacePressure}',
            AppLocalizations.of(context)!.pressure,
            size,
            theme,
          ),
          buildInfoTile(
            '$visibilty ${forecastData.hourlyUnits?.visibility}',
            AppLocalizations.of(context)!.visibility,
            size,
            theme,
          ),
        ],
      ),
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
