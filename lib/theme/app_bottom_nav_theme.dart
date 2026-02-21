import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppBottomNavTheme {
  // ---------------- LIGHT THEME ----------------
  static const BottomNavigationBarThemeData light = BottomNavigationBarThemeData(
    backgroundColor: AppColors.cardBg,             // white
    selectedItemColor: AppColors.primaryColor,         // brand primary
    unselectedItemColor: AppColors.bodyText,     // muted text
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,


  );

  // ---------------- DARK THEME ----------------
  static const BottomNavigationBarThemeData dark = BottomNavigationBarThemeData(
    backgroundColor: AppColors.cardBgDark,        // dark card bg
    selectedItemColor: AppColors.primaryLight,    // lighter primary for contrast
    unselectedItemColor: AppColors.mutedTextDark, // dark muted text
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  );
}
