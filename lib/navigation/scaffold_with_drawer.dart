import 'package:flutter/material.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithDrawer extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ScaffoldWithDrawer({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('ScaffoldWithDrawer'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.title,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: navigationShell,
    );
  }
}
