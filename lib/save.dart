import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light();

ThemeData darkTheme = ThemeData.dark();

ThemeData pinkTheme = lightTheme.copyWith(
    primaryColor: const Color(0xFFF49FB6),
    scaffoldBackgroundColor: const Color(0xFFFAF8F0),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Color.fromARGB(255, 36, 124, 40),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.black87,
      ),
    ));

ThemeData halloweenTheme = lightTheme.copyWith(
  primaryColor: const Color(0xFF55705A),
  scaffoldBackgroundColor: const Color(0xFFE48873),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Color(0xFFea8e71),
    backgroundColor: Color(0xFF2b2119),
  ),
);

ThemeData darkBlueTheme = ThemeData.dark().copyWith(
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
    labelStyle:
        TextStyle(color: Color.fromARGB(255, 74, 255, 68), fontSize: 24.0),
  ),
  primaryColor: const Color.fromARGB(255, 0, 0, 0),
  hintColor: Colors.black,
  scaffoldBackgroundColor: const Color.fromARGB(255, 34, 34, 34),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Color.fromARGB(255, 66, 128, 60),
    ),
  ),
);
