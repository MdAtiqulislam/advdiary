/*import 'package:advdiary/app/modules/addOrUpdateCase/models/category_list_model.dart';
import 'package:advdiary/app/modules/caseList/controllers/case_list_controller.dart';
import 'package:advdiary/constraints/app_colors.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/constraints/header_text.dart';
import 'package:advdiary/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constraints/body_text.dart';
import '../theme/app_colors.dart';
import 'custom_search_drop_down_field.dart';
import 'custom_text_field.dart';
import 'app_button.dart';

class FilterSection extends GetView<CaseListController> {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding.w,
          vertical: AppDimensions.contentPadding.h),
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage("assets/images/moc_img_2.png"),
            fit: BoxFit.cover,
            opacity: .1),
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimensions.borderRadius.r),
        ),
        color: AppColors.secondaryColor
            .withAlpha((.25 * 254).toInt()),
      ),
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildTf(controller: controller.filterTextController,hint: "Case No/Mobile No/Name"),
                ),
                SizedBox(width: AppDimensions.contentPadding.w),
                Flexible(
                  child: categoryDropdown(itemList: controller.categoryNames.value
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.contentPadding.h,),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      controller.startDateController.text=await selectDate()??"";
                    },
                    child: _buildTf(controller: controller.startDateController,hint: "Start Date",isEnable: false)

                  ),
                ),
                SizedBox(width: AppDimensions.contentPadding.w),
                Expanded(
                  child: InkWell(
                      onTap: () async {
                        controller.endDateController.text=await selectDate()??"";
                      },
                      child: _buildTf(controller: controller.endDateController,hint: "End Date",isEnable: false)
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.contentPadding.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  text: 'Search',
                  bgColor: AppColors.primaryColor,
                  borderColor: AppColors.primaryColor,
                  onTap: () {
                    controller.filterCaseList();
                  },
                  textTransform: TextTransform.none,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  width: 80.w,
                  borderRadius: 10,
                  verticalPadding: 5,
                ),
                SizedBox(width: AppDimensions.widgetPadding.w),
                AppButton(
                  text: 'Clear',
                  bgColor: AppColors.danger,
                  borderColor: AppColors.danger,
                  onTap: () {
                    controller.clearFilter();
                  },
                  textTransform: TextTransform.none,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  width: 80.w,
                  borderRadius: 10,
                  verticalPadding: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    ));

  }

  Widget _buildTf({
    required TextEditingController controller,
    required String hint,
    bool isEnable=true,
  }){
    return  Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white54,
      ),

      child: TextFormField(
        onTap: (){

        },
        enabled: isEnable,
        controller: controller,
        validator: (value){
          return "Required";
        },

        style: const TextStyle(fontSize: 12,color: Colors.black),
      decoration: InputDecoration(
      hintText: hint,
      border: const OutlineInputBorder(),
      disabledBorder: const OutlineInputBorder(),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        hintStyle: TextStyle(fontSize: 11,color: AppColors.headerText),

      ),
      ),
    );
  }

  categoryDropdown({required List<String> itemList}) {
    return Container(
      color: Colors.white38,
      child: DropdownButtonFormField<String>(
        isExpanded: true,

        decoration: InputDecoration(
          border: OutlineInputBorder(),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        hint: Text("Select One",style: TextStyle(color: AppColors.headerText),),
        selectedItemBuilder: (BuildContext context) {
          return itemList.map<Widget>((String item) {
            return Text(
               item,
            );
          }).toList();
        },
        style: TextStyle(fontSize: 11),

        items: itemList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                //  padding: const EdgeInsets.all(8.0),
                  child: Text(
                     value,

                  ),
                ),
                const Divider(),
              ],
            ),
          );
        }).toList(),

        onChanged: (value) {},
      ),
    );
  }

}*/








import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constraints/dimensions.dart';
import '../theme/app_colors.dart';
import 'app_button.dart';
import '../utils/utils.dart'; // for selectDate()

class CustomFilter extends StatelessWidget {
  final List<FilterField> fields;
  final VoidCallback onSearch;
  final VoidCallback onClear;

