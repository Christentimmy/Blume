import 'package:blume/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  splashColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  scaffoldBackgroundColor: AppColors.lightBackground,
  textTheme: GoogleFonts.figtreeTextTheme().copyWith(
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    ),
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    bodySmall: GoogleFonts.montserrat(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.black45,
    ),
  ),
);


final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColor,
  splashColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  scaffoldBackgroundColor: AppColors.darkBackground,
  textTheme: GoogleFonts.figtreeTextTheme().copyWith(
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.white70,
    ),
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
    ),
    bodySmall: GoogleFonts.montserrat(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.white54,
    ),
  ),
);
