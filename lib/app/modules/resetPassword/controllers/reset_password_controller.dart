import 'package:advdiary/app/modules/autoCompleteOtp/controllers/auto_complete_otp_controller.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/common_widgets/custom_snackbar.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/constraints/app_strings.dart';
import 'package:advdiary/services/local_services.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';

class ResetPasswordController extends GetxController {
  var isLoading=false.obs;
  var showPassword=false.obs;
  var newPasswordController =TextEditingController();
  var confirmPasswordController=TextEditingController();
  var email="".obs;
  var isResetPassword=false.obs;


  @override
  void onInit() {
    updateStatusBar();
    super.onInit();
  }



  Future<void> changePassword() async {
    isLoading.value=true;
    var body={
      "password":newPasswordController.text,
      "password_confirmation":confirmPasswordController.text
    };
    var endPoint=APIEndPoints.changePassword;
    try {
      var response=await RemoteServices.postRequest(endPoint: endPoint,body: body);
      if(response!=null){
       // Get.back();
        Get.put(AutoCompleteOtpController()).password=newPasswordController.text;
        Get.toNamed(Routes.AUTO_COMPLETE_OTP);
        CustomSnackBar(
          isSuccess: true,
          msg: response["msg"]
        ).showSnackBar();
       // await LocalServices.storePassword(newPasswordController.text);
      }else{
        CustomSnackBar(
          isSuccess: false,
          msg: AppStrings.httpErrorMSG.value
        ).showSnackBar();
      }
    } finally {
      isLoading.value=false;
    }
  }

  Future<void> resetPassword() async {
    isLoading.value=true;
    var body={
      "email":email.value,
      "password":newPasswordController.text,
      "password_confirmation":confirmPasswordController.text
    };
    var endPoint=APIEndPoints.resetPassword;
    try {
      var response=await RemoteServices.postRequest(endPoint: endPoint,body: body);
      if(response!=null){
        CustomSnackBar(
          isSuccess: true,
          msg: response["msg"]
        ).showSnackBar();
        await LocalServices.storePassword(newPasswordController.text);
        Get.offAllNamed(Routes.LOGIN);


      }else{
        CustomSnackBar(
          isSuccess: false,
          msg: AppStrings.httpErrorMSG.value
        ).showSnackBar();
      }
    } finally {
      isLoading.value=false;
    }
  }

  void saveNewPassword() {
    if(isResetPassword.value){
      resetPassword();
    }else{
      changePassword();
    }

  }

}
