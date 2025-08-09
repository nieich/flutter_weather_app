import 'package:flutter/material.dart';
import 'package:flutter_weather_app/navigation/routes.dart';
import 'package:flutter_weather_app/navigation/scaffold_with_drawer.dart';
import 'package:flutter_weather_app/pages/home_page.dart';
import 'package:flutter_weather_app/pages/settings/settings_page.dart';
import 'package:flutter_weather_app/pages/settings/settings_subpages/settings_dev_page.dart';
import 'package:flutter_weather_app/pages/settings/settings_subpages/settings_theme_page.dart';
import 'package:flutter_weather_app/pages/settings/settings_subpages/settings_units_page.dart';

import 'package:go_router/go_router.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigationKey,
  initialLocation: Routes.pathHome,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // Übergeben Sie den fullPath des aktuellen GoRoute an Ihre Scaffold-Komponente.
        return ScaffoldWithDrawer(navigationShell: navigationShell, currentRoutePath: state.fullPath);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.pathHome,
              builder: (context, state) {
                return const HomePage();
              },
            ),
            GoRoute(
              path: Routes.pathSettings,
              builder: (context, state) {
                return const SettingsPage();
              },
              routes: [
                GoRoute(
                  path: Routes.settingsTheme,
                  builder: (context, state) {
                    return const SettingsThemePage();
                  },
                ),
                GoRoute(
                  path: Routes.settingsUnits,
                  builder: (context, state) {
                    return const SettingsUnitPage();
                  },
                ),
                GoRoute(
                  path: Routes.settingsDev,
                  builder: (context, state) {
                    return const SettingsDevPage();
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
