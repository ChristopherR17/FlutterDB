import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF10121A);
  static const Color panel = Color(0xFF181B26);
  static const Color panelSoft = Color(0xFF222638);
  static const Color accent = Color(0xFFFFC857);
  static const Color accent2 = Color(0xFF6DECB9);
  static const Color text = Color(0xFFF2F2F2);
  static const Color muted = Color(0xFFB8BAC8);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        brightness: Brightness.dark,
        surface: panel,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: panel,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: panel,
        hintStyle: const TextStyle(color: muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: text,
          fontSize: 34,
          fontWeight: FontWeight.w900,
        ),
        titleLarge: TextStyle(
          color: text,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
        titleMedium: TextStyle(
          color: text,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(
          color: muted,
          fontSize: 14,
          height: 1.4,
        ),
      ),
    );
  }
}
