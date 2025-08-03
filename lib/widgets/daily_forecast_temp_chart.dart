import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/model/weather_model.dart';
import 'package:intl/intl.dart';

class DailyForecastTempChart extends StatelessWidget {
  final List<DailyWeatherData> dailyForecast;

  const DailyForecastTempChart({super.key, required this.dailyForecast});

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
          child: LineChart(mainData()),
        ),
      ),
    );
  }

  LineChartData mainData() {
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
          sideTitles: SideTitles(showTitles: true, reservedSize: 30, interval: 1, getTitlesWidget: bottomTitleWidgets),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, interval: 5, getTitlesWidget: leftTitleWidgets, reservedSize: 42),
        ),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            bool first = true;
            return touchedSpots.map((spot) {
              if (first) {
                first = false;
                final temp = dailyForecast[spot.x.toInt()].maxTemp;
                return LineTooltipItem('$temp°C', const TextStyle(color: Colors.red));
              } else {
                final temp = dailyForecast[spot.x.toInt()].minTemp;
                return LineTooltipItem('$temp°C', const TextStyle(color: Colors.green));
              }
            }).toList();
          },
        ),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d))),
      minX: 0,
      maxX: (dailyForecast.length - 1).toDouble(),
      minY: -10,
      maxY: 35,
      lineBarsData: [
        LineChartBarData(
          spots: dailyForecast.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value.maxTemp);
          }).toList(),
          isCurved: true,
          gradient: const LinearGradient(colors: [Colors.red, Colors.red]),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(colors: [Colors.red.withValues(alpha: 0.3), Colors.red.withValues(alpha: 0.3)]),
          ),
        ),
        LineChartBarData(
          spots: dailyForecast.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value.minTemp);
          }).toList(),
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final day = dailyForecast[value.toInt()].day;
    return SideTitleWidget(
      meta: meta,
      child: Text(DateFormat('E').format(day), style: const TextStyle(color: Colors.white70, fontSize: 12)),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(
      '${value.toInt()}°',
      style: const TextStyle(color: Colors.white70, fontSize: 12),
      textAlign: TextAlign.left,
    );
  }
}
