import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constraints/dimensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomDropDownField<T> extends StatelessWidget {
  final String? levelText;
  final String? title;
  final T? value;
  final bool isRequired;
  final bool disableBorder;
  final Color? fillColor;
  final Function(T?)? onChange;
  final List<T> itemList;
  final String? Function(T?)? validator;
  final String? validatorText;
  final String Function(T) displayItem;

  const CustomDropDownField({
    required this.itemList,
    required this.onChange,
    required this.displayItem,
    this.isRequired = false,
    this.value,
    this.levelText,
    this.title,
    this.validator,
    this.validatorText,
    this.fillColor,
    this.disableBorder = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final InputBorder border = disableBorder
        ? InputBorder.none
        : OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      borderSide: const BorderSide(
        color: AppColors.border,
        width: 1,
      ),
    );

    final InputBorder focusedBorder = disableBorder
        ? InputBorder.none
        : OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      borderSide: const BorderSide(
        color: AppColors.primaryColor,
        width: 2,
      ),
    );

    final InputBorder errorBorder = disableBorder
        ? InputBorder.none
        : OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      borderSide: const BorderSide(
        color: AppColors.danger,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.only(
              bottom: AppDimensions.contentPadding.h,
              left: AppDimensions.contentPadding.w,
            ),
            child: Text(
              title!,
              style: AppTextStyles.body(context: context),
            ),
          ),
        DropdownButtonFormField<T>(
          isExpanded: true,
          iconSize: AppDimensions.iconSizeMedium.sp,
          iconEnabledColor: AppColors.primaryColor,
          iconDisabledColor: AppColors.primaryColor,
          dropdownColor: AppColors.scaffoldBg,
          validator: validatorText != null
              ? (val) {
            if (val == null || displayItem(val).isEmpty) {
              return validatorText;
            }
            return null;
          }
              : validator,
          style: TextStyle(
            fontSize: AppDimensions.bodyTextSize.sp,
            color: AppColors.headerText,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ??
                Colors.white.withOpacity(0.6), // consistent with CustomTextField
            enabledBorder: border,
            border: border,
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPadding.w,
              vertical: AppDimensions.verticalPadding.h / 2,
            ),
            hintText: "Select One",
            labelText: isRequired ? "$levelText *" : levelText,
            floatingLabelStyle: TextStyle(
              color: AppColors.bodyText,
              fontWeight: FontWeight.bold,
              fontSize: AppDimensions.headerTextSize.sp,
            ),
            hintStyle: TextStyle(
              color: AppColors.bodyText,
              fontSize: AppDimensions.headerTextSize.sp,
            ),
            labelStyle: TextStyle(
              color: AppColors.bodyText,
              fontSize: AppDimensions.headerTextSize.sp,
            ),
            errorStyle: TextStyle(
              fontSize: AppDimensions.smallTextSize.sp,
              color: AppColors.danger,
            ),
          ),
          selectedItemBuilder: (BuildContext context) {
            return itemList
                .map((item) => Text(
              displayItem(item),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body(context: context),
            ))
                .toList();
          },
          items: itemList
              .map((item) => DropdownMenuItem<T>(
            value: item,
            child: Text(
              displayItem(item),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body(context: context),
            ),
          ))
              .toList(),
          onChanged: onChange,
          value: value,
        ),
      ],
    );
  }
}
