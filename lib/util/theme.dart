import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//CLARO
ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColorBrightness: Brightness.dark,
    primaryColor: const Color(0xFFFFFFFF),
    colorScheme: ColorScheme.light(
      primary:  Colors.orange[800]!,
      primaryVariant:  Colors.orange[800]!,
      onSecondary: const Color(0xFF050505),
      secondary: Colors.orange[800]!,
    ),
    appBarTheme: const AppBarTheme(
        color: Color(0xFFFFFFFF),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF050505)),
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000000))),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    cardTheme: const CardTheme(
      color: Color(0xFFF3F2F2),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFF8F8FB),
    ),
    bottomAppBarColor: const Color(0xFFE6E6E8),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFE1E0E0),
    ),
    snackBarTheme: const SnackBarThemeData(
      actionTextColor: Color(0xFFFF965b),
    ),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFE1E0E0),
        indicatorColor: Colors.orange[800]!,
        iconTheme: MaterialStateProperty.all(
            const IconThemeData(color: Color(0xFF050505),)
        ),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFF050505), fontWeight: FontWeight.w500))));

//ESCURO
ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColorBrightness: Brightness.light,
    primaryColor: const Color(0xFF1B1B1F),
    scaffoldBackgroundColor: const Color(0xFF1B1B1F),
    colorScheme: const ColorScheme.dark(
      primary:  Color(0xFFFF965b),
      primaryVariant:  Color(0xFFFF965b),
      onSecondary: Color(0xFFCACACA),
      secondary: Color(0xFFFF965b),
    ),
    appBarTheme: const AppBarTheme(
        color: Color(0xFF1B1B1F),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFF5F5F5)),
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFFFFFF))),
    cardTheme: const CardTheme(
      color: Color(0xFF29292D),
    ),    
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF272729),
    ),
    bottomAppBarColor: const Color(0xFF121216),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: true,
      backgroundColor: Color(0xFF121216),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFFF0F0F0),
      actionTextColor: Colors.orange[800],
    ),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF121216),
        indicatorColor: const Color(0xFFFF965b),
        iconTheme: MaterialStateProperty.all(
          const IconThemeData(color: Color(0xFFEAEAEA),)
        ),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFFEAEAEA), fontWeight: FontWeight.w500)))
);

class ThemeNotifier extends ChangeNotifier {
  final String key = 'valorTema';
  late SharedPreferences prefs;
  late bool _darkTheme;

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
    prefs = await SharedPreferences.getInstance();
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
