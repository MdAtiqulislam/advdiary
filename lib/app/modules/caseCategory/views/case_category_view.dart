import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/app/modules/caseCategory/models/case_category_list_model.dart';
import 'package:advdiary/app/modules/caseCategory/views/single_case_category.dart';
import 'package:advdiary/common_widgets/app_button.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/custom_text_field.dart';
import 'package:advdiary/common_widgets/empty_screen.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_bottom_sheet.dart';
import '../../../../common_widgets/custom_dialog.dart';
import '../../../../theme/app_colors.dart';
import '../controllers/case_category_controller.dart';

class CaseCategoryView extends GetView<CaseCategoryController> {
  CaseCategoryView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: "Case Category List",
          scaffoldKey: _scaffoldKey,
         // showDrawerButton: controller.showDrawerButton.value,
        ),
        drawer: MyDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showCustomBottomSheet(
                title: "Add New Case Category",
                content: addOrUpdateCaseForm(type: "New"));
          },
          // This sets the plus icon
          backgroundColor: AppColors.primaryColor,
          // You can change the color if you want
          shape: const CircleBorder(),
          child:  Icon(
            Icons.add,
            color: Colors.white,
            size: AppDimensions.iconSizeLarge.sp,
          ), // Makes sure it's circular
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: Obx(
            () => Stack(
              children: [
                SingleChildScrollView(
                  child: bodyContent(),
                ),
                if (controller.isLoading.value) const LoadingScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyContent() {
    return (controller.caseCategoryList.value.data ?? []).isEmpty &&
            !controller.isLoading.value
        ? const EmptyScreen(title: "No data found!")
        : ListView.separated(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPadding.w,
                vertical: AppDimensions.verticalPadding.h),
            itemCount: controller.caseCategoryList.value.data?.length ?? 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (buildContext, index) {
              return SingleCaseCategoryCard(
                caseCategory: controller.caseCategoryList.value.data?[index] ??
                    SingleCaseCategoryModel(),
                onDelete: () {
                  showDialog(
                    context: Get.context!,
                    builder: (BuildContext context) {
                      return CustomDialog(
                        title: "Delete Case Category",
                        subtitle: "Are you sure you want to delete this case category?",
                        description:
                            "This action cannot be undone. Once deleted, all associated data with this case category will be permanently removed.",
                        icon:  Icon(
                          Icons.warning_amber_outlined,
                          color: AppColors.danger,
                          size: 40.sp,
                        ),
                        confirmButtonText: "Confirm",
                        confirmButtonColor: AppColors.danger,
                        cancelButtonText: "Cancel",
                        cancelButtonColor: AppColors.success,
                        onConfirmButtonPressed: () {
                          Get.back();
                          controller.deleteCaseCategory(
                              deleteId:
                                  (controller.caseCategoryList.value.data?[index].id)
                                      .toString());
                        },
                      );
                    },
                  );
                },
                onEdit: () {
                  controller.selectedCaseCategory.value =
                      controller.caseCategoryList.value.data?[index] ??
                          SingleCaseCategoryModel();
                  controller.categoryNameController.text =
                      controller.selectedCaseCategory.value.caseCategory ?? "";
                  showCustomBottomSheet(
                      title: "Update Case Category",
                      content: addOrUpdateCaseForm(type: "Update"));
                },
              );
            }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: AppDimensions.widgetPadding.h,);},
          );
  }

  Widget addOrUpdateCaseForm({required String type}) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(
            height: AppDimensions.sectionPadding.h,
          ),
          CustomTextField(
            levelText: "Category Name",
            hintText: "Category Name",
            validatorText: "Required",
            controller: controller.categoryNameController,
            isRequired: true,
          ),
          SizedBox(
            height: AppDimensions.sectionPadding.h,
          ),
          AppButton(
            text: type == "New" ? "Save" : "Update",
            onTap: () {
              if (formKey.currentState?.validate() ?? false) {
                type == "New"
                    ? controller.addNewCaseCategory()
                    : controller.updateCaseCategory();
              }
            },
            bgColor: AppColors.primaryColor,
          ),
          SizedBox(
            height: AppDimensions.sectionPadding.h,
          )
        ],
      ),
    );
  }
}
