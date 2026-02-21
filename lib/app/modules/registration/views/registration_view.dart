import 'package:advdiary/common_widgets/custom_dropdown.dart';
import 'package:advdiary/common_widgets/custom_search_drop_down_field.dart';
import 'package:advdiary/models/single_district.dart';
import 'package:advdiary/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/custom_text_field.dart';
import '../../../../common_widgets/show_hide_password_button.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/utils.dart';
import '../../../routes/app_pages.dart';
import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPadding.w),
          // height: 40,
          width: Get.width,
          child: Text(
             "Developed by Web Solution IT Ltd.",
            textAlign: TextAlign.end,
            style: AppTextStyles.body(),
          ),
        ),

        // bottomNavigationBar: bottomNavBar(),
        body: CustomBody(
          child: Obx(
            () => Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.horizontalPadding.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: AppDimensions.sectionPadding.h,
                          ),
                          Image.asset(
                            AppImagePath.appLogo,
                            height: 100,
                            width: Get.width,
                          ),
                          SizedBox(
                            height: AppDimensions.sectionPadding.h,
                          ),
                          Text.rich(
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 25.sp),
                            const TextSpan(
                                text: "Wants to be ",
                                style: TextStyle(
                                  color: AppColors.headerText,
                                ),
                                children: [
                                  TextSpan(
                                      text: "registered?",
                                      style: TextStyle(
                                          color: AppColors.primaryColor))
                                ]),
                          ),
                          SizedBox(
                            height: AppDimensions.sectionPadding.h,
                          ),
                          registrationForm(),
                          loginButton(),
                          SizedBox(
                            height: AppDimensions.sectionPadding.h,
                          ),
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

  Widget registrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            isRequired: true,
            hintText: "Name",
            levelText: "Name",
            validatorText: "Name is required",
            controller: controller.nameController,
            // textInputType: TextInputType.name,
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
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
          CustomTextField(
            isRequired: true,
            hintText: "xyz@mail.com",
            levelText: "Email",
            //  textInputType: TextInputType.emailAddress,
            validator: (value) {
              return (value ?? "").isEmpty
                  ? "Email is Required"
                  : (value!.isValidEmail() ? null : "Email is not valid");
            },
            controller: controller.emailController,
          ),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
          CustomTextField(
            isRequired: true,
            hintText: "Phone",
            levelText: "Phone",
            validatorText: "Phone is required",
            maxLength: 11,
            textInputType: TextInputType.phone,
            controller: controller.phoneController,
          ),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),

          CustomTextField(
            //isRequired: true,
            hintText: "Bar Council ID No",
            levelText: "Bar Council ID No",
            //validatorText: "Licence Number is required",
            controller: controller.licenceController,
          ),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
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
            isRequired: true,
            hintText: "Address",
            levelText: "Address",
            validatorText: "Address is required",
            maxLine: 5,
            minLine: 2,
            controller: controller.addressController,
          ),
          //  phoneTextField(),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
          CustomTextField(
              isRequired: true,
              isPassword: !controller.showPassword.value,
              hintText: "Password",
              levelText: "Password",
              validatorText: "Password is required",
              controller: controller.passwordController,
              suffix: ShowHidePasswordButton(
                showPassword: controller.showPassword.value,
                onTap: () => controller.showPassword.value =
                    !controller.showPassword.value,
              )),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
          CustomTextField(
            isRequired: true,
            isPassword: !controller.showPassword.value,
            hintText: "Confirm Password",
            levelText: "Confirm Password",
            validatorText: "Confirm Password is required",
            controller: controller.confirmPasswordController,
            suffix: ShowHidePasswordButton(
              showPassword: controller.showPassword.value,
              onTap: () => controller.showPassword.value =
                  !controller.showPassword.value,
            ),
          ),

           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                  "Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character.",
              style: AppTextStyles.body(color: AppColors.mutedText),
            ),
          ),
          CheckboxListTile(
            value: controller.isChecked.value,
            onChanged: (value) {
              controller.isChecked.value = value ?? false;
            },
            title: Text(
               "I have read and agree with the terms and conditions.",
              style: AppTextStyles.header(),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            secondary: IconButton(
                onPressed: () {
                  showHtmlDialog(
                      title: 'Terms and Conditions',
                      htmlContent: controller.termsAndConditions.value);
                },
                icon: const Icon(
                  Icons.info_outline,
                  color: AppColors.info,
                )),
          ),
          SizedBox(
            height: AppDimensions.sectionPadding.h,
          ),
          AppButton(
            text: "Next",
            onTap: () {
              //controller.verifyCaptcha();
              if (_formKey.currentState?.validate() ?? false) {
                controller.register();
              }
            },
            bgColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget loginButton() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding.w,
          vertical: AppDimensions.verticalPadding.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text( "Already have an Account?",style: AppTextStyles.title(),),
          SizedBox(
            width: AppDimensions.contentPadding.w,
          ),
          InkWell(
            onTap: () {
              Get.offAndToNamed(Routes.LOGIN);
            },
            child: Text(
               "Login",

              style: AppTextStyles.header(color: AppColors.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
