import 'package:flutter_weather_app/l10n/app_localizations.dart';

enum PrecipitationUnitEnum {
  mm('mm'),
  inch('inch');

  const PrecipitationUnitEnum(this.value);
  final String value;

  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case PrecipitationUnitEnum.mm:
        return l10n.millimeter;
      case PrecipitationUnitEnum.inch:
        return l10n.inch;
    }
  }
}
