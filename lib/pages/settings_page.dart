import 'package:flutter/material.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';
import 'package:flutter_weather_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    // A list of colors that the user can select
    final List<Color> colorOptions = [
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

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(l10n.themeColor, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(l10n.themeColorDescription, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: colorOptions.map((color) {
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
      ),
    );
  }
}
