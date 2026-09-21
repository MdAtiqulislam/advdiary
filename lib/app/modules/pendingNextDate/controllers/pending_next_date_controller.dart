
import 'dart:async';
import 'dart:io';
import 'package:advdiary/app/modules/app_bar/app_bar_controller.dart';
import 'package:advdiary/app/modules/pendingNextDate/models/pending_case_list_model.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../models/status_model.dart';
import '../../fixedForSetting/models/fixed_for_list_model.dart';

class PendingNextDateController extends GetxController {
  var isLoading = false.obs;
  var pendingList = PendingCaseListModel().obs;

  final dateController = TextEditingController();
  final remarksController = TextEditingController();
  final fileNameController = TextEditingController();
  final paymentController = TextEditingController();

  var statusListModel = StatusListModel().obs;
  var selectedStatus = SingleStatusModel().obs;

  var fixedForList = <SingleFixedForModel>[].obs;
  var selectedFixedFor = SingleFixedForModel().obs;

  var openPaginationSlider = false.obs;

  File? file;

  // 🔍 SEARCH
  var searchText = "".obs;
  Timer? _debounce;

  @override
  Future<void> onInit() async {
    super.onInit();
    getPendingList();

    await getStatus();
    await getFixForData();

    debounce(searchText, (_) => _searchHandler(), time: 1.seconds);
  }

  // 🔍 LOCAL SEARCH HANDLER
  void _searchHandler() {
    if (searchText.value.length >= 3) {
      getPendingList(search: searchText.value);
    } else if (searchText.value.isEmpty) {
      getPendingList(search: "");
    }
  }

  // 🔍 TextField Listener
  void onSearchChanged(String value) {
    searchText.value = value;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      _searchHandler();
    });
  }

  // 📌 FETCH PENDING LIST
  Future<void> getPendingList({String search = ""}) async {
    isLoading.value = true;

    final endPoint = "${APIEndPoints.getPendingNextDate}?search_text=$search";

    try {
      var res = await RemoteServices.getRequest(endPoint: endPoint);
      if (res != null) {
        pendingList.value = PendingCaseListModel.fromJson(res);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getStatus() async {
    var res = await RemoteServices.getRequest(endPoint: APIEndPoints.getStatusEndPoint);
    if (res != null) statusListModel.value = StatusListModel.fromJson(res);
  }

  Future<void> getFixForData() async {
    var res = await RemoteServices.getRequest(endPoint: APIEndPoints.getFixedForAllData);
    if (res != null) {
      fixedForList.value = FixedForListModel.fromJson(res).data ?? [];
    }
  }

  // 📌 SAVE NEXT DATE
  Future<void> saveNextDate({required String caseId}) async {
    isLoading.value = true;
    Get.back();

    var body = {
      "next_date": dateController.text,
      "payment": paymentController.text,
      "status": selectedStatus.value.id.toString(),
      "fixed_for_id": selectedFixedFor.value.id.toString(),
      "remark": remarksController.text,
    };

    var res = await RemoteServices.multipartRequest(
      filePath: file?.path ?? "",
      fieldName: "case_document",
      endPoint: APIEndPoints.saveNextDateEndPoint,
      body: body,
      parameters: {"case_id": caseId},
      requestType: "POST",
    );

    isLoading.value = false;

    if (res != null) {
      resetForm();
      getPendingList();
      Get.put(AppBarController()).getAppBarData();
      CustomSnackBar(isSuccess: true, msg: res["msg"]).showSnackBar();
    } else {
      CustomSnackBar(isSuccess: false, msg: AppStrings.httpErrorMSG.value).showSnackBar();
    }
  }

  void resetForm() {
    dateController.clear();
    paymentController.clear();
    remarksController.clear();
    fileNameController.clear();
    file = null;
    selectedFixedFor.value = SingleFixedForModel();
    selectedStatus.value = SingleStatusModel();
  }

  // BUTTON RULE
  bool getButtonEnableStatue() {
    var d = pendingList.value;

    if (d.yearlyPaymentStatus == 1 && (d.nowDayCount ?? 0) >= 5) return false;
    if (d.monthlyPaymentStatus == 0) return false;
    if ((d.caseCount ?? 0) >= 3 && (d.newSubscriberStatus ?? 0) == 0) return false;
    if ((d.caseCount ?? 0) > d.packageLimit && d.currentUserPkgId != 1) return false;

    return true;
  }
}

