import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//CLARO
ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFE6E6EF),
    accentColor: Colors.orangeAccent[700], //0xFF01A173
    scaffoldBackgroundColor: Color(0xFFF1F1F9), //0xFFF5F5FE
    cardTheme: CardTheme(
      color: Color(0xFFF5F5FE),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFFF9F9FF),
    ),
    bottomAppBarColor: Color(0xFFE6E6EF),
    bottomSheetTheme:
        BottomSheetThemeData(modalBackgroundColor: Color(0xFFF5F5FE)));

//ESCURO
ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF1C1C1E),
    accentColor: Color(0xFFFF965b),
    scaffoldBackgroundColor: Color(0xFF1C1C1E),
    cardTheme: CardTheme(
      color: Color(0xFF242426),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFF242426),
    ),
    bottomAppBarColor: Color(0xFF171719),
    bottomSheetTheme:
        BottomSheetThemeData(modalBackgroundColor: Color(0xFF1D1D1F)));

class ThemeNotifier extends ChangeNotifier {
  final String key = 'valorTema';
  SharedPreferences prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}
