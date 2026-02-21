import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';

import '../theme/app_colors.dart';

class AutoScrollingText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double height;
  final double velocity;

  const AutoScrollingText({
    super.key,
    required this.text,
    this.style,
    this.height = 40,
    this.velocity = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.sp,
      color: AppColors.primaryColor,
      child: Row(
        children: [
           Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
            child: Image.asset("assets/icons/push_pin.png"
            ),
          ),
          Expanded(
            child: Marquee(
              text: text,
              style: style ??
                  AppTextStyles.header(color: Colors.white,fontWeight: FontWeight.w500),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              blankSpace: 100,
              velocity: velocity,
              pauseAfterRound: const Duration(seconds: 1),
              startPadding: 10.0,
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
        ],
      ),
    );
  }
}
