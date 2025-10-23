import 'package:flutter/material.dart';

class FlutterTodosTheme {
  static const _lightSeedColor = Color(0xFFFFF59D);
  static const _darkSeedColor = Color(0xFFFFF59D); // Used for accent colors in dark mode

  static ThemeData get light {
    final textTheme = ThemeData.light().textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _lightSeedColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: _lightSeedColor,
        foregroundColor: Colors.black, // For title and icons
      ),
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: _lightSeedColor,
        brightness: Brightness.light,
      ),
    );
  }

  static ThemeData get dark {
    final textTheme = ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white, // For title and icons
      ),
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: _darkSeedColor,
      ),
    );
  }
}
