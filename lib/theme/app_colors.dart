
import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primaryColor = Color(0xff193C96);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color primaryLight = Color(0xFF90CAF9);
  static const Color titleBg = Color(0xFFC8E6FF);
  static const Color accentGreen = Color(0xFF00C853);

  static const Color secondaryColor=Color(0xFF009CDF);

  // Light Theme Colors
  static const Color scaffoldBg = Color(0xFFF5F7FA);
  static const Color cardBg = Colors.white;
  static const Color headerText = Color(0xFF1A1A1A);
  static const Color bodyText = Color(0xFF4b4b4b);
  static const Color mutedText = Color(0xFF9E9E9E);
  static const Color border = Color(0xFFDDDDDD);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color icon = Color(0xFF4b4b4b);
  static const Color shadow = Color(0xFF818080);

  // Dark Theme Colors
  static const Color scaffoldBgDark = Color(0xFF121212);
  static const Color cardBgDark = Color(0xFF1E1E1E);
  static const Color headerTextDark = Colors.white;
  static const Color bodyTextDark = Colors.white70;
  static const Color mutedTextDark = Colors.grey;
  static const Color borderDark = Color(0xFF444444);
  static const Color dividerDark = Color(0xFF2C2C2C);
  static const Color iconDark = Colors.grey;
  static const Color shadowDark = Colors.black26;

  // Status Colors (same for both)
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFBB429);
  static const Color danger = Color(0xFFE53935);
  static const Color info = Color(0xFF29B6F6);

  // Material Swatch
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF1E88E5,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF1E88E5),
      600: Color(0xFF1976D2),
      700: Color(0xFF1565C0),
      800: Color(0xFF0D47A1),
      900: Color(0xFF0B3D91),
    },
  );
}
