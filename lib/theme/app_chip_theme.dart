import '../constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppChipTheme {
  // ---------------- LIGHT ----------------
  static final ChipThemeData light = ChipThemeData(
    backgroundColor: AppColors.primaryLight.withAlpha((0.2*254).toInt()),
    selectedColor: AppColors.primaryColor,
    labelStyle: TextStyle(color: AppColors.bodyText),
    secondaryLabelStyle: const TextStyle(color: Colors.white),
    brightness: Brightness.light,
    padding:  EdgeInsets.symmetric(horizontal: AppDimensions.contentPadding.w, vertical: AppDimensions.contentPadding/2.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
    ),
  );

  // ---------------- DARK ----------------
  static final ChipThemeData dark = ChipThemeData(
    backgroundColor: AppColors.primaryLight.withAlpha((0.2*254).toInt()),
    selectedColor: AppColors.primaryColor,
    labelStyle: TextStyle(color: AppColors.bodyTextDark),
    secondaryLabelStyle: const TextStyle(color: Colors.white),
    brightness: Brightness.dark,
    padding:  EdgeInsets.symmetric(horizontal: AppDimensions.contentPadding.w, vertical: AppDimensions.contentPadding/2.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
    ),
  );
}
