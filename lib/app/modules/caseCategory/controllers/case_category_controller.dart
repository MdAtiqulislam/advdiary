import 'package:advdiary/app/modules/caseCategory/models/case_category_list_model.dart';
import 'package:advdiary/common_widgets/custom_snackbar.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/constraints/app_strings.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:advdiary/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CaseCategoryController extends GetxController {

  var isLoading=false.obs;
  var caseCategoryList=CaseCategoryListModel().obs;

  var categoryNameController=TextEditingController();

  var selectedCaseCategory=SingleCaseCategoryModel().obs;

  var showDrawerButton=false.obs;


  @override
  void onInit() {
    updateStatusBar();
    getCaseCategory();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}


  Future<void> getCaseCategory()async {
    isLoading.value=true;
    var endPoint=APIEndPoints.getCaseCategoryList;
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint);
      if(response!=null){
        caseCategoryList.value=CaseCategoryListModel.fromJson(response);
      }
    } finally {
     isLoading.value=false;
    }
  }

  Future<void> addNewCaseCategory()async {
    Get.back();
    isLoading.value=true;
    var endPoint=APIEndPoints.addCaseCategoryEndpoint;
    var body={
      "case_category":categoryNameController.text,
     // "status":"1"
    };
    try {
      var response=await RemoteServices.postRequest(endPoint: endPoint,body: body);
      if(response!=null){
        CustomSnackBar(
          msg: response["msg"],
          isSuccess: true
        ).showSnackBar();
       await getCaseCategory();
      }else{
        CustomSnackBar(
            msg: AppStrings.httpErrorMSG.value,
            isSuccess: false
        ).showSnackBar();
      }
    } finally {
      isLoading.value=false;
    }
  }

  Future<void> updateCaseCategory()async {
    Get.back();
    isLoading.value=true;
    var endPoint=APIEndPoints.updateCaseCategoryEndpoint;
    var parameters={
      "edit_id":selectedCaseCategory.value.id.toString()
    };
    var body={
      "case_category":categoryNameController.text,
      "id":selectedCaseCategory.value.id.toString()
    };
    try {
      var response=await RemoteServices.postRequest(endPoint: endPoint,parameters: parameters,body: body);
      if(response!=null){

        CustomSnackBar(
            msg: response["msg"],
            isSuccess: true
        ).showSnackBar();
        selectedCaseCategory.value=SingleCaseCategoryModel();
        await getCaseCategory();
      }else{
        CustomSnackBar(
            msg: AppStrings.httpErrorMSG.value,
            isSuccess: false
        ).showSnackBar();
      }
    } finally {
      isLoading.value=false;
    }
  }

  Future<void> deleteCaseCategory({required String deleteId}) async{
    isLoading.value=true;
    var endPoint=APIEndPoints.deleteCaseCategoryEndPoint;
    var parameters={
      "delete_id":deleteId
    };
    try {
      var response=await RemoteServices.postRequest(endPoint: endPoint,parameters: parameters);
      if(response!=null){
       CustomSnackBar(
         msg: response["msg"],
         isSuccess: true
       ).showSnackBar();
      await getCaseCategory();
      }else{
        CustomSnackBar(
            msg: AppStrings.httpErrorMSG.value,
            isSuccess: false
        ).showSnackBar();
      }
    } finally {
      isLoading.value=false;
    }
  }
}
