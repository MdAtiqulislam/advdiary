import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/theme/app_colors.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_text_field.dart';
import '../../../../common_widgets/show_hide_password_button.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../constraints/dimensions.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
               "Verify OTP",
              style: AppTextStyles.title(color: Colors.white),
            )),
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
        body: CustomBody(
          child: Obx(() => SingleChildScrollView(
                child: Stack(
                  children: [
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.horizontalPadding.w,
                            vertical: AppDimensions.verticalPadding.h),
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
                            Text(
                             "Reset Password",
                              style: AppTextStyles.title(color: AppColors.bodyText),
                            ),
                            SizedBox(
                              height: AppDimensions.sectionPadding.h,
                            ),
                            CustomTextField(
                              levelText: "New Password",
                              hintText: "Password",
                              isPassword: !controller.showPassword.value,
                              isRequired: true,
                              controller: controller.newPasswordController,
                              validatorText: "required",
                              suffix: ShowHidePasswordButton(
                                showPassword: controller.showPassword.value,
                                onTap: () {
                                  controller.showPassword.value =
                                      !controller.showPassword.value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: AppDimensions.widgetPadding.h,
                            ),
                            CustomTextField(
                              levelText: "Confirm Password",
                              hintText: "Password",
                              isPassword: !controller.showPassword.value,
                              controller: controller.confirmPasswordController,
                              validatorText: "required",
                              isRequired: true,
                              suffix: ShowHidePasswordButton(
                                showPassword: controller.showPassword.value,
                                onTap: () {
                                  controller.showPassword.value =
                                      !controller.showPassword.value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: AppDimensions.sectionPadding.h,
                            ),
                           Text(

                                  "Your password must be 8 digits.\nMust Contain one Capital letter, one small letter, one number & one mark.",
                             style: AppTextStyles.body(),
                            ),
                            SizedBox(
                              height: AppDimensions.sectionPadding * 3.h,
                            ),
                            AppButton(
                              text: "Continue",
                              onTap: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  controller.saveNewPassword();
                                }
                              },
                              bgColor: AppColors.primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    if (controller.isLoading.value) const LoadingScreen()
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding.w,
          vertical: AppDimensions.verticalPadding.h),
      child: InkWell(
        onTap: () {
          Get.back();
        },
        child: Row(
          children: [
            const Icon(
              Icons.arrow_back,
              color: AppColors.primaryColor,
            ),
            SizedBox(
              width: AppDimensions.widgetPadding.w,
            ),
            Text(
               "Back",
              style: AppTextStyles.header(color: AppColors.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
