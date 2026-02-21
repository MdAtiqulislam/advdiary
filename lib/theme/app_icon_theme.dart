import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constraints/dimensions.dart';
import 'app_colors.dart';

class AppIconTheme {
  // ---------------- LIGHT ----------------
  static final IconThemeData light = IconThemeData(
    color: AppColors.icon, // define in AppColors
    size: AppDimensions.iconSizeMedium.sp,
    opacity: 1.0,
    shadows: [
      Shadow(
        blurRadius: 2,
        color: AppColors.shadow.withAlpha((0.3*254).toInt()),
        offset: const Offset(1, 1),
      ),
    ],
  );

  // ---------------- DARK ----------------
  static final IconThemeData dark = IconThemeData(
    color: AppColors.iconDark, // define in AppColors
    size: AppDimensions.iconSizeMedium.sp,
    opacity: 1.0,
    shadows: [
      Shadow(
        blurRadius: 2,
        color: AppColors.shadowDark.withAlpha((0.3*254).toInt()),
        offset: const Offset(1, 1),
      ),
    ],
  );
}
