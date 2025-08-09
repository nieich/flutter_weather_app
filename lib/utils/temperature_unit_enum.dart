import 'package:flutter_weather_app/l10n/app_localizations.dart';

enum TemperatureUnitEnum {
  celsius('celsius'),
  fahrenheit('fahrenheit');

  const TemperatureUnitEnum(this.value);
  final String value;

  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case TemperatureUnitEnum.celsius:
        return l10n.celsius;
      case TemperatureUnitEnum.fahrenheit:
        return l10n.fahrenheit;
    }
  }
}
