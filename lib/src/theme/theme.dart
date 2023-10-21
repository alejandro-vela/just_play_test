/// Here the theme of the app is established (colors, fonts with their sizes and characteristics).
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

ThemeData lightThemeData = ThemeData(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    elevation: 10,
    centerTitle: false,
    titleSpacing: 0,
    iconTheme: IconThemeData(
      color: AppColors.textColor,
      size: 24,
    ),
    titleTextStyle: GoogleFonts.roboto(
      color: AppColors.textColor,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
  primaryTextTheme: TextTheme(
    titleLarge: GoogleFonts.roboto(
      fontSize: 18,
      color: AppColors.textColor,
      fontWeight: FontWeight.normal,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 16,
      color: AppColors.textColor,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 16,
      color: AppColors.textColor,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14,
      color: AppColors.textColor,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 12,
      color: AppColors.textColor,
      fontWeight: FontWeight.normal,
    ),
  ),
);
