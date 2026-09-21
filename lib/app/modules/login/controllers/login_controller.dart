import 'package:advdiary/app/modules/app_bar/app_bar_controller.dart';
import 'package:advdiary/app/modules/home/controllers/home_controller.dart';
import 'package:advdiary/app/modules/otp/controllers/otp_controller.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/common_widgets/custom_snackbar.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/constraints/app_strings.dart';
import 'package:advdiary/models/login_model.dart';
import 'package:advdiary/models/user_data_model.dart';
import 'package:advdiary/services/local_services.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var showPassword = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var loginModel = LoginModel();
  var rememberUser=true.obs;

  @override
  void onClose() {}

  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    updateStatusBar();
    loadEmailAndPassword();
  }
  void login() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.login;
    var body = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    try {
      var response =
          await RemoteServices.postRequest(endPoint: endPoint, body: body);
      if (response != null) {
        loginModel = LoginModel.fromJson(response);
        await LocalServices.storeToken(loginModel.apiToken ?? "");
        await LocalServices.storeEmail(emailController.text);
        await LocalServices.storePassword(passwordController.text);
        await LocalServices.storeRememberMe(rememberUser.value);
        await LocalServices.storeToken(loginModel.apiToken ?? "");
        await LocalServices().storeUser(loginModel.data ?? UserDataModel());
        Get.put(AppBarController()).getAppBarData();
        Get.find<HomeController>().getPackageInfo();
        Get.find<HomeController>().cancelDialogue.value=false;
        Get.offAndToNamed(Routes.HOME);
      }else{
        CustomSnackBar(
            msg: AppStrings.httpErrorMSG.value,
            isSuccess: false
        ).showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void getOTPForResetPassword() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getOTP;
    var body = {"email": emailController.text};

    try {
      var response =
          await RemoteServices.postRequest(endPoint: endPoint, body: body);
      if (response != null) {
        Get.put(OtpController());
        Get.find<OtpController>().provider.value = emailController.text;
        Get.toNamed(Routes.OTP);
      }else{
        CustomSnackBar(
          msg: AppStrings.httpErrorMSG.value,
          isSuccess: false
        ).showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void loadEmailAndPassword()async{
    emailController.text=await LocalServices.getEmail()??"";
    passwordController.text=await LocalServices.getPassword()??"";
  }
}
