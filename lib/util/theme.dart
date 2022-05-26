import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    //useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFFFFFF),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    colorScheme: ColorScheme.light(
      primary: Colors.orange[800]!,
      onSecondary: const Color(0xFF050505),
      secondary: Colors.orange[800]!,
    ),
    appBarTheme: const AppBarTheme(
        color: Color(0xFFFFFFFF),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF000000)),
        titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFF000000))),
    cardTheme: const CardTheme(
      color: Color(0xFFF4F4F4),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFF8F8FB),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
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
        indicatorColor: Colors.orange[800]!,
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFF050505),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFF050505), fontWeight: FontWeight.w500))));

ThemeData dark = ThemeData(
    //useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1A1B1F),
    scaffoldBackgroundColor: const Color(0xFF1A1B1F),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xfffd9961),
      onSecondary: Color(0xFFCACACA),
      secondary: Color(0xfffd9961),
    ),
    appBarTheme: const AppBarTheme(
        color: Color(0xFF1A1B1F),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
        titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFFFFFFFF))),
    cardTheme: const CardTheme(
      color: Color(0xFF292A30),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF272729),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
    ),
    bottomAppBarColor: const Color(0xFF232429),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: true,
      backgroundColor: Color(0xFF232429),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFFF0F0F0),
      actionTextColor: Colors.orange[800],
    ),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF232429),
        indicatorColor: const Color(0xffa8623d),
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFFE8E7E6),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFFE8E7E6), fontWeight: FontWeight.w500)))
);

