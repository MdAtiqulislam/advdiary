import 'dart:async';

import 'package:advdiary/app/modules/resetPassword/controllers/reset_password_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../constraints/api_endpoints.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../models/login_model.dart';
import '../../../../services/remote_services.dart';
import '../../../../utils/utils.dart';
import '../../../routes/app_pages.dart';

class OtpController extends GetxController {
  var isLoading = false.obs;
  var isValidate = false.obs;
  var wrongOTP = false.obs;
  var resendOtpTime = 60.obs;
  var otp = "";
  var loginModel = LoginModel();

  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final c4 = TextEditingController();
  final c5 = TextEditingController();
  final c6 = TextEditingController();

  Timer? timer;

  var isRegistration = false;
  var isLogin = false;
  var isResetPassword = false;

  var provider = "".obs;

  @override
  Future<void> onInit() async {
    updateStatusBar();
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {}

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendOtpTime.value > 0) {
        resendOtpTime.value--;
      }
      if (resendOtpTime.value <= 0) {
        resendOtpTime.value = 0;
        timer.cancel();
      }
      if (isValidate.value) {
        timer.cancel();
      }
    });
  }

  Future<void> resendOTP() async {
    isLoading.value = true;
    const endPoint = APIEndPoints.reSendOTP;
    final body = {
      "email":provider.value
    };

    try {
      final response =
          await RemoteServices.postRequest(endPoint: endPoint, body: body);
      if (response != null) {
        isLoading.value = false;
        resendOtpTime.value = 180;
        startTimer();
        CustomSnackBar(
          isSuccess: true,
          msg: response["msg"],
        ).showSnackBar();
      } else {
        isLoading.value = false;
        CustomSnackBar(
          isSuccess: false,
          msg: AppStrings.httpErrorMSG.value,
        ).showSnackBar();
      }
    } catch (e) {
      isLoading.value = false;
      CustomSnackBar(
        isSuccess: false,
        msg: '$e',
      ).showSnackBar();
    }
  }

  void checkOtpLength(String? value) {
    if ((value ?? "").length >= 6) {
      for (int i = 0; i < 6; i++) {
        [c1, c2, c3, c4, c5, c6][i].text = value![i];
      }
      verifyOTP();
    }
  }

  Future<void> verifyOTP() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.verifyOTP;
    String otp = "${c1.text}${c2.text}${c3.text}${c4.text}${c5.text}${c6.text}";

    var body = {"otp": otp, "email": provider.value};

    try {
      var response =
          await RemoteServices.postRequest(endPoint: endPoint, body: body);
      if (response != null) {
        isValidate.value = true;
      } else {
        CustomSnackBar(isSuccess: false, msg: AppStrings.httpErrorMSG.value)
            .showSnackBar();
      }
    } catch (e) {
      CustomSnackBar(
              isSuccess: false,
              msg: "OTP verification failed. Please try again.")
          .showSnackBar();
    } finally {
      isLoading.value = false;
    }
  }

  void handelNext() {
    Get.put(ResetPasswordController()).isResetPassword.value=true;
    Get.find<ResetPasswordController>().email.value=provider.value;
    Get.toNamed(Routes.RESET_PASSWORD);
  }
}
