// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get title => 'Wetter App';

  @override
  String get details => 'Details';

  @override
  String get temperature => 'Temperatur';

  @override
  String get humidity => 'Feuchtigkeit';

  @override
  String get windSpeed => 'Wind-\ngeschwindigkeit';

  @override
  String get pressure => 'Druck';

  @override
  String get dewPoint => 'Taupunkt';

  @override
  String get visibility => 'Sichtweite';

  @override
  String get hourly => 'Stündliche Vorhersage';

  @override
  String get dailyTemp => 'Temperaturvorhersage';

  @override
  String get dailyPrecipitation => 'Niederschlagsvorhersage';

  @override
  String get settings => 'Einstellungen';

  @override
  String get themeColor => 'Design-Farbe';

  @override
  String get themeColorDescription =>
      'Wähle eine Akzentfarbe, um das Farbschema der App zu generieren.';

  @override
  String get themeMode => 'Design-Modus';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Hell';

  @override
  String get darkTheme => 'Dunkel';

  @override
  String get colorMode => 'Color Mode';

  @override
  String get colorModeSeed => 'Seed-Farbe';

  @override
  String get colorModeIndividual => 'Individuelle Farbe';

  @override
  String get individualColorMode => 'Individual Color Mode';

  @override
  String get individualColorModeDescription =>
      'Select a custom color for each element in the app.';

  @override
  String get primaryColor => 'Primärfarbe';

  @override
  String get onPrimaryColor => 'Auf Primärfarbe';

  @override
  String get secondaryColor => 'Sekundärfarbe';

  @override
  String get onSecondaryColor => 'Auf Sekundärfarbe';

  @override
  String get surfaceColor => 'Oberflächenfarbe';

  @override
  String get onSurfaceColor => 'Auf Oberflächenfarbe';

  @override
  String get errorColor => 'Fehlerfarbe';

  @override
  String get onErrorColor => 'Auf Fehlerfarbe';

  @override
  String get theme => 'Theme';

  @override
  String get error => 'Fehler';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get pullDownToRefresh =>
      'Ziehen Sie nach unten, um die Wetterdaten zu aktualisieren.';

  @override
  String get noWeatherDataAvail => 'Keine Wetterdaten verfügbar.';

  @override
  String get weatherDataRefreshFailed =>
      'Aktualisierung der Wetterdaten fehlgeschlagen.';

  @override
  String get cloudCover => 'Cloud Cover';

  @override
  String get precipitation => 'Precipitation';
}
