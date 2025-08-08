import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';
import 'package:flutter_weather_app/model/forecast_model.dart';
import 'package:intl/intl.dart';

class DailyForecastTempChart extends StatelessWidget {
  final DailyData dailyForecast;
  final DailyUnits dailyUnits;

  const DailyForecastTempChart({super.key, required this.dailyForecast, required this.dailyUnits});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color(0xff232d37),
        child: Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 12, left: 8, right: 20),
          child: LineChart(mainData(context)),
        ),
      ),
    );
  }

  LineChartData mainData(BuildContext context) {
    // Ensure we have data to draw. If not, return an empty chart.
    final timeList = dailyForecast.time;
    final minTemps = dailyForecast.temperature2mMin;
    final maxTemps = dailyForecast.temperature2mMax;

    if (timeList == null || timeList.isEmpty || minTemps == null || maxTemps == null) {
      return LineChartData(); // Return empty data to avoid errors
    }

    final int dayCount = timeList.length;

    // Find the min and max temperatures from the forecast lists.
    final double minTemp = minTemps.reduce(math.min);
    final double maxTemp = maxTemps.reduce(math.max);

    // Round the Y-axis boundaries to the nearest increment of 5 to ensure a clean display.
    // Also add a small padding so that the lines are not directly on the edge.
    final double minY = ((minTemp - 2) / 5).floor() * 5.0;
    final double maxYCandidate = ((maxTemp + 2) / 5).ceil() * 5.0;
    // Ensure a minimum span of 10 so that the graph does not look too "flat".
    const double minSpan = 10.0;
    final double maxY = (maxYCandidate - minY) < minSpan ? minY + minSpan : maxYCandidate;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 5,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(color: Color(0xff37434d), strokeWidth: 1);
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(color: Color(0xff37434d), strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta, context, timeList),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, interval: 5, getTitlesWidget: leftTitleWidgets, reservedSize: 42),
        ),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((spot) {
              final index = spot.x.toInt();
              // The spot's `barIndex` tells us if it's the max (0) or min (1) temp line.
              if (spot.barIndex == 0) {
                final temp = maxTemps[index];
                return LineTooltipItem(
                  'max $temp${dailyUnits.temperature2mMax}',
                  const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                );
              } else {
                final temp = minTemps[index];
                return LineTooltipItem(
                  'min $temp${dailyUnits.temperature2mMin}',
                  const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                );
              }
            }).toList();
          },
        ),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d))),
      minX: 0,
      maxX: (dayCount - 1).toDouble(),
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(dayCount, (index) => FlSpot(index.toDouble(), maxTemps[index])),
          isCurved: true,
          gradient: const LinearGradient(colors: [Colors.red, Colors.orange]),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(colors: [Colors.orange.withValues(alpha: 0.3), Colors.red.withValues(alpha: 0.3)]),
          ),
        ),
        LineChartBarData(
          spots: List.generate(dayCount, (index) => FlSpot(index.toDouble(), minTemps[index])),
          isCurved: true,
          gradient: const LinearGradient(colors: [Colors.greenAccent, Colors.green]),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [Colors.greenAccent.withValues(alpha: 0.3), Colors.green.withValues(alpha: 0.3)],
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, BuildContext context, List<String> timeList) {
    final dayString = timeList[value.toInt()];
    final day = DateTime.parse(dayString);
    return SideTitleWidget(
      meta: meta,
      space: 8.0,
      child: Text(
        DateFormat('E', AppLocalizations.of(context)!.localeName).format(day),
        style: const TextStyle(color: Colors.white70, fontSize: 12),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final unit = dailyUnits.temperature2mMax ?? '°C';
    return Text(
      '${value.toInt()}$unit',
      style: const TextStyle(color: Colors.white70, fontSize: 12),
      textAlign: TextAlign.left,
    );
  }
}
