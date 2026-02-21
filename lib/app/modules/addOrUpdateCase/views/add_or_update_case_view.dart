import 'package:advdiary/app/modules/addOrUpdateCase/models/category_list_model.dart';
import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/common_widgets/app_button.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/custom_search_drop_down_field.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/custom_text_field.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/models/single_court_model.dart';
import 'package:advdiary/models/single_district.dart';
import 'package:advdiary/models/single_thana.dart';
import 'package:advdiary/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../theme/app_colors.dart';
import '../../bottom_navigation_bar/custom_bottom_nav_bar.dart';
import '../controllers/add_or_update_case_controller.dart';

class AddOrUpdateCaseView extends GetView<AddOrUpdateCaseController> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AddOrUpdateCaseView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateStatusBar();
    });
    return SafeArea(
      child: Obx(
        () => Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            title: "${controller.type.value} Case",
            scaffoldKey: _scaffoldKey,
          ),
          drawer: MyDrawer(),
          bottomNavigationBar: CustomBottomNavigationBar(),
          body: CustomBody(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: AppDimensions.horizontalPadding.w,
                        vertical: AppDimensions.sectionPadding.h),
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.horizontalPadding.w),
                    decoration: BoxDecoration(
                        color: AppColors.scaffoldBg,
                        borderRadius:
                            BorderRadius.circular(AppDimensions.borderRadius.r),
                        boxShadow: const [
                          BoxShadow(color: AppColors.shadow, blurRadius: 5)
                        ]),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppDimensions.sectionPadding.h),

                          CustomSearchableDropdown<SingleCategoryModel>(
                            title: "Category",
                            isRequired: true,
                            validatorText: "Required",
                            itemList:
                            controller.categoryListModel.value.data ?? [],
                            value: controller.selectedCategory.value.id == null
                                ? null
                                : controller.selectedCategory.value,
                            onChange: (value) {
                              controller.selectedCategory.value =
                                  value ?? SingleCategoryModel();
                            },
                            displayItem: (category) =>
                            category.caseCategory ?? "",
                          ),



                          SizedBox(height: AppDimensions.widgetPadding.h),

                          CustomTextField(
                            levelText: "Case No",
                            hintText: "Ex: 101/2024",
                            isRequired: controller.selectedCategory.value.id!=3,
                            validatorText: controller.selectedCategory.value.id!=3?"Required":null,
                            controller: controller.caseNoController,
                          ),

                          SizedBox(
                            height: AppDimensions.widgetPadding.h,
                          ),
                          //district dropdown
                          CustomSearchableDropdown<SingleDistrict>(
                            title: "District",
                            isRequired: true,
                            validatorText: "Required",
                            itemList: controller.districts,
                            value: controller.selectedDistrict.value.id == null
                                ? null
                                : controller.selectedDistrict.value,
                            onChange: (value) {
                              controller.selectedDistrict.value =
                                  value ?? SingleDistrict();
                              controller.selectedThana.value=SingleThana();
                              controller.getThana();
                            },
                            displayItem: (district) =>
                                district.name ?? "",
                          ),

                          SizedBox(
                            height: AppDimensions.widgetPadding.h,
                          ),
                          //district dropdown
                          CustomSearchableDropdown<SingleThana>(
                            title: "Thana",
                            isRequired: true,
                            validatorText: "Required",
                            itemList: controller.thanas,
                            value: controller.selectedThana.value.id == null
                                ? null
                                : controller.selectedThana.value,
                            onChange: (value) {
                              controller.selectedThana.value =
                                  value ?? SingleThana();
                            },
                            displayItem: (thana) =>
                            thana.name ?? "",
                          ),

                          if (controller.selectedCategory.value.id == 3) ...[
                            SizedBox(height: AppDimensions.widgetPadding.h),
                            CustomTextField(
                              levelText: "G.R. Case No",
                              hintText: "Ex: 1(10)25",
                              isRequired: true,
                              validatorText: "Required",
                              controller: controller.grCaseNoController,
                            ),
                          ],
                          SizedBox(height: AppDimensions.widgetPadding.h),

                          CustomSearchableDropdown<SingleCourtModel>(
                            title: "Court",
                            isRequired: true,
                            validatorText: "Required",
                            itemList: controller.courtList,
                            value: controller.selectedCourt.value.id == null
                                ? null
                                : controller.selectedCourt.value,
                            onChange: (value) {
                              controller.selectedCourt.value =
                                  value ?? SingleCourtModel();
                            },
                            displayItem: (value) =>
                            value.cortName ?? "",
                          ),


                          SizedBox(height: AppDimensions.widgetPadding.h),
                          InkWell(
                            onTap: () async {
                              // controller.selectDate();
                              controller.dateController.text =
                                  await selectDate() ?? "";
                            },
                            child: CustomTextField(
                              levelText: "Case Date",
                              hintText: "Case Date",
                              isRequired: true,
                              isEnable: false,
                              validatorText: "Required",
                              controller: controller.dateController,
                            ),
                          ),
                          SizedBox(height: AppDimensions.widgetPadding.h),
                          CustomTextField(
                            levelText: "Client",
                            hintText: "Client Name",
                            isRequired: true,
                            validatorText: "Required",
                            controller: controller.clientNameController,
                          ),

                          SizedBox(height: AppDimensions.widgetPadding.h),
                          CustomTextField(
                            levelText: "Other Side",
                            hintText: "Other Party Name",
                            isRequired: true,
                            validatorText: "Required",
                            controller: controller.otherSideController,
                          ),
                          SizedBox(height: AppDimensions.widgetPadding.h),
                          CustomTextField(
                            levelText: "Mobile No",
                            hintText: "Ex: 01xxxxxxxxx",
                            maxLength: 11,
                            isRequired: true,
                            validatorText: "Required",
                            textInputType: TextInputType.phone,
                            controller: controller.phoneController,
                          ),
                          SizedBox(height: AppDimensions.widgetPadding.h),
                          CustomTextField(
                            levelText: "Payment",
                            hintText: "Payment Amount",
                            textInputType: TextInputType.number,
                            controller: controller.paymentController,
                          ),
                          SizedBox(height: AppDimensions.widgetPadding.h),
                          CustomTextField(
                            levelText: "Notes",
                            hintText: "Notes",
                            controller: controller.remarksController,
                          ),
                          SizedBox(height: AppDimensions.sectionPadding.h),


                          //should use elevated button
                          if (controller.type.value == "Add New")
                            AppButton(
                              text: "Save",
                              onTap: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  controller.addNewCase();
                                }
                              },
                              bgColor: AppColors.primaryColor,
                              // padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                          if (controller.type.value == "Update")
                            AppButton(
                              text: "Update",
                              onTap: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  controller.updateCase(
                                      editId: controller.caseId);
                                }
                              },
                              bgColor: AppColors.primaryColor,
                              // padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                          SizedBox(height: AppDimensions.sectionPadding.h),
                        ],
                      ),
                    ),
                  ),
                ),
                if (controller.isLoading.value) const LoadingScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
