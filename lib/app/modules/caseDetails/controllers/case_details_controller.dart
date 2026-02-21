import 'dart:io';

import 'package:advdiary/app/modules/caseDetails/models/case_details_model.dart';
import 'package:advdiary/app/modules/fixedForSetting/models/fixed_for_list_model.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_snackbar.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../models/single_next_date_model.dart';
import '../../../../models/status_model.dart';
import '../../../../utils/utils.dart';

class CaseDetailsController extends GetxController {
var isLoading=true.obs;
var loadingMore=false.obs;
var caseDetailsModel=CaseDetailsModel().obs;
var nextDateList=<SingleNextDateModel>[].obs;

var dateController =TextEditingController();
var paymentController =TextEditingController();
var fixedForController =TextEditingController();
var remarksController =TextEditingController();
var fileNameController=TextEditingController();

var statusListModel=StatusListModel().obs;
var selectedStatus=SingleStatusModel().obs;
var fixedForList=<SingleFixedForModel>[].obs;
var selectedFixedFor=SingleFixedForModel().obs;

File? file;





  @override
  Future<void> onInit() async {
    updateStatusBar();
    super.onInit();
   await getStatus();
   await getFixForData();
  }


  @override
  void onClose() {}

  Future<void>getCaseDetails({required String caseId})async{
   isLoading.value=true;
    var endPoint=APIEndPoints.getCaseDetailsEndPoint;
    var parameters={
      "case_id":caseId
    };
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint,parameters: parameters);
      if(response!=null){
        caseDetailsModel.value=CaseDetailsModel.fromJson(response);
        nextDateList.value=caseDetailsModel.value.data?.nextDates??[];
      }
    } finally {
      isLoading.value=false;
    }
  }

Future<void> updateNextDate({required String nextId,required String caseId}) async{
  isLoading.value=true;
  Get.back();
  var endPoint=APIEndPoints.updateNextDateEndPoint;
  var parameter={
  "next_id":nextId};
  var body={
    "next_date":dateController.text,
    "payment":paymentController.text,
    "status":selectedStatus.value.id.toString(),
    "fixed_for_id":selectedFixedFor.value.id.toString(),
    "remark":remarksController.text,
  };

  try {
    var response=await RemoteServices.multipartRequest(
        filePath: file?.path??"",
        fieldName: "case_document",
        endPoint: endPoint,
        body: body,
        parameters:parameter,
        requestType: "POST"
    );

    if(response!=null){
      //  Get.back();
   //   resetValue();
    await  getCaseDetails(caseId: caseId);
      CustomSnackBar(
          isSuccess: true,
          msg: response["msg"]
      ).showSnackBar();
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

Future<void> getStatus()async {
  isLoading.value=true;
  var endPoint=APIEndPoints.getStatusEndPoint;
  try {
    var response=await RemoteServices.getRequest(endPoint: endPoint);
    if(response!=null){
      statusListModel.value=StatusListModel.fromJson(response);
    }
  } finally {
    isLoading.value=false;
  }
}

void loadData({SingleNextDateModel? data}) {
  dateController.text = data?.nextDate ?? "";
  paymentController.text = (data?.payment ?? "").toString();
  fixedForController.text = data?.fixedFor ?? "";
  remarksController.text = data?.remarks ?? "";
  fileNameController.text = data?.downloadURL ?? "";

  if (statusListModel.value.data != null && statusListModel.value.data!.isNotEmpty) {
    int index = statusListModel.value.data!.indexWhere((value) => value.name == (data?.statusName ?? ""));
    if (index != -1) {
      selectedStatus.value = statusListModel.value.data![index];
    } else {
      // Handle case where statusName doesn't match any in the list (e.g., select a default status)
    }
  } else {
    // Handle the case where the statusListModel is null or empty
  }

  if (fixedForList.isNotEmpty) {
    int index = fixedForList.indexWhere((value) => value.fixedFor == (data?.fixedFor ?? ""));
    if (index != -1) {
      selectedFixedFor.value = fixedForList[index];
    } else {
      // Handle case where statusName doesn't match any in the list (e.g., select a default status)
    }
  } else {
    // Handle the case where the statusListModel is null or empty
  }
}

void loadMore({required String url})async{
  loadingMore.value=true;
  try {
    await RemoteServices.getRequestLoadMore(url: url).then((value){
      if(value!=null){
        caseDetailsModel.value=CaseDetailsModel.fromJson(value);
        nextDateList.value+=caseDetailsModel.value.data?.nextDates??[];
      }
    });
  } finally {
    loadingMore.value=false;
  }
}

Future<void>  getFixForData() async{
    isLoading.value=true;
    var endPoint=APIEndPoints.getFixedForAllData;
    try {
      var res=await RemoteServices.getRequest(endPoint: endPoint);
      if(res!=null){
        var fixForListModel=FixedForListModel.fromJson(res);
        fixedForList.value=fixForListModel.data??[];
      }
    } finally {
      isLoading.value=false;
    }
}

}
