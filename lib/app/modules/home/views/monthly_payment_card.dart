/*
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../theme/app_colors.dart';

class MonthlyPaymentCard extends StatelessWidget {
  final String message;
  final String packageName;
  final String amount;
  final VoidCallback onPayNow;

  const MonthlyPaymentCard({
    super.key,
    required this.message,
    required this.packageName,
    required this.amount,
    required this.onPayNow,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final DateTime dueDate = DateTime(currentDate.year, currentDate.month, 5);
    final bool isLate = currentDate.day > 5;

    return Container(
      width: Get.width,
     // margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      padding: EdgeInsets.all(AppDimensions.contentPadding.w),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- Header ----
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Monthly Payment",
                style: AppTextStyles.header(color: Colors.white),
              ),
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  packageName,
                  style: AppTextStyles.body(color: Colors.white),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // ---- Message ----
          Text(
            message,
            style: AppTextStyles.body(color: Colors.white.withOpacity(0.9)),
          ),

          SizedBox(height: 14.h),

          // ---- Amount ----
          Row(
            children: [
              Text(
                "৳ ${amount}",
                style: AppTextStyles.header(
                  color: Colors.white,
                ).copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // ---- Due Date & Pay Now ----
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Due Date: ${DateFormat('MMMM dd, yyyy').format(dueDate)}",
                style: AppTextStyles.body(
                  color: isLate ? Colors.red.shade200 : Colors.white70,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryColor,
                  padding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: onPayNow,
                child: Text(
                  "Pay Now",
                  style: AppTextStyles.header(
                      color: AppColors.primaryColor, fontSize: 14.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/


import 'package:advdiary/common_widgets/app_button.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class MonthlyPaymentCard extends StatelessWidget {
  final String message;
  final String packageName;
  final String amount;
  final VoidCallback onPayNow;

  const MonthlyPaymentCard({
    super.key,
    required this.message,
    required this.packageName,
    required this.amount,
    required this.onPayNow,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final DateTime dueDate = DateTime(currentDate.year, currentDate.month, 5);
    final bool isLate = currentDate.day > 5;

    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        color: AppColors.primaryColor,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.widgetPadding.w,
        vertical: AppDimensions.widgetPadding.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.payment_outlined, color: AppColors.warning),
          SizedBox(width: AppDimensions.contentPadding.w),

          // ----- Message + Details -----
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.header(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Package: $packageName",
                  style: AppTextStyles.body(color: Colors.white70),
                ),
                Text(
                  "Amount: $amount",
                  style: AppTextStyles.body(color: Colors.white70),
                ),
                Text(
                  "Due Date: ${DateFormat('MMMM dd, yyyy').format(dueDate)}",
                  style: AppTextStyles.body(
                    color: isLate ? Colors.red.shade200 : Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: AppDimensions.contentPadding.w),

          // ----- Pay Now Button -----
          AppButton(
            onTap: onPayNow,
            text: "Pay Now",
            bgColor: AppColors.warning,
            showBorder: false,
            textTransform: TextTransform.none,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            borderRadius: 10,
          ),
        ],
      ),
    );
  }
}
