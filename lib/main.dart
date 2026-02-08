import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/exchange_rate.dart';
import 'screens/rates_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ExchangeRateAdapter());

  await Hive.openBox<ExchangeRate>('exchangeRates');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: darkTheme,
      home: const RatesScreen(),
    );
  }
}

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212),
  cardColor: const Color(0xFF1E1E1E),
  primaryColor: const Color(0xFF8FAF9F),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color(0xFFE6E6E6),
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      color: Color(0xFFB0B0B0),
    ),
  ),
);

