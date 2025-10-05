// lib/core/theme.dart
import 'package:flutter/material.dart';
import 'package:tarkhineh/core/constants/assets.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppAssets.fontEstedad,
      primaryColor: const Color(0xFF417F56),
      scaffoldBackgroundColor: const Color(0xFFF9F9F9),

      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F6E4F), brightness: Brightness.light),

      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF2F6E4F), foregroundColor: Colors.white, centerTitle: true, elevation: 0),

      textTheme: const TextTheme(
        // تیترهای بزرگ
        displayLarge: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
        displayMedium: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
        headlineLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        headlineMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        // متن اصلی
        bodyLarge: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        bodyMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F6E4F),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
