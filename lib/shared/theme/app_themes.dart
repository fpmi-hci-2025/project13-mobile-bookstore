import 'package:bookstore/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    highlightColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,

      surface: AppColors.surface,
      secondary: AppColors.secondary,
    ),

    textTheme: TextTheme(
      headlineLarge: AppTypography.headlineLarge,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
      bodySmall: AppTypography.bodySmall,
      titleLarge: AppTypography.titleLarge,
    ),
  );
}
