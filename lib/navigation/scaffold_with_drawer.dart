import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithDrawer extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ScaffoldWithDrawer({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('ScaffoldWithDrawer'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GoRouter mit Drawer')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menü', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Seite A'),
              onTap: () {
                Navigator.of(context).pop(); // Drawer schließen
                context.go('/a'); // Zur Route navigieren
              },
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('Seite B'),
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
