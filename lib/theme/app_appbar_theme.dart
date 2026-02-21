import '../theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppAppBarTheme {
  // Light AppBar
  static AppBarTheme light = AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: AppTextStyles.title(color: Colors.white),
  );

  // Dark AppBar
  static AppBarTheme dark = AppBarTheme(
    backgroundColor: const Color(0xFF1F1F1F),
    elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: AppTextStyles.title(color: AppColors.headerTextDark),
  );
}
