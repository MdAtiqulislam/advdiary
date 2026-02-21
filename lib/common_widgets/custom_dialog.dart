import 'package:advdiary/common_widgets/app_button.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_colors.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? description;
  final Icon? icon;
  final String? confirmButtonText;
  final String? cancelButtonText;
  final Color? confirmButtonColor;
  final Color? cancelButtonColor;
  final VoidCallback? onConfirmButtonPressed;
  final VoidCallback? onCancelButtonPressed;

  const CustomDialog({
    super.key,
    this.title,
    this.subtitle,
    this.description,
    this.icon,
    this.confirmButtonText,
    this.cancelButtonText,
    this.cancelButtonColor,
    this.confirmButtonColor,
    this.onConfirmButtonPressed,
    this.onCancelButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r)),
      title: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) icon!,
            if (icon != null) SizedBox(height: AppDimensions.contentPadding.h),
            if (title != null)
              Text(
                title!,
                textAlign: TextAlign.center,
                style: AppTextStyles.title(color: AppColors.primaryColor),
                // To prevent overflow
              ),
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: AppColors.primaryColor, thickness: 2),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                subtitle!,
                style: AppTextStyles.header(fontWeight: FontWeight.w600),
                   ),
            ),
          if (description != null)
            Text( description!,maxLines: 10, style: AppTextStyles.body(),),
          const Divider(thickness: 2, color: AppColors.primaryColor),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (confirmButtonText != null)
              AppButton(
                fontSize: 12,
                horizontalPadding: 5,
                bgColor: confirmButtonColor,
                borderColor: confirmButtonColor,
                text: confirmButtonText!,
                onTap: onConfirmButtonPressed ?? () => Navigator.of(context).pop(),
              ),
            if (cancelButtonText != null)
              SizedBox(width: AppDimensions.widgetPadding.w),
            AppButton(
              fontSize: 12,
              horizontalPadding: 5,
              bgColor: cancelButtonColor,
              borderColor: cancelButtonColor,
              text: cancelButtonText!,
              onTap: onCancelButtonPressed ?? () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ],
    );
  }
}
