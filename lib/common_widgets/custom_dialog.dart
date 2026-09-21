
import 'package:advdiary/common_widgets/app_button.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_colors.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? subtitle;

  /// ✅ Old string description support
  final String? description;

  /// ✅ New custom widget support
  final Widget? descriptionWidget;

  /// ✅ Extra widget section
  final Widget? otherInfo;

  /// ✅ Icon widget
  final Widget? icon;

  /// ✅ Buttons
  final String? confirmButtonText;
  final String? cancelButtonText;

  /// ✅ Button Colors
  final Color? confirmButtonColor;
  final Color? cancelButtonColor;

  /// ✅ Title Color
  final Color? titleColor;

  /// ✅ Callbacks
  final VoidCallback? onConfirmButtonPressed;
  final VoidCallback? onCancelButtonPressed;

  /// ✅ Optional width
  final double? width;

  /// ✅ Optional content padding
  final EdgeInsetsGeometry? contentPadding;

  const CustomDialog({
    super.key,
    this.title,
    this.subtitle,
    this.description,
    this.descriptionWidget,
    this.otherInfo,
    this.icon,
    this.confirmButtonText,
    this.cancelButtonText,
    this.confirmButtonColor,
    this.cancelButtonColor,
    this.titleColor,
    this.onConfirmButtonPressed,
    this.onCancelButtonPressed,
    this.width,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.borderRadiusLarge.r,
        ),
      ),

      contentPadding:
      contentPadding ??
          EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),

      content: SizedBox(
        width: width ?? Get.width * .85,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ================= ICON =================
            if (icon != null)
              Center(
                child: icon!,
              ),

            if (icon != null)
              SizedBox(height: 12.h),

            /// ================= TITLE =================
            if (title != null)
              Center(
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title(
                    color:
                    titleColor ??
                        AppColors.primaryColor,
                  ),
                ),
              ),

            if (title != null)
              SizedBox(height: 12.h),

            /// ================= DIVIDER =================
            const Divider(
              color: AppColors.primaryColor,
              thickness: 1.5,
            ),

            SizedBox(height: 10.h),

            /// ================= SUBTITLE =================
            if (subtitle != null)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  subtitle!,
                  style: AppTextStyles.header(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            /// ================= DESCRIPTION =================

            /// ✅ New Widget Support
            if (descriptionWidget != null)
              descriptionWidget!

            /// ✅ Old String Support
            else if (description != null)
              Text(
                description!,
                maxLines: 10,
                style: AppTextStyles.body(),
              ),

            /// ================= OTHER INFO =================
            if (otherInfo != null) ...[
              SizedBox(height: 14.h),
              otherInfo!,
            ],

            SizedBox(height: 12.h),

            /// ================= DIVIDER =================
            const Divider(
              thickness: 1.5,
              color: AppColors.primaryColor,
            ),

            SizedBox(height: 10.h),

            /// ================= ACTION BUTTONS =================
            Row(
              children: [

                /// Confirm Button
                if (confirmButtonText != null)
                  Expanded(
                    child: AppButton(
                      fontSize: 12,
                      horizontalPadding: 5,
                      bgColor:
                      confirmButtonColor ??
                          AppColors.primaryColor,
                      borderColor:
                      confirmButtonColor ??
                          AppColors.primaryColor,
                      text: confirmButtonText!,
                      onTap:
                      onConfirmButtonPressed ??
                              () => Navigator.of(context).pop(),
                    ),
                  ),

                if (confirmButtonText != null &&
                    cancelButtonText != null)
                  SizedBox(width: 10.w),

                /// Cancel Button
                if (cancelButtonText != null)
                  Expanded(
                    child: AppButton(
                      fontSize: 12,
                      horizontalPadding: 5,
                      bgColor:
                      cancelButtonColor ??
                          AppColors.danger,
                      borderColor:
                      cancelButtonColor ??
                          AppColors.danger,
                      text: cancelButtonText!,
                      onTap:
                      onCancelButtonPressed ??
                              () => Navigator.of(context).pop(),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}