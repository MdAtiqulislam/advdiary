import 'package:advdiary/constraints/app_strings.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/custom_text_field.dart';
import '../../../../common_widgets/show_hide_password_button.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _resetPasswordFormKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPadding.w),
          // height: 40,
          width: Get.width,
          child:  Text(
             "Developed by Web Solution IT Ltd.",
            style: AppTextStyles.body(),
            textAlign: TextAlign.end,
          ),
        ),
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
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            const TextSpan(
                              text: "Welcome to ",
                              style: TextStyle(
                                color: AppColors.headerText,
                              ),
                              children: [
                                TextSpan(
                                    text: "\nAdvocate's Diary",
                                    style: TextStyle(
                                        color: AppColors.primaryColor))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: AppDimensions.sectionPadding.h,
                          ),
                          loginForm(),
                          forgotPasswordSection(),
                          const Divider(),
                          SizedBox(
                            width: Get.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 Text(
                                   "Don't have an Account?",
                                   style: AppTextStyles.body(color: AppColors.headerText),
                                ),
                                SizedBox(
                                  width: AppDimensions.contentPadding.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.offAndToNamed(Routes.REGISTRATION);
                                  },
                                  child:  Text(
                                     "Register",
                                    style: AppTextStyles.body(fontWeight: FontWeight.bold,color: AppColors.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
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

  Widget loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: "Email",
            levelText: "Email",
            isRequired: true,
            textInputType: TextInputType.emailAddress,
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
            hintText: "Password",
            levelText: "Password",
            isRequired: true,
            isPassword: !controller.showPassword.value,
            suffix: ShowHidePasswordButton(
              showPassword: controller.showPassword.value,
              onTap: () => controller.showPassword.value =
                  !controller.showPassword.value,
            ),
            validatorText: "Password is Required",
            controller: controller.passwordController,
          ),
          SizedBox(
            height: AppDimensions.contentPadding.h,
          ),
          CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title:  Text( "Remember me",style: AppTextStyles.body(),),
              controlAffinity: ListTileControlAffinity.leading,
              value: controller.rememberUser.value,
              activeColor: AppColors.primaryColor,
              onChanged: (value) {
                controller.rememberUser.value = value ?? false;
              }),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
          AppButton(
            text: "Login",
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                controller.login();
              }
            },
            bgColor: AppColors.primaryColor,
          ),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
        ],
      ),
    );
  }

  Widget forgotPasswordSection() {
    return Center(
      child: InkWell(
        onTap: () {
          Get.bottomSheet(
            clipBehavior: Clip.hardEdge,
            isScrollControlled: true,

            Obx(() => SingleChildScrollView(
                  child: Container(
                    width: Get.width,
                    // color: AppColors.scaffoldBgColor,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/bg.png"),
                          fit: BoxFit.cover),
                      color: AppColors.scaffoldBg,
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppDimensions.horizontalPadding.w,
                              vertical: AppDimensions.verticalPadding.h),
                          child: Form(
                            key: _resetPasswordFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.info_outlined,
                                  color: AppColors.primaryColor,
                                  size: 80.sp,
                                ),
                                SizedBox(
                                  height: AppDimensions.sectionPadding.h,
                                ),
                                 Text(
                                   "Forgot Password",
                                   style: AppTextStyles.header( fontWeight: FontWeight.w700,),
                                ),
                                SizedBox(
                                  height: AppDimensions.widgetPadding.h,
                                ),
                                 Text(

                                        "Enter your email and we will send you an OTP to reset your password.",
                                  style: AppTextStyles.body(),
                                ),
                                SizedBox(
                                  height: AppDimensions.sectionPadding.h,
                                ),
                                CustomTextField(
                                  isRequired: true,
                                  levelText: "Email",
                                  hintText: "Enter your email",
                                  // textInputType: TextInputType.emailAddress,
                                  validator: (value) {
                                    return (value ?? "").isEmpty
                                        ? "Email is Required"
                                        : (value!.isValidEmail()
                                            ? null
                                            : "Email is not valid");
                                  },
                                  controller: controller.emailController,
                                ),
                                SizedBox(
                                  height: AppDimensions.sectionPadding.h,
                                ),
                                AppButton(
                                  text: "Submit",
                                  onTap: () {
                                    if (_resetPasswordFormKey.currentState
                                            ?.validate() ??
                                        false) {
                                      controller.getOTPForResetPassword();
                                    }
                                  },
                                  bgColor: AppColors.primaryColor,
                                ),
                                SizedBox(
                                  height: AppDimensions.sectionPadding.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child:  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.arrow_back_ios,
                                        size: AppDimensions.iconSizeMedium.sp,
                                      ),
                                      Text( "Back to Login", style: AppTextStyles.body(),)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: AppDimensions.sectionPadding * 2.h,
                                )
                              ],
                            ),
                          ),
                        ),
                        if (controller.isLoading.value)
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black12,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                )),
            // barrierColor: Colors.red[50],
            isDismissible: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppDimensions.borderRadius.r),
                topLeft: Radius.circular(AppDimensions.borderRadius.r),
              ),
            ),
            enableDrag: false,
          );
        },
        child:  Padding(
          padding: const EdgeInsets.all(AppDimensions.contentPadding),
          child: Text( "Forgot your password?", style: AppTextStyles.body(),),
        ),
      ),
    );
  }
}
