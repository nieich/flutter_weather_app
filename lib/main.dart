import 'package:flutter/material.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';
import 'package:flutter_weather_app/navigation/router.dart';
import 'package:flutter_weather_app/provider/theme_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  // Stellt sicher, dass die Plugin-Dienste initialisiert sind, bevor die App ausgeführt wird.
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('de', null);
  runApp(ChangeNotifierProvider(create: (context) => ThemeProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      title: 'Weather App',
      // 1. Definiere das helle Theme (Light Theme)
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: themeProvider.seedColor, brightness: Brightness.light),
        useMaterial3: true,
      ),
      // 2. Definiere das dunkle Theme (Dark Theme)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: themeProvider.seedColor, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      // 3. Sage Flutter, es soll das System-Theme verwenden
      themeMode: ThemeMode.system, // Dies könnte auch eine Einstellung sein
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
