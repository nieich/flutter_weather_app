import 'package:flutter/material.dart';
import 'package:flutter_weather_app/navigation/router.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // Initialisiere die Formatierungsdaten für Deutsch.
  await initializeDateFormatting('de', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Weather App',
      // 1. Definiere das helle Theme (Light Theme)
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.light),
        useMaterial3: true,
      ),
      // 2. Definiere das dunkle Theme (Dark Theme)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      // 3. Sage Flutter, es soll das System-Theme verwenden
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
