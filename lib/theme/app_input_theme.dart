import '../constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppInputTheme {
  // ---------------- LIGHT ----------------
  static final InputDecorationTheme light = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.cardBg,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      borderSide: BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      borderSide: BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
    ),
    labelStyle: TextStyle(color: AppColors.mutedText),
  );

  // ---------------- DARK ----------------
  static final InputDecorationTheme dark = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.cardBgDark,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      borderSide: BorderSide(color: AppColors.borderDark),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      borderSide: BorderSide(color: AppColors.borderDark),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
    ),
    labelStyle: TextStyle(color: AppColors.mutedTextDark),
  );
}
