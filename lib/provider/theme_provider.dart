import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themeColorKey = 'theme_color';
  Color _seedColor = Colors.deepPurple;

  ThemeProvider() {
    _loadTheme();
  }

  Color get seedColor => _seedColor;

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(_themeColorKey);
    if (colorValue != null) {
      _seedColor = Color(colorValue);
      notifyListeners();
    }
  }

  Future<void> setSeedColor(Color color) async {
    _seedColor = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeColorKey, color.value);
    notifyListeners();
  }
}
