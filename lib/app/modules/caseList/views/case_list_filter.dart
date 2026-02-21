import 'package:advdiary/app/modules/addOrUpdateCase/models/category_list_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/app_button.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/utils.dart';
import '../controllers/case_list_controller.dart';

class CaseListFilter extends GetView<CaseListController> {
  const CaseListFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
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
          _buildRow(
            children: [
              _buildTextField(controller.filterTextController, "Case No/Mobile No/Name"),
              _buildDropdown(),
            ],
          ),
          SizedBox(height: AppDimensions.contentPadding.h),
          _buildRow(
            children: [
              _buildDateField(controller.startDateController, "Start Date"),
              _buildDateField(controller.endDateController, "End Date"),
            ],
          ),
          SizedBox(height: AppDimensions.contentPadding.h),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildRow({required List<Widget> children}) {
    return Row(
      children: [
        for (int i = 0; i < children.length; i++) ...[
          Expanded(child: children[i]),
          if (i != children.length - 1)
            SizedBox(width: AppDimensions.contentPadding.w),
        ],
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      style: AppTextStyles.body(fontSize: 12, color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.contentPadding.w,
          vertical: AppDimensions.contentPadding.h,
        ),
        hintStyle: TextStyle(fontSize: AppDimensions.bodyTextSize.sp, color: AppColors.bodyText),
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, String hint) {
    return InkWell(
      onTap: () async {
        controller.text = await selectDate() ?? "";
      },
      child: TextFormField(
        controller: controller,
        enabled: false,
        style: AppTextStyles.body(fontSize: 12, color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimensions.contentPadding.w,
            vertical: AppDimensions.contentPadding.h,
          ),
          hintStyle: TextStyle(fontSize: AppDimensions.bodyTextSize.sp, color: AppColors.bodyText),
        ),
      ),
    );
  }

/*  Widget _buildDropdown() {
    return Obx(() {
      return DropdownButtonFormField<String>(
        isExpanded: true,
        value: (controller.selectedCategory.value.caseCategory??"").isEmpty
            ? null
            : controller.selectedCategory.value.caseCategory,
        style: TextStyle(fontSize: 12.sp, color: Colors.black),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimensions.contentPadding.w,
            vertical: AppDimensions.contentPadding.h,
          ),
          hintStyle: TextStyle(fontSize: AppDimensions.smallTextSize.sp, color: AppColors.bodyText),
        ),
        hint: Text(
          "Select Category",
          style: TextStyle(fontSize: 12.sp, color: AppColors.bodyText),
        ),
        items: controller.categoryNames
            .map((e) => DropdownMenuItem(
          value: e,
          child: Text(e, style: AppTextStyles.body(fontSize: 12, color: Colors.black),maxLines: 1,),
        ))
            .toList(),
        onChanged: (val) {
          if (val == null) return;
          controller.selectedCategory.value = controller.categoryListModel.value.data!
              .firstWhere((element) => element.caseCategory == val,
              orElse: () => SingleCategoryModel());
        },
      );
    });
  }*/


  Widget _buildDropdown() {
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

           // constraints: const BoxConstraints(maxHeight: 250),
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


  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton(
          text: 'Search',
          bgColor: AppColors.primaryColor,
          borderColor: AppColors.primaryColor,
          onTap: controller.filterCaseList,
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
            controller.selectedCategory.value = SingleCategoryModel();
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

}
