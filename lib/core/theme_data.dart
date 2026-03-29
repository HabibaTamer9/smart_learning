import 'package:flutter/material.dart';
import 'package:smart_learning/core/const/app_colors.dart';

class AppThemeData {
  static const String fontFamily = 'Inter';
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    cardColor: Colors.white,
    
    textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryTextColor,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryTextColor,
        ),
        titleMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryTextColor,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryTextColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryTextColor,
        ),
        bodySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryTextColor,
        )),
        
          );
  
}
