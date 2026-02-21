




import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constraints/dimensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomSearchableDropdown<T> extends StatelessWidget {
  final String? labelText;
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
  final bool Function(T, String)? filterFn;
  final Widget Function(BuildContext, T, bool)? itemBuilder;

  const CustomSearchableDropdown({
    super.key,
    required this.itemList,
    required this.displayItem,
    this.labelText,
     this.title,
    this.value,
    this.isRequired = false,
    this.disableBorder = false,
    this.fillColor,
    this.onChange,
    this.validator,
    this.validatorText,
    this.filterFn,
    this.itemBuilder,
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
        DropdownSearch<T>(
          selectedItem: value,
          onChanged: onChange,
          compareFn: (a, b) => displayItem(a) == displayItem(b),
          itemAsString: (item) => displayItem(item),
          items: (filter, _) => itemList,
          filterFn: filterFn ??
                  (item, filter) =>
                  displayItem(item).toLowerCase().contains(filter.toLowerCase()),
          validator: validatorText != null
              ? (val) {
            if (val == null || displayItem(val).isEmpty) {
              return validatorText;
            }
            return null;
          }
              : validator,
          dropdownBuilder: (context, item) => Text(
            item != null ? displayItem(item) :"",
            style: AppTextStyles.body(context: context),
            overflow: TextOverflow.ellipsis,
          ),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor ?? Colors.white.withOpacity(0.6),
              enabledBorder: border,
              border: border,
              focusedBorder: focusedBorder,
              errorBorder: errorBorder,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPadding.w,
                vertical: AppDimensions.verticalPadding.h / 2,
              ),
              // 🔹 এখানে logic
              labelText: (labelText != null && labelText!.isNotEmpty)
                  ? (isRequired ? "$labelText *" : labelText)
                  : null,
              hintText: "Select One",

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
          ),
          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                hintText: "Search...",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 12.w,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.border),
                  borderRadius:
                  BorderRadius.circular(AppDimensions.borderRadius.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                  borderRadius:
                  BorderRadius.circular(AppDimensions.borderRadius.r),
                ),
              ),
            ),
            itemBuilder: //itemBuilder ??
                    (context, item, isSelected, _) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 6.0),
                  child: Text(
                    displayItem(item),
                    style: AppTextStyles.body(context: context),
                  ),
                ),
          ),
        ),
      ],
    );
  }
}

