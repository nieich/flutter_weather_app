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
}
