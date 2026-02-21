import 'package:advdiary/app/modules/addOrUpdateCase/models/category_list_model.dart';
import 'package:advdiary/app/modules/caseReport/controllers/case_report_controller.dart';
import 'package:advdiary/models/single_court_model.dart';
import 'package:advdiary/models/status_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/app_button.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../theme/app_colors.dart';

class CortReportFilter extends GetView<CaseReportController> {
  const CortReportFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.contentPadding.w,
        vertical: AppDimensions.contentPadding.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        color: AppColors.secondaryColor.withAlpha((.15 * 254).toInt()),
        image: const DecorationImage(
          image: AssetImage("assets/images/moc_img_2.png"),
          fit: BoxFit.cover,
          opacity: .1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _courtDropdown(),
              ),
              SizedBox(
                width: AppDimensions.contentPadding.w,
              ),
              Expanded(
                child: _categoryDropdown(),
              )
            ],
          ),
          SizedBox(height: AppDimensions.contentPadding.h),
          _statusDropdown(),
          SizedBox(height: AppDimensions.contentPadding.h),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton(
          text: 'Search',
          bgColor: AppColors.primaryColor,
          borderColor: AppColors.primaryColor,
          onTap: () {
            controller.getCaseReport();
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
            //controller.selectedCategory.value = SingleCategoryModel();
          },
          textTransform: TextTransform.none,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          width: 80.w,
          borderRadius: 10,
          verticalPadding: 5,
        ),
      ],
    );
  }
