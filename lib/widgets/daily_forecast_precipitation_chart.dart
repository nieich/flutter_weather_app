import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/model/forecast_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';

class DailyForecastPrecipitaionChart extends StatelessWidget {
  final DailyData dailyForecast;
  final DailyUnits dailyUnits;

  const DailyForecastPrecipitaionChart({super.key, required this.dailyForecast, required this.dailyUnits});

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
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 10,
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
            getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta, context),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, interval: 10, getTitlesWidget: leftTitleWidgets, reservedSize: 42),
        ),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((spot) {
              final precipitation = dailyForecast.maxPrecipitationProbability[spot.x.toInt()];
              return LineTooltipItem('$precipitation%', const TextStyle(color: Colors.white));
            }).toList();
          },
        ),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d))),
      minX: 0,
      maxX: (dailyForecast.time.length - 1).toDouble(),
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: dailyForecast.maxPrecipitationProbability.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value.toDouble());
          }).toList(),
          isCurved: true,
          gradient: const LinearGradient(colors: [Colors.cyan, Colors.blue]),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(colors: [Colors.cyan.withValues(alpha: 0.3), Colors.blue.withValues(alpha: 0.3)]),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    final day = DateFormat("D", AppLocalizations.of(context)!.localeName).parse(dailyForecast.time[value.toInt()]);
    final locale = AppLocalizations.of(context)!.localeName;
    return SideTitleWidget(
      meta: meta,
      child: Text(DateFormat('E', locale).format(day), style: const TextStyle(color: Colors.white70, fontSize: 12)),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(
      '${value.toInt()}${dailyUnits.maxPrecipitationProbability}',
      style: const TextStyle(color: Colors.white70, fontSize: 12),
      textAlign: TextAlign.left,
    );
  }
}
