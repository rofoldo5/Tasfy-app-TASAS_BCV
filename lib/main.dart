import 'package:flutter/material.dart';
import 'screens/rates_screen.dart';
import 'theme/app_theme.dart';

ValueNotifier<ThemeMode> themeNotifier =
    ValueNotifier(ThemeMode.light);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode mode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: mode,
          home: const RatesScreen(),
        );
      },
    );
  }
}
