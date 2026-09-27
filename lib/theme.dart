import 'package:flutter/material.dart';

/// Spacing constants from the Design System.
/// Base unit: 8. Everything else is a multiple of it.
class AppSpacing {
  static const double xs = 8;
  static const double sm = 16;
  static const double md = 24;
  static const double lg = 24;
}

/// Success color kept outside ColorScheme since Material 3 has no
/// built-in "success" role.
const Color appSuccessColor = Color(0xFF16A34A);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFA6291E), // Maroon Red
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFF5A623), // Amber Gold
    onSecondary: Color(0xFF1A1A1A),
    surface: Color(0xFFF5F5F5), // Off-white / light gray
    onSurface: Color(0xFF1A1A1A), // Near-black
    error: Color(0xFFDC2626),
    onError: Color(0xFFFFFFFF),
  ),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    labelSmall: TextStyle(fontSize: 12, color: Color(0xFF757575)),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
  cardTheme: const CardThemeData(
    margin: EdgeInsets.all(0),
    elevation: 0,
    color: Color(0xFFF5F5F5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size.fromHeight(48),
      backgroundColor: const Color(0xFFA6291E),
      foregroundColor: Colors.white,
    ),
  ),
);
