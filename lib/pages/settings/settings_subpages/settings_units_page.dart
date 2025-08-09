import 'package:flutter/material.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';
import 'package:flutter_weather_app/provider/unit_provider.dart';
import 'package:flutter_weather_app/utils/precipitation_unit_enum.dart';
import 'package:flutter_weather_app/utils/temperature_unit_enum.dart';
import 'package:flutter_weather_app/utils/wind_speed_unit_enum.dart';
import 'package:provider/provider.dart';

class SettingsUnitPage extends StatelessWidget {
  const SettingsUnitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final unitProvider = Provider.of<UnitProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: const Text('Units')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Temperature Unit Dropdown
          _buildUnitDropdown<TemperatureUnitEnum>(
            context: context,
            label: l10n.temperature,
            initialSelection: unitProvider.temperatureUnit,
            values: TemperatureUnitEnum.values,
            getLabel: (unit) => unit.getLabel(l10n),
            onSelected: (TemperatureUnitEnum? unit) {
              if (unit != null) {
                unitProvider.setTemperatureUnit(unit);
              }
            },
          ),
          // Wind Speed Unit Dropdown
          _buildUnitDropdown<WindSpeedUnitEnum>(
            context: context,
            label: l10n.windSpeed,
            initialSelection: unitProvider.windSpeedUnit,
            values: WindSpeedUnitEnum.values,
            getLabel: (unit) => unit.getLabel(l10n),
            onSelected: (WindSpeedUnitEnum? unit) {
              if (unit != null) {
                unitProvider.setWindSpeedUnit(unit);
              }
            },
          ),
          // Precipitation Unit Dropdown
          _buildUnitDropdown<PrecipitationUnitEnum>(
            context: context,
            label: l10n.precipitation,
            initialSelection: unitProvider.precipitationUnit,
            values: PrecipitationUnitEnum.values,
            getLabel: (unit) => unit.getLabel(l10n),
            onSelected: (PrecipitationUnitEnum? unit) {
              if (unit != null) {
                unitProvider.setPrecipitationUnit(unit);
              }
            },
          ),
          const SizedBox(height: 16),
          Text(
            l10n.unitInfo,
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.error, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  // A generic helper method to build a dropdown for any unit enum.
  Widget _buildUnitDropdown<T extends Enum>({
    required BuildContext context,
    required String label,
    required T initialSelection,
    required List<T> values,
    required String Function(T) getLabel,
    required void Function(T?) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            return DropdownMenu<T>(
              width: constraints.maxWidth,
              initialSelection: initialSelection,
              onSelected: onSelected,
              dropdownMenuEntries: values.map<DropdownMenuEntry<T>>((T value) {
                return DropdownMenuEntry<T>(value: value, label: getLabel(value));
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
