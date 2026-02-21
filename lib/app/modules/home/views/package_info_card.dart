import 'package:advdiary/common_widgets/app_button.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class PackageInfoCard extends StatelessWidget {
  final String packageName;
  final dynamic caseLimit; // can be int or "Unlimited"
  final int addedCases;
  final String? lastUpdate;
  final String? nextPayment;
  final bool isBasic;
  final VoidCallback onUpgrade;
  final VoidCallback onViewMore;

  const PackageInfoCard({
    super.key,
    required this.packageName,
    required this.caseLimit,
    required this.addedCases,
    this.lastUpdate,
    this.nextPayment,
    required this.isBasic,
    required this.onUpgrade,
    required this.onViewMore,
  });

  @override
  Widget build(BuildContext context) {
    bool isUnlimited = caseLimit.toString().toLowerCase() == "unlimited";
    bool isWarning = isBasic;

    // If not unlimited, calculate remaining and warning state
    int? numericLimit;
    int remainingCases = 0;

    if (!isUnlimited) {
      numericLimit = int.tryParse(caseLimit.toString()) ?? 0;
      remainingCases = numericLimit - addedCases;
      bool isLimitNear = remainingCases <= (numericLimit * 0.1);
      isWarning = isWarning || isLimitNear;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        color: AppColors.primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.widgetPadding.w,
          vertical: AppDimensions.widgetPadding.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Package: $packageName",
              style: AppTextStyles.header(color: Colors.white),
            ),
            SizedBox(height: AppDimensions.contentPadding.h),

            // Show progress only if limit is not unlimited
            if (!isUnlimited) ...[
              LinearProgressIndicator(
                value: addedCases / numericLimit!,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation(
                  isWarning ? Colors.red : Colors.blue,
                ),
              ),
              SizedBox(height: AppDimensions.contentPadding.h),
            ],

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cases: $addedCases / ${isUnlimited ? 'Unlimited' : numericLimit}",
                  style: AppTextStyles.body(color: Colors.white),
                ),
                AppButton(
                  onTap: isWarning ? onUpgrade : onViewMore,
                  text: isWarning ? "👉🏿 Upgrade Package" : "👉🏿 View More",
                  bgColor: AppColors.warning,
                  showBorder: false,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textTransform: TextTransform.none,
                  borderRadius: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
