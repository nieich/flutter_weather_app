import 'package:flutter/material.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';
import 'package:flutter_weather_app/pages/settings/color_scheme_picker.dart';
import 'package:flutter_weather_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsThemePage extends StatelessWidget {
  const SettingsThemePage({super.key});

  // A list of colors that the user can select
  static const List<Color> colorOptions = [
    // Shades of purple
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    // Shades of blue
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    // Shades of green
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    // shades of yellow/orange
    Colors.amber,
    Colors.orange,
    Colors.pink,
    Colors.red,
    Colors.cyan,
    //
    Colors.brown,
    Colors.blueGrey,
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(l10n.themeMode, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              return DropdownMenu<ThemeMode>(
                // Use LayoutBuilder to get the available width and make the menu expand.
                width: constraints.maxWidth,
                // This is the key property to ensure the menu always opens downwards.
                //position: DropdownMenuPosition.below,
                initialSelection: themeProvider.themeMode,
                onSelected: (ThemeMode? mode) {
                  if (mode != null) {
                    themeProvider.setThemeMode(mode);
                  }
                },
                // Convert the ThemeMode enum into a list of menu entries.
                dropdownMenuEntries: ThemeMode.values.map<DropdownMenuEntry<ThemeMode>>((ThemeMode mode) {
                  return DropdownMenuEntry<ThemeMode>(value: mode, label: _getThemeModeName(mode, l10n));
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            l10n.colorMode,
            style: Theme.of(context).textTheme.titleLarge,
          ), // You will need to add 'colorMode' to your .arb files
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              return DropdownMenu<ColorMode>(
                // Use LayoutBuilder to get the available width and make the menu expand.
                width: constraints.maxWidth,
                // This is the key property to ensure the menu always opens downwards.
                //position: DropdownMenuPosition.below,
                initialSelection: themeProvider.colorMode,
                onSelected: (ColorMode? mode) {
                  if (mode != null) {
                    themeProvider.setColorMode(mode);
                  }
                },
                // Convert the ThemeMode enum into a list of menu entries.
                dropdownMenuEntries: ColorMode.values.map<DropdownMenuEntry<ColorMode>>((ColorMode mode) {
                  return DropdownMenuEntry<ColorMode>(value: mode, label: _getColorModeName(mode, l10n));
                }).toList(),
              );
            },
          ),
          if (themeProvider.colorMode == ColorMode.seed) const ColorSchemePicker() else const IndividualColorPicker(),
        ],
      ),
    );
  }

  String _getThemeModeName(ThemeMode mode, AppLocalizations l10n) {
    // You will need to add the corresponding keys to your .arb files.
    switch (mode) {
      case ThemeMode.system:
        // e.g., "systemTheme": "System Default"
        return l10n.systemTheme;
      case ThemeMode.light:
        // e.g., "lightTheme": "Light"
        return l10n.lightTheme;
      case ThemeMode.dark:
        // e.g., "darkTheme": "Dark"
        return l10n.darkTheme;
    }
  }

  String _getColorModeName(ColorMode mode, AppLocalizations l10n) {
    // You will need to add the corresponding keys to your .arb files.
    switch (mode) {
      case ColorMode.seed:
        // e.g., "colorModeSeed": "From Color"
        return l10n.colorModeSeed;
      case ColorMode.individual:
        // e.g., "colorModeIndividual": "Individual"
        return l10n.colorModeIndividual;
    }
  }
}
