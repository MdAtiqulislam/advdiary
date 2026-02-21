import '../constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppButtonTheme {
  // ---------------- LIGHT ----------------
  static final ElevatedButtonThemeData light = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,      // brand primary
      foregroundColor: Colors.white,           // text/icon color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      ),
      padding:  EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w, vertical: AppDimensions.verticalPadding.h),
    ),
  );

  // ---------------- DARK ----------------
  static final ElevatedButtonThemeData dark = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryLight,  // slightly lighter for contrast
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      ),
      padding:  EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w, vertical: AppDimensions.verticalPadding.h),
    ),
  );
}
