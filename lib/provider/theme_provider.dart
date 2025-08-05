import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ColorMode { individual, seed }

class ThemeProvider with ChangeNotifier {
  static const String _themeColorKey = 'theme_color';
  static const String _themeModeKey = 'theme_mode';
  static const String _colorModeKey = 'color_mode';
  static const String _lightPrimaryColorKey = 'light_primary_color';
  static const String _darkPrimaryColorKey = 'dark_primary_color';
  static const String _lightSecondaryColorKey = 'light_secondary_color';
  static const String _darkSecondaryColorKey = 'dark_secondary_color';
  static const String _lightOnPrimaryColorKey = 'light_on_primary_color';
  static const String _darkOnPrimaryColorKey = 'dark_on_primary_color';
  static const String _lightOnSecondaryColorKey = 'light_on_secondary_color';
  static const String _darkOnSecondaryColorKey = 'dark_on_secondary_color';
  static const String _lightErrorColorKey = 'light_error_color';
  static const String _darkErrorColorKey = 'dark_error_color';
  static const String _lightOnErrorColorKey = 'light_on_error_color';
  static const String _darkOnErrorColorKey = 'dark_on_error_color';
  static const String _lightSurfaceColorKey = 'light_surface_color';
  static const String _darkSurfaceColorKey = 'dark_surface_color';
  static const String _lightOnSurfaceColorKey = 'light_on_surface_color';
  static const String _darkOnSurfaceColorKey = 'dark_on_surface_color';

  Color _seedColor = Colors.deepPurple;
  ThemeMode _themeMode = ThemeMode.system;
  ColorMode _colorMode = ColorMode.seed;

  // Individual colors
  Color _lightPrimary = Colors.blue;
  Color _darkPrimary = Colors.blueAccent;
  Color _lightSecondary = Colors.green;
  Color _darkSecondary = Colors.greenAccent;
  Color _lightOnPrimary = Colors.white;
  Color _darkOnPrimary = Colors.black;
  Color _lightOnSecondary = Colors.black;
  Color _darkOnSecondary = Colors.black;
  Color _lightError = Colors.red;
  Color _darkError = Colors.redAccent;
  Color _lightOnError = Colors.white;
  Color _darkOnError = Colors.black;
  Color _lightSurface = Colors.white;
  Color _darkSurface = const Color(0xFF121212);
  Color _lightOnSurface = Colors.black;
  Color _darkOnSurface = Colors.white;

  ThemeProvider() {
    _loadTheme();
  }

  Color get seedColor => _seedColor;
  ThemeMode get themeMode => _themeMode;
  ColorMode get colorMode => _colorMode;
  Color get lightPrimary => _lightPrimary;
  Color get darkPrimary => _darkPrimary;
  Color get lightSecondary => _lightSecondary;
  Color get darkSecondary => _darkSecondary;
  Color get lightOnPrimary => _lightOnPrimary;
  Color get darkOnPrimary => _darkOnPrimary;
  Color get lightOnSecondary => _lightOnSecondary;
  Color get darkOnSecondary => _darkOnSecondary;
  Color get lightError => _lightError;
  Color get darkError => _darkError;
  Color get lightOnError => _lightOnError;
  Color get darkOnError => _darkOnError;
  Color get lightSurface => _lightSurface;
  Color get darkSurface => _darkSurface;
  Color get lightOnSurface => _lightOnSurface;
  Color get darkOnSurface => _darkOnSurface;

  /// The ColorScheme for the light theme.
  /// It is generated dynamically based on the selected [colorMode].
  ColorScheme get lightColorScheme {
    if (_colorMode == ColorMode.individual) {
      return ColorScheme(
        brightness: Brightness.light,
        primary: _lightPrimary,
        onPrimary: _lightOnPrimary,
        secondary: _lightSecondary,
        onSecondary: _lightOnSecondary,
        error: _lightError,
        onError: _lightOnError,
        surface: _lightSurface,
        onSurface: _lightOnSurface,
      );
    }
    return ColorScheme.fromSeed(seedColor: _seedColor, brightness: Brightness.light);
  }

