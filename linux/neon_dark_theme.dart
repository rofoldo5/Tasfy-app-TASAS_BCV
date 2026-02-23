import 'package:flutter/material.dart';

ThemeData neonWhiteTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color.fromARGB(255, 248, 248, 248),
  primaryColor: const Color.fromARGB(255, 249, 249, 249),

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
    backgroundColor: Color.fromARGB(0, 255, 255, 255),
    elevation: 0,
    centerTitle: true,
  ),
);
