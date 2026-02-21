
import 'package:advdiary/common_widgets/app_button.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class SubscriptionCard extends StatelessWidget {
  final bool isYearly;
  final VoidCallback onSubscribe;

  const SubscriptionCard({
    super.key,
    required this.isYearly,
    required this.onSubscribe
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        color:AppColors.primaryColor
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.widgetPadding.w,
          vertical: AppDimensions.widgetPadding.h
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Icon(Icons.info_outline,color: AppColors.warning,),
            SizedBox(width: AppDimensions.contentPadding.w,),
            Expanded(
              child: Text(
                isYearly
                    ?"Your yearly subscription has expired. Please renew to continue enjoying the service."
                    :"You haven't subscribed yet. Please subscribe to access the service.",
                maxLines: 5,
                style: AppTextStyles.header(color: Colors.white,fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(width: AppDimensions.contentPadding.w,),
            AppButton(
              onTap: onSubscribe,
              text: "Subscribe Now",
                bgColor: AppColors.warning,
              showBorder: false,
              textTransform: TextTransform.none,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              borderRadius: 10,
            ),
          ],
        ),
      ),
    );
  }
}
