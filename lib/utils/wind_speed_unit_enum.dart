import 'package:flutter_weather_app/l10n/app_localizations.dart';

enum WindSpeedUnitEnum {
  kmh('kmh'),
  ms('ms'),
  mph('mph'),
  knots('kn');

  const WindSpeedUnitEnum(this.value);
  final String value;

  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case WindSpeedUnitEnum.kmh:
        return l10n.kilometerPerHour;
      case WindSpeedUnitEnum.ms:
        return l10n.meterPerSecond;
      case WindSpeedUnitEnum.mph:
        return l10n.milePerHour;
      case WindSpeedUnitEnum.knots:
        return l10n.knots;
    }
  }
}
