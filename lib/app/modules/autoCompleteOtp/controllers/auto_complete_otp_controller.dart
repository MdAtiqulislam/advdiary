import 'dart:async';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/services/local_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../constraints/api_endpoints.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../services/remote_services.dart';
import '../../../../utils/utils.dart';

class AutoCompleteOtpController extends GetxController with CodeAutoFill {
  var isLoading = false.obs;
  var isValidate = false.obs;
  var wrongOTP = false.obs;
  var resendOtpTime = 60.obs;
  var otp = "".obs;

  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final c4 = TextEditingController();
  final c5 = TextEditingController();
  final c6 = TextEditingController();

  Timer? timer;
  var provider = "".obs;

  String password="";

  @override
  Future<void> onInit() async {
    super.onInit();
    updateStatusBar();
    startTimer();
    await SmsAutoFill().listenForCode;
    listenForCode();
    final hash = await SmsAutoFill().getAppSignature;
    print("App hash: $hash");
    await getUser();

  }

  @override
  void codeUpdated() {
    otp.value = code ?? "";
    if (otp.value.length == 6) {
      for (int i = 0; i < 6; i++) {
        [c1, c2, c3, c4, c5, c6][i].text = otp.value[i];
      }
      verifyOTP();
    }
  }

  @override
  void onClose() {
    cancel(); // stop listening for SMS autofill
    super.onClose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendOtpTime.value > 0) {
        resendOtpTime.value--;
      } else {
        resendOtpTime.value = 0;
        timer.cancel();
      }
    });
  }

  Future<void> resendOTP() async {
    isLoading.value = true;
    const endPoint = APIEndPoints.reSendOTP;
    final body = {"email": provider.value};

    try {
      final response =
      await RemoteServices.postRequest(endPoint: endPoint, body: body);
      isLoading.value = false;
      if (response != null) {
        resendOtpTime.value = 180;
        startTimer();
        CustomSnackBar(isSuccess: true, msg: response["msg"] ?? response["message"])
            .showSnackBar();
      } else {
        CustomSnackBar(isSuccess: false, msg: AppStrings.httpErrorMSG.value)
            .showSnackBar();
      }
    } catch (e) {
      isLoading.value = false;
      CustomSnackBar(isSuccess: false, msg: "$e").showSnackBar();
    }
  }

  Future<void> verifyOTP() async {

    isLoading.value = true;
    final otpCode =
        "${c1.text}${c2.text}${c3.text}${c4.text}${c5.text}${c6.text}";
    final body = {"otp": otpCode, "password": password};
    final endPoint=APIEndPoints.changePasswordOtpVerification;

    try {
      var response =
      await RemoteServices.postRequest(endPoint: endPoint, body: body);
      if (response != null) {
        isValidate.value = true;
        await LocalServices.storePassword(password);
        Get.offAndToNamed(Routes.HOME);
        CustomSnackBar(
          isSuccess: true,
          msg: response["msg"]
        ).showSnackBar();
      } else {
        CustomSnackBar(isSuccess: false, msg: AppStrings.httpErrorMSG.value)
            .showSnackBar();
      }
    } catch (e) {
      CustomSnackBar(isSuccess: false, msg: "OTP verification failed").showSnackBar();
    } finally {
      isLoading.value = false;
    }
  }

  void handelNext() {

    Get.offAndToNamed(Routes.HOME);
    /*Get.put(ResetPasswordController()).isResetPassword.value = true;
    Get.find<ResetPasswordController>().email.value = provider.value;
    Get.toNamed(Routes.RESET_PASSWORD);*/
  }

  Future<void> getUser() async {
    await LocalServices.getUser().then((value){
      provider.value=value?.phone??"";
    });
  }

}


