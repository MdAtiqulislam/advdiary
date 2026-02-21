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
import '../controllers/auto_complete_otp_controller.dart';

class AutoCompleteOtpView extends GetView<AutoCompleteOtpController> {
  const AutoCompleteOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Verify OTP",
              style: AppTextStyles.title(color: Colors.white)),
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
                        SizedBox(height: AppDimensions.sectionPadding.h),
                        Image.asset(AppImagePath.appLogo,
                            height: 100, width: Get.width),
                        SizedBox(height: AppDimensions.sectionPadding.h),
                        otpSection(),
                        if (controller.wrongOTP.value)
                          Padding(
                            padding: EdgeInsets.only(
                                top: AppDimensions.widgetPadding.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("OTP doesn’t match.",
                                    style: AppTextStyles.body()),
                               /* InkWell(
                                  onTap: Get.back,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            AppDimensions.contentPadding.h),
                                    child: Text("Try with different account?",
                                        style: AppTextStyles.body()),
                                  ),
                                )*/
                              ],
                            ),
                          ),
                      /*  SizedBox(height: AppDimensions.sectionPadding.h),
                        resendOTPSection(),*/
                        SizedBox(height: AppDimensions.sectionPadding * 3.h),
                        IgnorePointer(
                          ignoring: !controller.isValidate.value,
                          child: AppButton(
                            text: "Next",
                            onTap: controller.handelNext,
                            bgColor: controller.isValidate.value
                                ? AppColors.primaryColor
                                : AppColors.mutedText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (controller.isLoading.value) const LoadingScreen(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPadding.w),
          child: Text(
            "Developed by Web Solution IT Ltd.",
            textAlign: TextAlign.end,
            style: AppTextStyles.body(),
          ),
        ),
      ),
    );
  }

  Widget otpSection() {
    String maskedPhone = controller.provider.value.length >= 2
        ? "******${controller.provider.value.substring(controller.provider.value.length - 2)}"
        : controller.provider.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter your 6 digit code we’ve sent to your registered phone number",
          style: AppTextStyles.header(),
        ),
        SizedBox(height: AppDimensions.contentPadding.h),
        Text(
          maskedPhone,
          style: AppTextStyles.body(color: AppColors.mutedText),
        ),
        SizedBox(height: AppDimensions.sectionPadding.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var ctrl in [
              controller.c1,
              controller.c2,
              controller.c3,
              controller.c4,
              controller.c5,
              controller.c6
            ])
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.contentPadding.w / 2),
                child: SingleOTPBox(
                  verified: controller.isValidate.value,
                  wrongOTP: controller.wrongOTP.value,
                  controller: ctrl,
                  onCompleted: (value) {
                    // প্রতিবার user কিছু লিখলে সব বক্সের value নিয়ে full otp তৈরি করা হবে
                    final otp = [
                      controller.c1.text,
                      controller.c2.text,
                      controller.c3.text,
                      controller.c4.text,
                      controller.c5.text,
                      controller.c6.text,
                    ].join();

                    if (otp.length == 6) {
                      controller.verifyOTP();
                    }
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget resendOTPSection() {
    return controller.isValidate.value
        ? Center(
            child: Icon(Icons.check_circle_rounded,
                color: AppColors.primaryColor, size: 46.sp),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Didn’t receive the code?", style: AppTextStyles.body()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text("You can request a new code after the time",
                        style: AppTextStyles.body()),
                  ),
                  if (controller.resendOtpTime.value > 0)
                    Text(
                      "${controller.resendOtpTime.value ~/ 60} min : ${controller.resendOtpTime.value % 60} sec",
                      style: AppTextStyles.body(color: AppColors.primaryColor),
                    )
                  else
                    InkWell(
                      onTap: controller.resendOTP,
                      child: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: Text("Resend Code",
                            style: AppTextStyles.header(
                                color: AppColors.primaryColor)),
                      ),
                    ),
                ],
              )
            ],
          );
  }

}
