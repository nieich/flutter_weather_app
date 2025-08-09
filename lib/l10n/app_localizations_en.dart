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

  @override
  String get colorMode => 'Color Mode';

  @override
  String get colorModeSeed => 'Seed Color';

  @override
  String get colorModeIndividual => 'Individual Color';

  @override
  String get individualColorMode => 'Individual Color Mode';

  @override
  String get individualColorModeDescription =>
      'Select a custom color for each element in the app.';

  @override
  String get primaryColor => 'Primary Color';

  @override
  String get onPrimaryColor => 'On Primary Color';

  @override
  String get secondaryColor => 'Secondary Color';

  @override
  String get onSecondaryColor => 'On Secondary Color';

  @override
  String get surfaceColor => 'Surface Color';

  @override
  String get onSurfaceColor => 'On Surface Color';

  @override
  String get errorColor => 'Error Color';

  @override
  String get onErrorColor => 'On Error Color';

  @override
  String get theme => 'Theme';

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get pullDownToRefresh => 'Pull down to refresh the weather data.';

  @override
  String get noWeatherDataAvail => 'No weather data available.';

  @override
  String get weatherDataRefreshFailed => 'Failed to refresh weather data.';

  @override
  String get cloudCover => 'Cloud Cover';

  @override
  String get precipitation => 'Precipitation';

  @override
  String pleaseWaitSeconds(int seconds) {
    return 'Please wait $seconds seconds before refreshing again.';
  }

  @override
  String get celsius => 'Celsius';

  @override
  String get fahrenheit => 'Fahrenheit';

  @override
  String get millimeter => 'Millimeter';

  @override
  String get inch => 'Inch';

  @override
  String get kilometerPerHour => 'Kilometer per Hour';

  @override
  String get meterPerSecond => 'Meter per Second';

  @override
  String get milePerHour => 'Mile per Hour';

  @override
  String get knots => 'Knots';

  @override
  String get unitInfo => 'Changes will take affect with next data refresh';
}
