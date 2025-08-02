import 'package:flutter/material.dart';
import 'package:flutter_weather_app/navigation/routes.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithDrawer extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ScaffoldWithDrawer({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('ScaffoldWithDrawer'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App'), backgroundColor: Theme.of(context).colorScheme.primary),
      body: navigationShell,
    );
  }
}
