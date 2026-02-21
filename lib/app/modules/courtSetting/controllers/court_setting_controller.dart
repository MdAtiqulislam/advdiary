import 'package:advdiary/app/modules/courtSetting/models/court_list_model.dart';
import 'package:advdiary/common_widgets/custom_snackbar.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/constraints/app_strings.dart';
import 'package:advdiary/models/single_court_model.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';

class CourtSettingController extends GetxController {
  var isLoading=false.obs;
  var courtList=<SingleCourtModel>[].obs;

  var courtNameController=TextEditingController();

  var selectedCourt=SingleCourtModel().obs;

  var isUpdating=false.obs;
  @override
  void onInit() async{
    updateStatusBar();
    super.onInit();
    await getCourtList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

 Future<void> getCourtList({bool isReload=false}) async{
    isReload?isUpdating.value=true:isLoading.value=true;
    var endPoint=APIEndPoints.getCourtListEndpointNew;
    try {
      var rs=await RemoteServices.getRequest(endPoint: endPoint);
      if(rs!=null){
        var courtListModel=CourtListModel.fromJson(rs);
        courtList.value=courtListModel.data??[];
      }
    } finally {
      isReload?isUpdating.value=false:isLoading.value=false;
    }
 }

  Future<void> editCourt(SingleCourtModel court) async {

    isUpdating.value=true;
    var endPoint=APIEndPoints.editCourt;
    var parameters={"id":selectedCourt.value.id.toString()};
    var body={"court_name":courtNameController.text};
    try {
      var rs=await RemoteServices.postRequest(endPoint: endPoint,parameters: parameters,body: body);
      if(rs!=null){
        Get.back();
        getCourtList(isReload: true);
        CustomSnackBar(
            isSuccess: true,
            msg: rs['msg']
        ).showSnackBar();
      }else{
        CustomSnackBar(
            isSuccess: false,
            msg: AppStrings.httpErrorMSG.value
        ).showSnackBar();
      }
    } finally {
      isUpdating.value=false;
    }
  }

  Future<void> deleteCourt(SingleCourtModel court) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete Court'),
        content: Text('Are you sure you want to delete "${court.cortName}"?'),
        actions: [
          TextButton(onPressed: () => Get.back(result: false), child: const Text('Cancel')),
          TextButton(onPressed: () => Get.back(result: true), child: const Text('Delete')),
        ],
      ),
    ) ??
        false;

    if (!confirmed) return;

    try {
      isUpdating.value = true;
      final endpoint = APIEndPoints.deleteCourt;
      var parameters={"delete_id":court.id.toString()};
      final res = await RemoteServices.postRequest(endPoint: endpoint,parameters: parameters);
      if (res != null) {
        courtList.removeWhere((c) => c.id == court.id);
        CustomSnackBar(
          isSuccess: true,
          msg: res["msg"]
        ).showSnackBar();
      } else {
        CustomSnackBar(
            isSuccess: false,
            msg: AppStrings.httpErrorMSG.value
        ).showSnackBar();
      }
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> addCourt() async {

    isUpdating.value=true;
    var endPoint=APIEndPoints.addCourt;
    var body={"court_name":courtNameController.text};
    try {
      var rs=await RemoteServices.postRequest(endPoint: endPoint,body: body);
      if(rs!=null){
        Get.back();
        getCourtList(isReload: true);
        CustomSnackBar(
          isSuccess: true,
          msg: rs['msg']
        ).showSnackBar();
      }else{
        CustomSnackBar(
            isSuccess: false,
            msg: AppStrings.httpErrorMSG.value
        ).showSnackBar();
      }
    } finally {
      isUpdating.value=false;
    }
  }


}
