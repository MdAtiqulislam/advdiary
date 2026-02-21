import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/models/single_court_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_bottom_sheet.dart';
import '../../../../common_widgets/custom_text_field.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../theme/app_colors.dart';
import '../../../../utils/utils.dart';
import '../controllers/court_setting_controller.dart';
import 'court_tile.dart';

class CourtSettingView extends GetView<CourtSettingController> {
  CourtSettingView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar:  CustomAppBar(title: "Court Settings",scaffoldKey: _scaffoldKey,),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPadding.w,
              vertical: AppDimensions.verticalPadding.h,
            ),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return Stack(
                children: [
                  controller.courtList.isEmpty
                      ? const Center(child: Text("No courts found."))
                      : ListView.separated(
                          itemCount: controller.courtList.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (_, index) {
                            final court = controller.courtList[index];
                            return CourtTile(
                              court: court,
                              onEdit: () {
                                controller.selectedCourt.value = (court);
                                controller.courtNameController.text =
                                    court.cortName ?? "";
                                showCustomBottomSheet(
                                    title: "Update Court",
                                    content:
                                        addOrUpdateCourtForm(type: "Update"));
                              },
                              onDelete: () => controller.deleteCourt(court),
                            );
                          },
                        ),
                  if (controller.isUpdating.value) const LoadingScreen()
                ],
              );
            }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showCustomBottomSheet(
                title: "Add New Court",
                content: addOrUpdateCourtForm(type: "New"));
          },
          // This sets the plus icon
          backgroundColor: AppColors.primaryColor,
          // You can change the color if you want
          shape: const CircleBorder(),
          child:  Icon(
            Icons.add,
            color: Colors.white,
            size: AppDimensions.iconSizeMedium.sp,
          ), // Makes sure it's circular
        ),
      ),
    );
  }

  Widget addOrUpdateCourtForm({required String type, re}) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: AppDimensions.sectionPadding.h,
          ),
          CustomTextField(
            levelText: "Court Name",
            hintText: "Court Name",
            validatorText: "Required",
            controller: controller.courtNameController,
            isRequired: true,
          ),
          SizedBox(
            height: AppDimensions.sectionPadding.h,
          ),
          AppButton(
            text: type == "New" ? "Save" : "Update",
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                type == "New"
                    ? controller.addCourt()
                    : controller.editCourt(SingleCourtModel());
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