  /// The ColorScheme for the dark theme.
  /// It is generated dynamically based on the selected [colorMode].
  ColorScheme get darkColorScheme {
    if (_colorMode == ColorMode.individual) {
      return ColorScheme(
        brightness: Brightness.dark,
        primary: _darkPrimary,
        onPrimary: _darkOnPrimary,
        secondary: _darkSecondary,
        onSecondary: _darkOnSecondary,
        error: _darkError,
        onError: _darkOnError,
        surface: _darkSurface,
        onSurface: _darkOnSurface,
      );
    }
    return ColorScheme.fromSeed(seedColor: _seedColor, brightness: Brightness.dark);
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(_themeColorKey);
    if (colorValue != null) {
      _seedColor = Color(colorValue);
    }

    final themeModeName = prefs.getString(_themeModeKey);
    if (themeModeName != null) {
      try {
        _themeMode = ThemeMode.values.byName(themeModeName);
      } catch (e) {
        // If the theme mode is not recognized, default to system.
        print('Unknown theme mode: $themeModeName, defaulting to system.');
        _themeMode = ThemeMode.system;
      }
    }

    final colorModeName = prefs.getString(_colorModeKey);
    if (colorModeName != null) {
      try {
        _colorMode = ColorMode.values.byName(colorModeName);
      } catch (e) {
        // If the color mode is not recognized, default to seed.
        print('Unknown color mode: $colorModeName, defaulting to seed.');
        _colorMode = ColorMode.seed;
      }
    }

    // Helper to reduce repetition when loading colors.
    Color getColor(String key, Color defaultColor) => Color(prefs.getInt(key) ?? defaultColor.value);

    _lightPrimary = getColor(_lightPrimaryColorKey, Colors.blue);
    _darkPrimary = getColor(_darkPrimaryColorKey, Colors.blueAccent);
    _lightSecondary = getColor(_lightSecondaryColorKey, Colors.green);
    _darkSecondary = getColor(_darkSecondaryColorKey, Colors.greenAccent);
    _lightOnPrimary = getColor(_lightOnPrimaryColorKey, Colors.white);
    _darkOnPrimary = getColor(_darkOnPrimaryColorKey, Colors.black);
    _lightOnSecondary = getColor(_lightOnSecondaryColorKey, Colors.black);
    _darkOnSecondary = getColor(_darkOnSecondaryColorKey, Colors.black);
    _lightError = getColor(_lightErrorColorKey, Colors.red);
    _darkError = getColor(_darkErrorColorKey, Colors.redAccent);
    _lightOnError = getColor(_lightOnErrorColorKey, Colors.white);
    _darkOnError = getColor(_darkOnErrorColorKey, Colors.black);
    _lightSurface = getColor(_lightSurfaceColorKey, Colors.white);
    _darkSurface = getColor(_darkSurfaceColorKey, const Color(0xFF121212));
    _lightOnSurface = getColor(_lightOnSurfaceColorKey, Colors.black);
    _darkOnSurface = getColor(_darkOnSurfaceColorKey, Colors.white);

    notifyListeners();
  }

  Future<void> setSeedColor(Color color) async {
    _seedColor = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeColorKey, color.value);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode.name);
    notifyListeners();
  }

  Future<void> setColorMode(ColorMode mode) async {
    _colorMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_colorModeKey, mode.name);
    notifyListeners();
  }

  Future<void> setLightPrimary(Color color) async {
    _lightPrimary = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lightPrimaryColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setDarkPrimary(Color color) async {
    _darkPrimary = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_darkPrimaryColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setLightSecondary(Color color) async {
    _lightSecondary = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lightSecondaryColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setDarkSecondary(Color color) async {
    _darkSecondary = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_darkSecondaryColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setLightOnPrimary(Color color) async {
    _lightOnPrimary = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lightOnPrimaryColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setDarkOnPrimary(Color color) async {
    _darkOnPrimary = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_darkOnPrimaryColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setLightOnSecondary(Color color) async {
    _lightOnSecondary = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lightOnSecondaryColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setDarkOnSecondary(Color color) async {
    _darkOnSecondary = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_darkOnSecondaryColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setLightError(Color color) async {
    _lightError = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lightErrorColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setDarkError(Color color) async {
    _darkError = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_darkErrorColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setLightOnError(Color color) async {
    _lightOnError = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lightOnErrorColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setDarkOnError(Color color) async {
    _darkOnError = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_darkOnErrorColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setLightSurface(Color color) async {
    _lightSurface = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lightSurfaceColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setDarkSurface(Color color) async {
    _darkSurface = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_darkSurfaceColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setLightOnSurface(Color color) async {
    _lightOnSurface = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lightOnSurfaceColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setDarkOnSurface(Color color) async {
    _darkOnSurface = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_darkOnSurfaceColorKey, color.toARGB32());
    notifyListeners();
  }
}
