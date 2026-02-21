import '../constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppCardTheme {
  // ---------------- LIGHT ----------------
  static final CardThemeData light = CardThemeData(
    color: AppColors.cardBg,
    elevation: AppDimensions.cardElevation,
    margin:  EdgeInsets.all(AppDimensions.contentPadding.sp),
    shadowColor: AppColors.shadow,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
    ),
  );

  // ---------------- DARK ----------------
  static final CardThemeData dark = CardThemeData(
    color: AppColors.cardBgDark,  // centralized from AppColors
    elevation: AppDimensions.cardElevation,
    margin:  EdgeInsets.all(AppDimensions.contentPadding.sp),
    shadowColor: AppColors.shadowDark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
    ),
  );
}
