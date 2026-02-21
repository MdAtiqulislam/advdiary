
import 'dart:io';

import 'package:advdiary/app/modules/addOrUpdateCase/controllers/add_or_update_case_controller.dart';
import 'package:advdiary/app/modules/app_bar/app_bar_controller.dart';
import 'package:advdiary/app/modules/caseList/models/case_list_model.dart';
import 'package:advdiary/app/modules/home/controllers/home_controller.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/common_widgets/custom_snackbar.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/constraints/app_strings.dart';
import 'package:advdiary/models/single_case_model.dart';
import 'package:advdiary/models/status_model.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';
import '../../addOrUpdateCase/models/category_list_model.dart';
import '../../bottom_navigation_bar/custom_bottom_nav_bar_controller.dart';
import '../../fixedForSetting/models/fixed_for_list_model.dart';

class CaseListController extends GetxController {
  var isLoading = false.obs;
  var loadingMore = false.obs;
  var caseListModel = CaseListModel().obs;
  var caseList = <SingleCaseModel>[].obs;

  var dateController = TextEditingController();
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();

  var paymentController = TextEditingController();
  var fixedForController = TextEditingController();
  var remarksController = TextEditingController();
  var fileNameController = TextEditingController();

  var statusListModel = StatusListModel().obs;
  var selectedStatus = SingleStatusModel().obs;

  File? file;

  var isFilterExpanded = false.obs;

  var categoryListModel = CategoryListModel().obs;
  var selectedCategory = SingleCategoryModel().obs;
  var categoryNames = <String>[].obs;

  var filterTextController = TextEditingController();

  bool isFiltered = false;

  String page = "";

  var openPaginationSlider = false.obs;
  var showDrawerButton = false.obs;

  var fixedForList = <SingleFixedForModel>[].obs;
  var selectedFixedFor = SingleFixedForModel().obs;
  var categoryController = TextEditingController();

  @override
  Future<void> onInit() async {
    updateStatusBar();
    super.onInit();
    await getCategoryList();
    await getStatus();
    await getFixForData();
    Get.find<CustomBottomNavigationController>();
    Get.find<CustomBottomNavigationController>().selectedIndex.value = 1;
  }

  @override
  void onClose() {}

