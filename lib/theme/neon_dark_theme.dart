import 'package:flutter/material.dart';

ThemeData neonDarkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF0B0F1A),
  primaryColor: const Color.fromARGB(255, 158, 172, 159),

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    bodyLarge: TextStyle(
      color: Color(0xFFE5E7EB),
      fontSize: 18,
    ),
    bodyMedium: TextStyle(
      color: Color(0xFF9CA3AF),
    ),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
  ),
);