/*

  _cortDropdown() {
    return Obx(() {
      return DropdownButtonFormField<String>(
        isExpanded: true,
        value: (controller.selectedCourt.value.cortName ?? "").isEmpty
            ? null
            : controller.selectedCourt.value.cortName,
        style: TextStyle(fontSize: 12.sp, color: Colors.black),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimensions.contentPadding.w,
            vertical: 5.h,
          ),
          hintStyle: TextStyle(
              fontSize: AppDimensions.bodyTextSize.sp,
              color: AppColors.bodyText),
        ),
        hint: Text(
          "Select Court",
          style: TextStyle(
              fontSize: AppDimensions.bodyTextSize.sp,
              color: AppColors.bodyText),
        ),
        items: controller.courtNames
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e,
                      style: AppTextStyles.body(
                          fontSize: 10, color: Colors.black)),
                ))
            .toList(),
        onChanged: (val) {
          if (val == null) return;
          controller.selectedCourt.value = controller.courtListModel.value.data!
              .firstWhere((element) => element.cortName == val,
                  orElse: () => SingleCourtModel());
        },
      );
    });
  }

  _statusDropdown() {
    return Obx(() {
      return DropdownButtonFormField<String>(
        isExpanded: true,
        value: (controller.selectedStatus.value.name ?? "").isEmpty
            ? null
            : controller.selectedStatus.value.name,
        style: TextStyle(fontSize: 12.sp, color: Colors.black),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimensions.contentPadding.w,
            vertical: 5.h,
          ),
          hintStyle: TextStyle(
              fontSize: AppDimensions.bodyTextSize.sp,
              color: AppColors.bodyText),
        ),
        hint: Text(
          "Select Status",
          style: TextStyle(
              fontSize: AppDimensions.bodyTextSize.sp,
              color: AppColors.bodyText),
        ),
        items: controller.statusNames
            .map((e) => DropdownMenuItem(
          value: e,
          child: Text(e,
              style: AppTextStyles.body(
                  fontSize: 10, color: Colors.black)),
        ))
            .toList(),
        onChanged: (val) {
          if (val == null) return;
          controller.selectedStatus.value = controller
              .statusListModel.value.data!
              .firstWhere((element) => element.name == val,
              orElse: () => SingleStatusModel());
        },
      );
    });
  }
*/


  Widget _courtDropdown() {
    return Obx(() {
      return SizedBox(
        height: 35.sp,
        child: DropdownSearch<String>(
          items: (filter, _) => controller.courtNames,
          selectedItem: (controller.selectedCourt.value.cortName ?? "").isEmpty
              ? null
              : controller.selectedCourt.value.cortName,
          popupProps: PopupProps.menu(
            showSearchBox: true,
            fit: FlexFit.loose,
          //  constraints: const BoxConstraints(maxHeight: 250),
            searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                hintText: "Search Court",
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            itemBuilder: (context, item, isSelected, _) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text(
                item,
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppDimensions.contentPadding.w,
                vertical: AppDimensions.contentPadding.h,
              ),
              hintStyle: TextStyle(
                fontSize: AppDimensions.smallTextSize.sp,
                color: AppColors.bodyText,
              ),
            ),
          ),
          dropdownBuilder: (context, selectedItem) {
            return Text(
              selectedItem ?? "Select Court",
              style: TextStyle(
                fontSize: 12.sp,
                color: selectedItem == null ? AppColors.bodyText : Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          },
          onChanged: (val) {
            if (val == null) return;
            controller.selectedCourt.value = controller.courtListModel.value.data!
                .firstWhere(
                  (element) => element.cortName == val,
              orElse: () => SingleCourtModel(),
            );
          },
        ),
      );
    });
  }

  Widget _statusDropdown() {
    return Obx(() {
      return SizedBox(
        height: 35.sp,
        child: DropdownSearch<String>(
          items: (filter, _) => controller.statusNames,
          selectedItem: (controller.selectedStatus.value.name ?? "").isEmpty
              ? null
              : controller.selectedStatus.value.name,
          popupProps: PopupProps.menu(
            showSearchBox: true,
            fit: FlexFit.loose,
           // constraints: const BoxConstraints(maxHeight: 250),
            searchFieldProps: TextFieldProps(
              decoration: const InputDecoration(
                hintText: "Search Status",
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            itemBuilder: (context, item, isSelected, _) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text(
                item,
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppDimensions.contentPadding.w,
                vertical: AppDimensions.contentPadding.h,
              ),
              hintStyle: TextStyle(
                fontSize: AppDimensions.smallTextSize.sp,
                color: AppColors.bodyText,
              ),
            ),
          ),
          dropdownBuilder: (context, selectedItem) {
            return Text(
              selectedItem ?? "Select Status",
              style: TextStyle(
                fontSize: 12.sp,
                color: selectedItem == null ? AppColors.bodyText : Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          },
          onChanged: (val) {
            if (val == null) return;
            controller.selectedStatus.value = controller.statusListModel.value.data!
                .firstWhere(
                  (element) => element.name == val,
              orElse: () => SingleStatusModel(),
            );
          },
        ),
      );
    });
  }

  Widget _categoryDropdown() {
    return Obx(() {
      return SizedBox(
        height: 35.sp,
        child: DropdownSearch<String>(
          items: (filter, _) => controller.categoryNames, // searchable list
          selectedItem: (controller.selectedCategory.value.caseCategory ?? "").isEmpty
              ? null
              : controller.selectedCategory.value.caseCategory,
          popupProps: PopupProps.menu(
            showSearchBox: true,
            fit: FlexFit.loose,

            //constraints: const BoxConstraints(maxHeight: 250),
            searchFieldProps: TextFieldProps(
              decoration: const InputDecoration(
                hintText: "Search Category",
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black,
              ),
            ),
            itemBuilder: (context, item, isSelected,_) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text(
                item,
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppDimensions.contentPadding.w,
                vertical: AppDimensions.contentPadding.h,
              ),
              hintStyle: TextStyle(
                fontSize: AppDimensions.smallTextSize.sp,
                color: AppColors.bodyText,
              ),
            ),
          ),
          dropdownBuilder: (context, selectedItem) {
            return Text(
              selectedItem ?? "Select Category",
              style: TextStyle(
                fontSize: 12.sp,
                color: selectedItem == null ? AppColors.bodyText : Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          },

          onChanged: (val) {
            if (val == null) return;
            controller.selectedCategory.value = controller.categoryListModel.value.data!
                .firstWhere(
                  (element) => element.caseCategory == val,
              orElse: () => SingleCategoryModel(),
            );
          },
        ),
      );
    });
  }

}