  Future<void> getCaseList() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getCaseList;
    caseList.value = [];
    var parameters = {"page": page};
    try {
      var response = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);
      if (response != null) {
        caseListModel.value = CaseListModel.fromJson(response);
        caseList.value = caseListModel.value.data ?? [];
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCategoryList() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getCategoryList;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        categoryListModel.value = CategoryListModel.fromJson(response);
        categoryListModel.value.data?.forEach((value) {
          categoryNames.add(value.caseCategory ?? "");
        });
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> filterCaseList() async {
    isLoading.value = true;
    isFiltered = true;
    caseList.value = [];
    var endPoint = APIEndPoints.getCaseList;
    var parameters = getParameters();
    try {
      var response = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);
      if (response != null) {
        caseListModel.value = CaseListModel.fromJson(response);
        caseList.value = caseListModel.value.data ?? [];
      }
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, dynamic> getParameters() {
    return {
      "search_text": filterTextController.text,
      "category_id": (selectedCategory.value.id ?? "").toString(),
      "status_id": "",
      "from": startDateController.text,
      "to": endDateController.text,
    };
  }

  void editCase({required String caseId}) {
    Get.put(AddOrUpdateCaseController());
    Get.find<AddOrUpdateCaseController>().caseId = caseId;
    Get.find<AddOrUpdateCaseController>().getEditCaseData();
    Get.find<AddOrUpdateCaseController>().type.value = "Update";
    Get.toNamed(Routes.ADD_OR_UPDATE_CASE);
  }

  Future<void> deleteCase({required String caseId}) async {
    isLoading.value = true;
    var endPoint = APIEndPoints.deleteCaseEndPoint;
    var parameter = {"delete_id": caseId};
    var response = await RemoteServices.postRequest(
        endPoint: endPoint, parameters: parameter);
    try {
      if (response != null ) {
        // শুধু ওই item remove হবে
        caseList.removeWhere((c) => c.id.toString() == caseId);
        caseList.refresh();
        CustomSnackBar(isSuccess: true, msg: response["msg"]).showSnackBar();
        Get.put(HomeController()).getHomeData();
        Get.put(AppBarController()).getAppBarData();
      } else {
        CustomSnackBar(isSuccess: false, msg: AppStrings.httpErrorMSG.value)
            .showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getStatus() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getStatusEndPoint;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        statusListModel.value = StatusListModel.fromJson(response);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveNextDate({required String caseId}) async {
    isLoading.value = true;
    Get.back();
    var endPoint = APIEndPoints.saveNextDateEndPoint;
    var parameter = {"case_id": caseId};
    var body = {
      "next_date": dateController.text,
      "payment": paymentController.text,
      "status": selectedStatus.value.id.toString(),
      "fixed_for_id": selectedFixedFor.value.id.toString(),
      "remark": remarksController.text,
    };

    try {
      var response = await RemoteServices.multipartRequest(
        filePath: file?.path ?? "",
        fieldName: "case_document",
        endPoint: endPoint,
        body: body,
        parameters: parameter,
        requestType: "POST",
      );

      if (response != null) {
        resetValue();

        // ✅ শুধু ওই case update হবে
        int index = caseList.indexWhere((c) => c.id.toString() == caseId);
        if (index != -1 && response["data"] != null) {
          final updatedCase = SingleCaseModel.fromJson(response["data"]);
         // caseList[index] = updatedCase;
         // caseList.refresh();

          print(updatedCase.nextDate);
          updateCaseInList(updatedCase);
        }

        CustomSnackBar(isSuccess: true, msg: response["msg"]).showSnackBar();
      } else {
        CustomSnackBar(isSuccess: false, msg: AppStrings.httpErrorMSG.value)
            .showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void resetValue() {
    dateController.text = "";
    paymentController.text = "";
    fixedForController.text = "";
    remarksController.text = "";
    file = null;
    fileNameController.text = "";
  }

  Future<void> clearFilter() async {
    filterTextController.text = "";
    selectedCategory.value = SingleCategoryModel();
    categoryController.text = "";
    startDateController.text = "";
    endDateController.text = "";
    if (isFiltered) {
      await getCaseList();
      isFiltered = false;
    }
  }

  void loadMore({required String url}) async {
    loadingMore.value = true;
    try {
      await RemoteServices.getRequestLoadMore(url: url).then((value) {
        if (value != null) {
          caseListModel.value = CaseListModel.fromJson(value);
          caseList.value += caseListModel.value.data ?? [];
        }
      });
    } finally {
      loadingMore.value = false;
    }
  }

  bool getButtonEnableStatue() {
    var buttonEnabled = true;

    if (caseListModel.value.yearlyPaymentStatus == 1 &&
        (caseListModel.value.nowDayCount ?? 0) >= 5) {
      buttonEnabled = false;
    }
    if (caseListModel.value.monthlyPaymentStatus == 0) /*&&
        (caseListModel.value.nowDayCount ?? 0) >= 11)*/ {
      buttonEnabled = false;
    }
    if ((caseListModel.value.caseCount ?? 0) >= 3 &&
        (caseListModel.value.newSubscriberStatus ?? 0) == 0) {
      buttonEnabled = false;
    }
    if ((caseListModel.value.caseCount ?? 0) >
        caseListModel.value.packageLimit && (caseListModel.value.currentUserPackageId!=1) ){
      buttonEnabled = false;
    }

    return buttonEnabled;
  }

  Future<void> getFixForData() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getFixedForAllData;
    try {
      var res = await RemoteServices.getRequest(endPoint: endPoint);
      if (res != null) {
        var fixForListModel = FixedForListModel.fromJson(res);
        fixedForList.value = fixForListModel.data ?? [];
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changeSmsStatus({
    required String caseId,
    required int newStatus,
  }) async
  {
    try {
      EasyLoading.show(status: "Updating...");

      final endPoint = APIEndPoints.smsStatusChange;
      var parameters = {
        "id": caseId,
        "sms_status": newStatus.toString(),
      };

      final response =
      await RemoteServices.postRequest(endPoint: endPoint, parameters: parameters);

      if (response != null) {
        // শুধু ওই case update হবে
        int index = caseList.indexWhere((c) => c.id.toString() == caseId);
        if (index != -1) {
          caseList[index] = caseList[index].copyWith(smsStatus: newStatus);
          caseList.refresh();
        }

        EasyLoading.dismiss();
        CustomSnackBar(
          title: "Success",
          msg: response["msg"] ?? "SMS service status updated successfully.",
          isSuccess: true,
        ).showSnackBar();
      } else {
        throw Exception(response?["message"] ?? "Failed to update SMS status");
      }
    } catch (e) {
      EasyLoading.dismiss();
      CustomSnackBar(
        title: "Error",
        msg: "Error: $e",
        isSuccess: false,
      ).showSnackBar();
    }
  }

  /// Utility method for replacing a single case in the list
  void updateCaseInList(SingleCaseModel updatedCase) {
    int index = caseList.indexWhere((c) => c.id.toString() == updatedCase.id.toString());
    if (index != -1) {


      caseList[index] = updatedCase;
      caseList.refresh();
    }
  }
}
