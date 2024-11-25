import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
      background: Color(0xFF2A2A2A),
      surface: Color(0xFF2A2A2A),
      primary: Colors.white,
      secondary: Color(0xFF284464),
      inversePrimary: Color(0xFF225695),
      primaryContainer: Color(0xFF2B2B2B),
      secondaryContainer: Color(0xFF373737),
      error: Color(0xFFC50303)),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
  ),
);
