import 'package:flutter/material.dart';
import 'package:flutter_weather_app/tmp/weather_data.dart';
import 'package:flutter_weather_app/views/weather_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    if (weatherDataList.data.isEmpty) {
      addData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: buildWeatherView(weatherDataList.data.first, MediaQuery.of(context).size),
    );
  }
}
