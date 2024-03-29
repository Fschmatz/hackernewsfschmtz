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
    bottomAppBarColor: const Color(0xFFF2F0F0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF2F0F0),
    ),
    snackBarTheme: SnackBarThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        backgroundColor: const Color(0xFF050505),
        contentTextStyle: const TextStyle(
          color: Color(0xFFE2E2E9),
        ),
        actionTextColor: Colors.orange.shade800,
        behavior: SnackBarBehavior.floating),
    navigationBarTheme: NavigationBarThemeData(
        surfaceTintColor: const Color(0xFFF2F0F0),
        backgroundColor: const Color(0xFFF2F0F0),
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
    primaryColor: const Color(0xFF1B1B1B),
    scaffoldBackgroundColor: const Color(0xFF1B1B1B),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xffefa57c),
      onSecondary: Color(0xFFCACACA),
      secondary: Color(0xfffd9961),
    ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Color(0xFF1B1B1B),
        color: Color(0xFF1B1B1B),
       ),
    cardTheme: const CardTheme(
      surfaceTintColor: Color(0xFF2A2A2D),
      color: Color(0xFF2A2A2D),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF272729),
    ),
    bottomAppBarColor: const Color(0xFF262424),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: true,
      backgroundColor: Color(0xFF262424),
    ),
    snackBarTheme: const SnackBarThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        backgroundColor: Color(0xFF323030),
        contentTextStyle: TextStyle(
          color: Color(0xFFE2E2E9),
        ),
        actionTextColor: Color(0xffefa57c),
        behavior: SnackBarBehavior.floating),
    navigationBarTheme: NavigationBarThemeData(
        surfaceTintColor: const Color(0xFF262424),
        backgroundColor: const Color(0xFF262424),
        indicatorColor: const Color(0xffa85d35),
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFFE8E7E6),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFFE8E7E6), fontWeight: FontWeight.w500)))
);

