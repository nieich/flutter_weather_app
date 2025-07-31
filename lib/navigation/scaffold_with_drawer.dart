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
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Menü', style: TextStyle(color: Colors.white, fontSize: 24)),
                  const Spacer(),

                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Drawer schließen
                      context.go(Routes.settings); // Zur Route navigieren
                    },
                    child: const Icon(Icons.settings, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('City 1'),
              onTap: () {
                Navigator.of(context).pop(); // Drawer schließen
                context.go('/a'); // Zur Route navigieren
              },
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('City 2'),
              onTap: () {
                Navigator.of(context).pop();
                context.go('/b');
              },
            ),
          ],
        ),
      ),
      body: navigationShell,
    );
  }
}
