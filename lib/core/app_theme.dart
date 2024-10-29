import 'package:flutter/material.dart';
import 'package:health_online/core/app_colors.dart';

class AppTheme {
  static final ThemeData customTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.1, color: AppColors.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      hintStyle: const TextStyle(
          color: AppColors.primary, fontWeight: FontWeight.w300),
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(color: AppColors.primary),
      displayMedium: TextStyle(color: AppColors.primary),
      displayLarge: TextStyle(color: AppColors.primary),
      bodySmall: TextStyle(color: AppColors.primary),
      bodyMedium: TextStyle(color: AppColors.primary),
      bodyLarge: TextStyle(color: AppColors.primary),
      titleSmall: TextStyle(color: AppColors.primary),
      titleMedium: TextStyle(color: AppColors.primary),
      titleLarge: TextStyle(color: AppColors.primary),
      headlineSmall: TextStyle(color: AppColors.primary),
      headlineMedium: TextStyle(color: AppColors.primary),
      headlineLarge: TextStyle(color: AppColors.primary),
      labelSmall: TextStyle(color: AppColors.primary),
      labelMedium: TextStyle(color: AppColors.primary),
      labelLarge: TextStyle(color: AppColors.primary),
    ),
  );
}
