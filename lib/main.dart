import 'package:flutter/material.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';
import 'package:flutter_weather_app/navigation/router.dart';
import 'package:flutter_weather_app/provider/theme_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensures that the plugin services are initialized before the app is executed.
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('de', null);
  runApp(ChangeNotifierProvider(create: (context) => ThemeProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Dieses Widget ist die Wurzel Ihrer Anwendung.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      title: 'Weather App',
      // 1. define the light theme (Light Theme)
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: themeProvider.seedColor, brightness: Brightness.light),
        useMaterial3: true,
      ),
      // 2. define the dark theme (Dark Theme)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: themeProvider.seedColor, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      // 3. sage flutter, it should use the system theme
      themeMode: themeProvider.themeMode, // This could also be a setting
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
