class Routes {
  Routes._();
  static const String root = '/';
  static const String home = 'Home';
  static const String pathHome = '$root$home';
  static const String settings = 'Settings';
  static const String pathSettings = '$root$settings';
  static const String settingsTheme = 'Theme';
  static const String pathSettingsTheme = '$pathSettings/$settingsTheme';
  static const String settingsUnits = 'Units';
  static const String pathSettingsUnits = '$pathSettings/$settingsUnits';
  static const String settingsDev = 'Dev';
  static const String pathSettingsDev = '$pathSettings/$settingsDev';
}
