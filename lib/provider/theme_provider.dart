import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themeColorKey = 'theme_color';
  Color _seedColor = Colors.deepPurple;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider() {
    _loadTheme();
  }

  Color get seedColor => _seedColor;
  ThemeMode get themeMode => _themeMode;

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(_themeColorKey);
    final themeModeValue = prefs.getString('theme_mode');
    if (themeModeValue != null) {
      _themeMode = ThemeMode.values.firstWhere((mode) => mode.toString() == themeModeValue);
    }
    if (colorValue != null) {
      _seedColor = Color(colorValue);
      notifyListeners();
    }
  }

  Future<void> setSeedColor(Color color) async {
    _seedColor = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeColorKey, color.toARGB32());
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode.toString());
    notifyListeners();
  }
}
