import 'package:flutter/material.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';
import 'package:flutter_weather_app/navigation/router.dart';
import 'package:flutter_weather_app/provider/theme_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensures that the plugin services are initialized before the app is executed.
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

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
      onGenerateTitle: (context) {
        // This context is a descendant of MaterialApp and has access to AppLocalizations.
        final l10n = AppLocalizations.of(context)!;
        return l10n.title;
      },
      // 1. define the light theme (Light Theme)
      theme: ThemeData(brightness: Brightness.light, colorScheme: themeProvider.lightColorScheme, useMaterial3: true),
      // 2. define the dark theme (Dark Theme)
      darkTheme: ThemeData(brightness: Brightness.dark, colorScheme: themeProvider.darkColorScheme, useMaterial3: true),
      // 3. sage flutter, it should use the system theme
      themeMode: themeProvider.themeMode, // This could also be a setting
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
