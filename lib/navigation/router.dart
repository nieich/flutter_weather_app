import 'package:flutter/material.dart';
import 'package:flutter_weather_app/navigation/routes.dart';
import 'package:flutter_weather_app/navigation/scaffold_with_drawer.dart';
import 'package:flutter_weather_app/pages/home_page.dart';
import 'package:flutter_weather_app/pages/settings/settings_page.dart';

import 'package:go_router/go_router.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigationKey,
  initialLocation: Routes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // Übergeben Sie den fullPath des aktuellen GoRoute an Ihre Scaffold-Komponente.
        return ScaffoldWithDrawer(
          navigationShell: navigationShell,
          currentRoutePath: state.fullPath,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) {
                return const HomePage();
              },
            ),
            GoRoute(
              path: Routes.settings,
              builder: (context, state) {
                return const SettingsPage();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
