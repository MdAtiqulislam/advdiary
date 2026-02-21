import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constraints/app_strings.dart';
import '../constraints/dimensions.dart';

class EmptyScreen extends StatelessWidget {
  final double? height;
  final double? width;
  final String title;
  final double? scaleFactor;
  final Widget? button;

  const EmptyScreen({
    super.key,
    this.height,
    this.width,
    this.scaleFactor,
    this.button,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPadding.w,
                vertical: AppDimensions.contentPadding.h),
            child: Image.asset(
              AppImagePath.emptyIcon,
              scale: scaleFactor,
            ),
          ),
          SizedBox(
            height: AppDimensions.contentPadding.h,
          ),
          Text(
            title,
            style: AppTextStyles.header(),
          ),
          button ?? const Text(""),
        ],
      ),
    );
  }
}
