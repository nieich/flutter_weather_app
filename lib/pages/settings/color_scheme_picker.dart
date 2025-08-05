import 'package:flutter/material.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';
import 'package:flutter_weather_app/provider/theme_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

/// A widget that allows the user to pick a seed color for the app's theme.
class ColorSchemePicker extends StatelessWidget {
  const ColorSchemePicker({super.key});

  // A list of colors that the user can select.
  static const List<Color> _colorOptions = [
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
    //
    Colors.brown,
    Colors.blueGrey,
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(l10n.themeColor, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(l10n.themeColorDescription, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: _colorOptions.map((color) {
            final isSelected = themeProvider.seedColor == color;
            return GestureDetector(
              onTap: () => themeProvider.setSeedColor(color),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// A widget that allows picking individual colors for the light and dark themes.
class IndividualColorPicker extends StatelessWidget {
  const IndividualColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(l10n.individualColorModeDescription, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),

        // Light Theme Section
        Text(l10n.lightTheme, style: Theme.of(context).textTheme.titleMedium),
        const Divider(),
        _ColorPickerTile(
          title: l10n.primaryColor, // e.g., "Primary Color"
          currentColor: themeProvider.lightPrimary,
          onColorChanged: themeProvider.setLightPrimary,
        ),
        _ColorPickerTile(
          title: l10n.secondaryColor, // e.g., "Secondary Color"
          currentColor: themeProvider.lightSecondary,
          onColorChanged: themeProvider.setLightSecondary,
        ),
        _ColorPickerTile(
          title: l10n.surfaceColor, // e.g., "Surface Color"
          currentColor: themeProvider.lightSurface,
          onColorChanged: themeProvider.setLightSurface,
        ),
        _ColorPickerTile(
          title: l10n.onSurfaceColor, // e.g., "On Surface Color"
          currentColor: themeProvider.lightOnSurface,
          onColorChanged: themeProvider.setLightOnSurface,
        ),
        _ColorPickerTile(
          title: l10n.onPrimaryColor, // e.g., "On Primary Color"
          currentColor: themeProvider.lightOnPrimary,
          onColorChanged: themeProvider.setLightOnPrimary,
        ),
        _ColorPickerTile(
          title: l10n.onSecondaryColor, // e.g., "On Secondary Color"
          currentColor: themeProvider.lightOnSecondary,
          onColorChanged: themeProvider.setLightOnSecondary,
        ),
        _ColorPickerTile(
          title: l10n.errorColor, // e.g., "Error Color"
          currentColor: themeProvider.lightError,
          onColorChanged: themeProvider.setLightError,
        ),
        _ColorPickerTile(
          title: l10n.onErrorColor, // e.g., "On Error Color"
          currentColor: themeProvider.lightOnError,
          onColorChanged: themeProvider.setLightOnError,
        ),
        const SizedBox(height: 24),

        // Dark Theme Section
        Text(l10n.darkTheme, style: Theme.of(context).textTheme.titleMedium),
        const Divider(),
        _ColorPickerTile(
          title: l10n.primaryColor,
          currentColor: themeProvider.darkPrimary,
          onColorChanged: themeProvider.setDarkPrimary,
        ),
        _ColorPickerTile(
          title: l10n.onPrimaryColor,
          currentColor: themeProvider.darkOnPrimary,
          onColorChanged: themeProvider.setDarkOnPrimary,
        ),
        _ColorPickerTile(
          title: l10n.secondaryColor,
          currentColor: themeProvider.darkSecondary,
          onColorChanged: themeProvider.setDarkSecondary,
        ),
        _ColorPickerTile(
          title: l10n.onSecondaryColor,
          currentColor: themeProvider.darkOnSecondary,
          onColorChanged: themeProvider.setDarkOnSecondary,
        ),
        _ColorPickerTile(
          title: l10n.surfaceColor,
          currentColor: themeProvider.darkSurface,
          onColorChanged: themeProvider.setDarkSurface,
        ),
        _ColorPickerTile(
          title: l10n.onSurfaceColor,
          currentColor: themeProvider.darkOnSurface,
          onColorChanged: themeProvider.setDarkOnSurface,
        ),
        _ColorPickerTile(
          title: l10n.errorColor,
          currentColor: themeProvider.darkError,
          onColorChanged: themeProvider.setDarkError,
        ),
        _ColorPickerTile(
          title: l10n.onErrorColor,
          currentColor: themeProvider.darkOnError,
          onColorChanged: themeProvider.setDarkOnError,
        ),
      ],
    );
  }
}

/// A reusable tile widget for picking a single color.
/// It displays a title, the current color, and opens a dialog on tap.
class _ColorPickerTile extends StatelessWidget {
  const _ColorPickerTile({required this.title, required this.currentColor, required this.onColorChanged});

  final String title;
  final Color currentColor;
  final ValueChanged<Color> onColorChanged;

  void _showColorPicker(BuildContext context) {
    // A temporary variable to hold the color state inside the dialog.
    Color pickerColor = currentColor;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          // Use StatefulBuilder to create a stateful context within the stateless dialog.
          // This allows the content of the dialog to be updated in real-time.
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: (color) {
                  // Update the temporary color state when the user picks a new color.
                  setState(() => pickerColor = color);
                },
                pickerAreaHeightPercent: 0.8,
              );
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.cancel), // You'll need to add 'cancel' to your .arb files
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!.ok), // e.g., "OK"
            onPressed: () {
              onColorChanged(pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: currentColor,
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
      ),
      onTap: () => _showColorPicker(context),
    );
  }
}
