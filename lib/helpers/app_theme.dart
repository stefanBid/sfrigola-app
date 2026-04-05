// * ════════════════════════════════════════════════════════════════════════════
// *  APP THEME
// * ════════════════════════════════════════════════════════════════════════════
// *
// *  MaterialApp ThemeData configuration. Provides light and dark themes using
// *  the Lato font family (google_fonts) and AppColors seed colours.
// *
// *  AppTheme.lightTheme  →  pass to MaterialApp.theme
// *  AppTheme.darkTheme   →  pass to MaterialApp.darkTheme
// *
// * ════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get darkTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.secondary,
      brightness: Brightness.dark,
    ),
    textTheme: GoogleFonts.latoTextTheme(),
  );

  static ThemeData get lightTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.latoTextTheme(),
  );
}