  const CustomFilter({
    super.key,
    required this.fields,
    required this.onSearch,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.contentPadding.w,
        vertical: AppDimensions.contentPadding.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimensions.borderRadius.r),
        ),
        color: AppColors.secondaryColor.withAlpha((0.15 * 254).toInt()),
      ),
      child: Column(
        children: [
          ..._buildFieldRows(), // row wise layout
         // SizedBox(height: AppDimensions.contentPadding.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                text: 'Search',
                bgColor: AppColors.primaryColor,
               showBorder: false,
                onTap: onSearch,
                textTransform: TextTransform.none,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                width: 80.w,
                borderRadius: 10,
                verticalPadding: 5,
              ),
              SizedBox(width: AppDimensions.widgetPadding.w),
              AppButton(
                text: 'Clear',
                bgColor: AppColors.danger,
               showBorder: false,
                onTap: onClear,
                textTransform: TextTransform.none,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                width: 80.w,
                borderRadius: 10,
                verticalPadding: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Row-wise field builder
  List<Widget> _buildFieldRows() {
    List<Widget> rows = [];
    for (int i = 0; i < fields.length; i += 2) {
      final first = fields[i];
      final second = i + 1 < fields.length ? fields[i + 1] : null;

      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: AppDimensions.contentPadding.h),
          child: Row(
            children: [
              Expanded(child: _buildField(first)),
              if (second != null) ...[
                SizedBox(width: AppDimensions.contentPadding.w),
                Expanded(child: _buildField(second)),
              ],
            ],
          ),
        ),
      );
    }
    return rows;
  }

  Widget _buildField(FilterField field) {
    final decoration = InputDecoration(
      hintText: field.label,
      border: const OutlineInputBorder(),
      isDense: true,
      contentPadding:  EdgeInsets.symmetric(horizontal: AppDimensions.contentPadding.w, vertical: AppDimensions.contentPadding.h),
      hintStyle:  TextStyle(fontSize: AppDimensions.smallTextSize.sp, color: AppColors.bodyText),
    );

    switch (field.type) {
      case FilterFieldType.text:
        return TextFormField(
          enabled: field.enabled,
          controller: field.controller,
          decoration: decoration,
          style:  AppTextStyles.body(fontSize: 10, color: Colors.black),
        );

      case FilterFieldType.date:
        return InkWell(
          onTap: () async {
            field.controller?.text = await selectDate() ?? "";
          },
          child: TextFormField(
            enabled: false,
            controller: field.controller,
            decoration: decoration,
            style:  AppTextStyles.body(fontSize: 10, color: Colors.black),
          ),
        );

      case FilterFieldType.dropdown:
        return DropdownButtonFormField<String>(
          isExpanded: true,
          value: (field.controller?.text??"").isEmpty?null:field.controller?.text,
          isDense: true,
          iconSize: 10.sp, // responsive icon size
         // style: AppTextStyles.body(fontSize: 10.sp, color: Colors.black,resizeAble: true),
          style: TextStyle(fontSize: 10.sp, color: Colors.black),
          decoration: decoration.copyWith(
          contentPadding: EdgeInsets.symmetric(vertical: 5.h,horizontal: AppDimensions.horizontalPadding.w)
          ),
          hint: Text(
            field.label,
            style: TextStyle(
              fontSize: AppDimensions.smallTextSize.sp,
              color: AppColors.bodyText,
            ),
          ),
          items: field.options
              ?.map((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(
              e,
              style: AppTextStyles.body(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ))
              .toList() ??
              [],
          onChanged: field.enabled ? (val) {

            field.controller?.text=val!;
          } : null,
        );

    }
  }

}

enum FilterFieldType { text, dropdown, date }

class FilterField {
  final FilterFieldType type;
  final String label;
  final TextEditingController? controller;
  final List<String>? options; // for dropdown
  final bool enabled;

  FilterField({
    required this.type,
    required this.label,
    this.controller,
    this.options,
    this.enabled = true,
  });
}

