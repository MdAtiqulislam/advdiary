

import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constraints/app_strings.dart';
import '../theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? validatorText;
  final TextInputType? textInputType;
  final String? title;
  final String? levelText;
  final Widget? preFix;
  final Widget? suffix;
  final String? hintText;
  final int? maxLine;
  final int? minLine;
  final int? maxLength;
  final bool? isEnable;
  final bool isRequired;
  final bool? isPassword;
  final bool? readonly;
  final Widget? trailing;
  final List<TextInputFormatter>? inputFormatter;
  final VoidCallback? trailingAction;
  final VoidCallback? onEditingCompleted;

  const CustomTextField({
    this.controller,
    this.validator,
    this.validatorText,
    this.hintText,
    this.title,
    this.maxLine,
    this.minLine,
    this.isEnable,
    this.isPassword,
    this.readonly,
    this.textInputType,
    this.trailing,
    this.maxLength,
    this.preFix,
    this.suffix,
    this.isRequired = false,
    this.trailingAction,
    this.onEditingCompleted,
    this.inputFormatter,
    this.levelText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null || levelText != null)
          Padding(
            padding: EdgeInsets.only(
              bottom: AppDimensions.contentPadding.h,
              left: AppDimensions.contentPadding.w,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  if (title != null)
                    TextSpan(
                      text: title,
                      style: AppTextStyles.body(
                        context: context,
                        resizeAble: true,
                      ),
                    ),
                  if (title != null && isRequired)
                    const TextSpan(
                      text: " *",
                      style: TextStyle(color: Colors.red),
                    ),
                  if (levelText != null)
                    TextSpan(
                      text: levelText,
                      style: AppTextStyles.body(
                        context: context,
                        resizeAble: true,
                      ),
                    ),
                  if (levelText != null && isRequired)
                    const TextSpan(
                      text: " *",
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ),
        Row(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextFormField(
                    clipBehavior: Clip.hardEdge,
                    inputFormatters: inputFormatter,
                    onEditingComplete: onEditingCompleted,
                    style: TextStyle(
                      fontSize: AppDimensions.headerTextSize.sp,
                      fontWeight: FontWeight.normal,
                      color: AppColors.headerText,
                    ),
                    enabled: isEnable,
                    obscureText: isPassword ?? false,
                    obscuringCharacter: "*",
                    readOnly: readonly ?? false,
                    maxLines: maxLine ?? 1,
                    minLines: minLine ?? 1,
                    controller: controller,
                    validator: validatorText != null
                        ? (value) {
                      if ((value ?? "").isEmpty) {
                        return validatorText;
                      }
                      return null;
                    }
                        : validator,
                    maxLength: maxLength,
                    keyboardType: textInputType,
                    textAlignVertical: TextAlignVertical.top,
                    cursorWidth: .8,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.6),
                      errorMaxLines: 5,
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
                        borderSide: const BorderSide(color: AppColors.border, width: 1),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
                        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
                        borderSide: const BorderSide(color: AppColors.danger),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.horizontalPadding.w,
                        vertical: AppDimensions.verticalPadding.h / 2,
                      ),
                      hintText: hintText,
                      prefixIcon: preFix,
                      suffixIcon: suffix,
                      labelText: null,
                      hintStyle: TextStyle(
                        color: AppColors.bodyText,
                        fontSize: AppDimensions.headerTextSize.sp,
                      ),
                      errorStyle: TextStyle(
                        fontSize: AppDimensions.smallTextSize.sp,
                        color: AppColors.danger,
                      ),
                    ),
                  ),

                  // ⬇️ Multi-line indicator
                  if ((maxLine ?? 1) > 1 || (minLine ?? 1) > 1)
                    Positioned(
                      bottom: 4,
                      right: 4,
                      // child: Icon(Icons.calendar_view_day_sharp, size: 10, color: Colors.grey.withOpacity(0.6)),
                      child: Image.asset(AppImagePath.textareaIcon),
                    ),
                ],
              ),
            ),




            if (trailing != null)
              Material(
                color: Colors.transparent,
                child: IconButton(
                  padding: EdgeInsets.only(
                    right: AppDimensions.horizontalPadding.w,
                  ),
                  icon: trailing!,
                  onPressed: trailingAction,
                ),
              ),
          ],
        ),
      ],
    );
  }

}
