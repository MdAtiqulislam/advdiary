import 'package:advdiary/app/modules/bkashPayment/controllers/bkash_payment_controller.dart';
import 'package:advdiary/app/modules/home/controllers/home_controller.dart';
import 'package:advdiary/app/modules/home/models/package_info_model.dart';
import 'package:advdiary/app/modules/packages/models/packages_model.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/app_strings.dart';

class PackagesController extends GetxController {
  var isLoading = false.obs;
  var packages = PackagesModel().obs;

  var packageInfo = PackageInfoModel().obs;
  var currentPackage = CurrentPackage().obs;

  @override
  void onInit() {
    super.onInit();
    getPackages();
    getPackageInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getPackages() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getPackages;
    try {
      var responses = await RemoteServices.getRequest(endPoint: endPoint);
      if (responses != null) {
        packages.value = PackagesModel.fromJson(responses);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPackageInfo() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getPackageInfo;
    try {
      var responses = await RemoteServices.getRequest(endPoint: endPoint);
      if (responses != null) {
        packageInfo.value = PackageInfoModel.fromJson(responses);
        currentPackage.value =
            packageInfo.value.data?.currentPackage ?? CurrentPackage();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void upgradePackage({required int id, required String amount}) async {
    isLoading.value = true;
    var endPoint = APIEndPoints.upgradePackage;
    var parameters = {
      "package_id": id.toString(),
      "package_amount": amount,
    };
    try {
      var response = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);
      if (response != null) {
        Get.put(BkashPaymentController()).url.value = response["bkash_url"];
        await Get.toNamed(Routes.BKASH_PAYMENT)?.then((value) async {
          await getPackages();
          await getPackageInfo();
          await Get.put(HomeController()).getPackageInfo();
        });
      }
    } finally {
      isLoading.value = false;
    }
  }

  void newSubscribe({required String amount}) async {
    isLoading.value = true;
    var endPoint = APIEndPoints.newSubscriber;
    var parameters = {"subscriber_fees": amount};
    try {
      var responses = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);
      if (responses != null) {
        Get.put(BkashPaymentController()).url.value = responses["bkash_url"];
        await Get.toNamed(Routes.BKASH_PAYMENT)?.then((value) async {

          await getPackages();
          await getPackageInfo();
          Get.put(HomeController());
          await Get.find<HomeController>().getUserData();
          await Get.find<HomeController>().getPackageInfo().then((value) async {
            await Get.find<HomeController>().getHomeData();
          });
        });
      } else {
        CustomSnackBar(isSuccess: false, msg: AppStrings.httpErrorMSG.value)
            .showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }
}
