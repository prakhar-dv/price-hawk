import 'package:flutter/material.dart';
import 'app_colors.dart';

class ThemeConfig {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
  );
}