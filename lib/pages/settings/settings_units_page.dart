import 'package:flutter/material.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';

class SettingsUnitPage extends StatelessWidget {
  const SettingsUnitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: Center(child: Text('UNIT')),
    );
  }
}
