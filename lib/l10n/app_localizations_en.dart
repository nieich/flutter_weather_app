// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Weather App';

  @override
  String get details => 'Details';

  @override
  String get temperature => 'Temperature';

  @override
  String get humidity => 'Humidity';

  @override
  String get windSpeed => 'Wind Speed';

  @override
  String get pressure => 'Pressure';

  @override
  String get dewPoint => 'Dew Point';

  @override
  String get visibility => 'Visibility';

  @override
  String get hourly => 'Hourly Forecast';

  @override
  String get dailyTemp => 'Daily Temperature Forecast';

  @override
  String get dailyPrecipitation => 'Daily Precipitation Forecast';

  @override
  String get settings => 'Settings';

  @override
  String get themeColor => 'Design Color';

  @override
  String get themeColorDescription => 'Choose a color for the app design';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';
}
