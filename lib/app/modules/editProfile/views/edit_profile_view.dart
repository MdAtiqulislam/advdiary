import 'dart:convert';

import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/common_widgets/app_button.dart';
import 'package:advdiary/common_widgets/custom_bottom_sheet.dart';
import 'package:advdiary/common_widgets/custom_circle_avatar.dart';
import 'package:advdiary/common_widgets/custom_dropdown.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/custom_text_field.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_search_drop_down_field.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../models/single_district.dart';
import '../../../../theme/app_colors.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: "Edit Profile",
          scaffoldKey: _scaffoldKey,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: Obx(
            () => Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.horizontalPadding.w,
                      vertical: AppDimensions.verticalPadding.h),
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
    return Form(
      key: formKey,
      child: Column(
        children: [
          Stack(
            children: [
              controller.base64ImageProfile.value.isEmpty
                  ? CustomCircleAvatar(
                width: 100,
                height: 100,
                image: controller.userData.value.userImage??
                    "",
                localImage: AppImagePath.avatar,
                bgColor: AppColors.primaryColor
                    .withAlpha((.5*254).toInt()),
                fit: BoxFit.cover,
              )
                  : Container(
                padding: const EdgeInsets.all(1),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.memory(
                    base64Decode(controller
                        .base64ImageProfile.value),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.white54,
                      onTap: () {
                       showCustomBottomSheet(title: "Select Image", content: chooseImage());
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),


          SizedBox(height: AppDimensions.sectionPadding.h,),
          CustomTextField(
            levelText: "Full Name",
            hintText: "Full Name",
            isRequired: true,
            controller: controller.nameController,
            validatorText: "Required",
            preFix: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 100.w,
                  child: CustomDropDownField(
                      fillColor: Colors.transparent,
                      disableBorder: true,
                      itemList: const ["Adv."],
                      value: "Adv.",
                      onChange: (value) {},
                      displayItem: (v) {
                        return "Adv.";
                      }),
                ),
                Container(
                  width: 1,
                  color: AppColors.mutedText,
                  height: 40.h,
                )
              ],
            ),
          ),
          SizedBox(height: AppDimensions.widgetPadding.h,),
          CustomTextField(
            levelText: "Email",
            hintText: "Email",
            isRequired: true,
            controller: controller.emailController,
            validatorText: "Required",
            textInputType: TextInputType.emailAddress,
          ),
          SizedBox(height: AppDimensions.widgetPadding.h,),
          CustomTextField(
            levelText: "Phone",
            hintText: "Phone",
            isRequired: true,
            controller: controller.phoneController,
            validatorText: "Required",
            maxLength: 11,
            textInputType: TextInputType.phone,
          ),
          SizedBox(height: AppDimensions.widgetPadding.h,),
          CustomSearchableDropdown(
              title: "District",
              isRequired: true,
              validatorText: "District is required",
              itemList: controller.districts,
              value: controller.selectedDistrict.value.id == null
                  ? null
                  : controller.selectedDistrict.value,
              onChange: (value) {
                controller.selectedDistrict.value = value ?? SingleDistrict();
              },
              displayItem: (value) => value.name ?? ""),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),

          CustomTextField(
          //  isRequired: true,
            hintText: "Bar Council ID No",
            levelText: "Bar Council ID No",
            //validatorText: "Licence Number is required",
            controller: controller.licenceController,
          ),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),

          CustomTextField(
            levelText: "Address",
            hintText: "Address",
            isRequired: true,
            minLine: 2,
            maxLine: 5,
            validatorText: "Required",
            controller: controller.addressController,
          ),
          SizedBox(height: AppDimensions.sectionPadding.h,),
          AppButton(text: "Update",bgColor: AppColors.primaryColor, onTap: (){
            if(formKey.currentState?.validate()??false){
              controller.updateUserProfile();
            }
          },)
        ],
      ),
    );
  }

Widget  chooseImage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: AppDimensions.sectionPadding.h,
        ),
         Text(
           "Select an action",
          style: AppTextStyles.title(color: AppColors.primaryColor),
        ),
        SizedBox(height: AppDimensions.sectionPadding.h //AppDimensions.widgetPaddingVer,
        ),
        const Divider(
          thickness: 5,
          color: AppColors.primaryColor,
        ),
        SizedBox(height: AppDimensions.sectionPadding.h // AppDimensions.contentPaddingVer,
        ),
        Container(
          margin: const EdgeInsets.all(5),
          color: Colors.white,
          child: Material(
            child: InkWell(
              onTap: () {
                controller.selectImage(
                    source: ImageSource.camera,
                    cropStyle: CropStyle.circle,
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.horizontalPadding.w, // AppDimensions.horizontalPadding,
                    vertical: AppDimensions.verticalPadding.h // AppDimensions.widgetPaddingVer
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppImagePath.cameraIcon,
                      height: 40.h,
                    ),
                    SizedBox(width: 24.w // AppDimensions.widgetPaddingHor,
                    ),
                     Text("Open Camera",style: AppTextStyles.header(),),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Divider(),
        // SizedBox(height: Dimensions.widgetPaddingVer,),
        Container(
          margin: const EdgeInsets.all(5),
          color: Colors.white,
          child: Material(
            child: InkWell(
              onTap: () {
                controller.selectImage(
                    source: ImageSource.gallery,
                    cropStyle: CropStyle.circle,);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:AppDimensions.horizontalPadding.w,
                    vertical: AppDimensions.verticalPadding.h
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppImagePath.galleryIcon,
                      height: 40.h,
                    ),
                    SizedBox(width:  AppDimensions.widgetPadding.w,
                    ),
                     Text( "Open Gallery",style: AppTextStyles.header(),),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height:AppDimensions.sectionPadding.h,
        )
      ],
    );
}
}
