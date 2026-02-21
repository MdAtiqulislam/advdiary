import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/single_otp_box.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
               "Verify OTP",
              style: AppTextStyles.header(),
            )),
        /*CustomAppBar(
          title: "Verify OTP",
          minimal: true,
        ),*/
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPadding.w),
          // height: 40,
          width: Get.width,
          child:  Text(
             "Developed by Web Solution IT Ltd.",
            textAlign: TextAlign.end,
            style: AppTextStyles.body(),
          ),
        ),
        body: CustomBody(
          child: Obx(
            () => Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.horizontalPadding.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        otpSection(),
                        if (controller.wrongOTP.value)
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: AppDimensions.widgetPadding.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(
                                   "OTP doesn’t match.",
                                   style: AppTextStyles.body(),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            AppDimensions.contentPadding.h),
                                    child: Text(
                                         "Try with different account?",
                                      style: AppTextStyles.body(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        SizedBox(
                          height: AppDimensions.sectionPadding.h,
                        ),
                        resendOTPSection(),
                        SizedBox(
                          height: AppDimensions.sectionPadding * 3.h,
                        ),
                        IgnorePointer(
                            ignoring: !controller.isValidate.value,
                            child: AppButton(
                              text: "Next",
                              onTap: () {
                                controller.handelNext();
                              },
                              bgColor: controller.isValidate.value
                                  ? AppColors.primaryColor
                                  : AppColors.mutedText,
                            ))
                      ],
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

  otpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
           "Enter your 6 digit code we’ve sent to your email",
          style: AppTextStyles.header(),
        ),
        SizedBox(
          height: AppDimensions.contentPadding.h,
        ),
        Text(
           controller.provider.value,
          style: AppTextStyles.body(color: AppColors.mutedText),
        ),
        SizedBox(
          height: AppDimensions.sectionPadding.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SingleOTPBox(
              verified: controller.isValidate.value,
              wrongOTP: controller.wrongOTP.value,
              controller: controller.c1,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(
              width: AppDimensions.contentPadding.w,
            ),
            SingleOTPBox(
              verified: controller.isValidate.value,
              wrongOTP: controller.wrongOTP.value,
              controller: controller.c2,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(
              width: AppDimensions.contentPadding.w,
            ),
            SingleOTPBox(
              verified: controller.isValidate.value,
              wrongOTP: controller.wrongOTP.value,
              controller: controller.c3,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(
              width: AppDimensions.contentPadding.w,
            ),
            SingleOTPBox(
              verified: controller.isValidate.value,
              wrongOTP: controller.wrongOTP.value,
              controller: controller.c4,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(
              width: AppDimensions.contentPadding.w,
            ),
            SingleOTPBox(
              verified: controller.isValidate.value,
              wrongOTP: controller.wrongOTP.value,
              controller: controller.c5,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(
              width: AppDimensions.contentPadding.w,
            ),
            SingleOTPBox(
              verified: controller.isValidate.value,
              wrongOTP: controller.wrongOTP.value,
              controller: controller.c6,
              onCompleted: (value) {
                if (value!.length == 1) {
                  controller.verifyOTP();
                }
                controller.checkOtpLength(value);
              },
              isLast: true,
            ),
            SizedBox(
              width: AppDimensions.contentPadding.w,
            ),
          ],
        ),
      ],
    );
  }

  resendOTPSection() {
    return controller.isValidate.value
        ? Center(
            child: Padding(
              padding: EdgeInsets.only(top: AppDimensions.sectionPadding.h),
              child: Icon(
                Icons.check_circle_rounded,
                color: AppColors.primaryColor,
                size: 46.sp,
              ),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Didn’t receive the code?", style: AppTextStyles.body(),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Expanded(
                      child: Text(
                         "You can request a new code after the time", style: AppTextStyles.body(),)),

                  if (controller.resendOtpTime.value > 0)
                   Text(

                          "${controller.resendOtpTime.value ~/ 60} min: ${controller.resendOtpTime.value % 60} Sec",
                     style: AppTextStyles.body( color: AppColors.primaryColor,),
                    ),
                  if (controller.resendOtpTime.value <= 0)
                    InkWell(
                      splashColor: Colors.white54,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, // AppDimensions.horizontalPadding,
                            vertical: 3.h),
                        child: Text(
                           "Resend Code",
                          style: AppTextStyles.header(color: AppColors.primaryColor),
                        ),
                      ),
                      onTap: () {
                        controller.resendOTP();
                      },
                    ),

                  //    BodyText(text: "00:30 Sec",fontWeight: FontWeight.w500,color: AppColors.primaryColor,),
                ],
              )
            ],
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
