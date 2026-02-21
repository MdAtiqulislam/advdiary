import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppDividerTheme {
  // ---------------- LIGHT ----------------
  static final DividerThemeData light = DividerThemeData(
    color: AppColors.divider,
    thickness: 1,
  );

  // ---------------- DARK ----------------
  static final DividerThemeData dark = DividerThemeData(
    color: AppColors.dividerDark,
    thickness: 0.8,
  );
}
