import 'package:advdiary/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/common_widgets/custom_snackbar.dart';
import 'package:advdiary/services/remote_services.dart';

import '../models/fixed_for_list_model.dart';

class FixedForSettingController extends GetxController {
  var isLoading = false.obs;
  var isUpdating = false.obs;

  var fixedForList = <SingleFixedForModel>[].obs;
  var selectedFixedFor = SingleFixedForModel().obs;
  var nameController = TextEditingController();
  var pagination=Pagination().obs;

  var loadingMore=false.obs;

  @override
  void onInit() {
    updateStatusBar();
    super.onInit();
    getFixedForList();
  }

  Future<void> getFixedForList({bool isReload = false}) async {
    isReload ? isUpdating.value = true : isLoading.value = true;
    try {
      var res = await RemoteServices.getRequest(endPoint: APIEndPoints.getFixedForList);
      if (res != null) {

        var fixedForModel=FixedForListModel.fromJson(res);
        fixedForList.value = fixedForModel.data??[];
        pagination.value=fixedForModel.pagination??Pagination();
      }
    } finally {
      isReload ? isUpdating.value = false : isLoading.value = false;
    }
  }



  Future<void> addFixedFor() async {
    isUpdating.value = true;
    var body = {"fixed_for": nameController.text};
    try {
      var res = await RemoteServices.postRequest(endPoint: APIEndPoints.addFixedFor, body: body);
      if (res != null) {
        Get.back();
        getFixedForList(isReload: true);
        CustomSnackBar(msg: res["msg"], isSuccess: true).showSnackBar();
      }
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> editFixedFor(SingleFixedForModel fixedFor) async {
    isUpdating.value = true;
    var body = {"fixed_for": nameController.text};
    var params = {"id": fixedFor.id.toString()};
    try {
      var res = await RemoteServices.postRequest(
        endPoint: APIEndPoints.editFixedFor,
        body: body,
        parameters: params,
      );
      if (res != null) {
        Get.back();
        getFixedForList(isReload: true);
        CustomSnackBar(msg: res["msg"], isSuccess: true).showSnackBar();
      }
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> deleteFixedFor(SingleFixedForModel fixedFor) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Delete"),
        content: Text("Are you sure you want to delete ${fixedFor.fixedFor}?"),
        actions: [
          TextButton(onPressed: () => Get.back(result: false), child: const Text("Cancel")),
          TextButton(onPressed: () => Get.back(result: true), child: const Text("Delete")),
        ],
      ),
    ) ??
        false;

    if (!confirmed) return;

    isUpdating.value = true;
    var params = {"delete_id": fixedFor.id.toString()};
    try {
      var res = await RemoteServices.postRequest(endPoint: APIEndPoints.deleteFixedFor, parameters: params);
      if (res != null) {
        fixedForList.removeWhere((element) => element.id == fixedFor.id);
        CustomSnackBar(msg: res["msg"], isSuccess: true).showSnackBar();
      }
    } finally {
      isUpdating.value = false;
    }
  }

  void loadMore({required String url}) async {
    loadingMore.value = true;
    try {
      await RemoteServices.getRequestLoadMore(url: url).then((value) {
        if (value != null) {
          var fixedForModel=FixedForListModel.fromJson(value);
          fixedForList.value += fixedForModel.data ?? [];
          pagination.value=fixedForModel.pagination??Pagination();
        }
      });
    } finally {
      loadingMore.value = false;
    }
  }

}
