import 'package:flutter/material.dart';
import 'package:flutter_weather_app/l10n/app_localizations.dart';
import 'package:flutter_weather_app/navigation/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ScaffoldWithDrawer extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ScaffoldWithDrawer({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('ScaffoldWithDrawer'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat("HH:mm", AppLocalizations.of(context)!.localeName).format(DateTime.now()),
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {
              context.push(Routes.pathSettings);
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: navigationShell,
    );
  }
}
