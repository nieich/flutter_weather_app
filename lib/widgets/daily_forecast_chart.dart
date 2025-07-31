import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/tmp/weather_data.dart';
import 'package:intl/intl.dart';

class DailyForecastChart extends StatelessWidget {
  final List<DailyWeatherData> dailyForecast;

  const DailyForecastChart({super.key, required this.dailyForecast});

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
      borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d))),
      minX: 0,
      maxX: (dailyForecast.length - 1).toDouble(),
      minY: 0,
      maxY: 35,
      lineBarsData: [
        LineChartBarData(
          spots: dailyForecast.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value.maxTemp);
          }).toList(),
          isCurved: true,
          gradient: const LinearGradient(colors: [Colors.cyan, Colors.blue]),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(colors: [Colors.cyan.withOpacity(0.3), Colors.blue.withOpacity(0.3)]),
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
