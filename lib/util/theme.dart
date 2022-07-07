import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFFFFFF),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    colorScheme: ColorScheme.light(
      primary: Colors.orange.shade800,
      onSecondary: const Color(0xFF050505),
      secondary: Colors.orange.shade800,
    ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Color(0xFFFFFFFF),
        color: Color(0xFFFFFFFF),
       ),
    cardTheme: const CardTheme(
      surfaceTintColor: Color(0xFFF4F4F4),
      color: Color(0xFFF4F4F4),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFF8F8FB),

    ),
    bottomAppBarColor: const Color(0xFFE9E9E9),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFE9E9E9),
    ),
    snackBarTheme: const SnackBarThemeData(
      actionTextColor: Color(0xfffd9961),
    ),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFE9E9E9),
        indicatorColor: Colors.orange.shade800,
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFF050505),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFF050505), fontWeight: FontWeight.w500))));

ThemeData dark = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1B1B1D),
    scaffoldBackgroundColor: const Color(0xFF1B1B1D),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xfffaa575),
      onSecondary: Color(0xFFCACACA),
      secondary: Color(0xfffd9961),
    ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Color(0xFF1B1B1D),
        color: Color(0xFF1B1B1D),
       ),
    cardTheme: const CardTheme(
      surfaceTintColor: Color(0xFF2A2A2D),
      color: Color(0xFF2A2A2D),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF272729),
    ),
    bottomAppBarColor: const Color(0xFF242427),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: true,
      backgroundColor: Color(0xFF242427),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFFF0F0F0),
      actionTextColor: Colors.orange[800],
    ),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF242427),
        indicatorColor: const Color(0xffa85d35),
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFFE8E7E6),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFFE8E7E6), fontWeight: FontWeight.w500)))
);

