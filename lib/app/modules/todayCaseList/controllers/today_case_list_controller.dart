/*
import 'package:advdiary/app/modules/todayCaseList/models/today_case_lost_model.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:get/get.dart';

class TodayCaseListController extends GetxController {

  var isLoading=false.obs;

 var todayCaseList=TodayCaseListModel().obs;

  var openPaginationSlider=false.obs;

  @override
  void onInit() {
    super.onInit();
   // getTodayCaseList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void>getTodayCaseList()async{
    isLoading.value=true;
    var endPoint=APIEndPoints.getTodayCaseList;
    try {
      var res=await RemoteServices.getRequest(endPoint: endPoint);
      if(res!=null){
        todayCaseList.value=TodayCaseListModel.fromJson(res);
      }
    } finally {
      isLoading.value=false;
    }
  }

}
*/


import 'dart:async';
import 'package:advdiary/app/modules/todayCaseList/models/today_case_lost_model.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:get/get.dart';

class TodayCaseListController extends GetxController {

  var isLoading = false.obs;
  var todayCaseList = TodayCaseListModel().obs;
  var openPaginationSlider = false.obs;

  // SEARCH
  var searchText = "".obs;
  //Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    debounce(searchText, (_) => callSearchAPI(), time: const Duration(seconds: 1));
    getTodayCaseList(); // initial load
  }

  /// Triggered automatically 2 seconds after typing stops
  void callSearchAPI() {
    getTodayCaseList(search: searchText.value);
  }

  /// Fetch API
  Future<void> getTodayCaseList({String search = ""}) async {
    isLoading.value = true;

    String endPoint = "${APIEndPoints.getTodayCaseList}?search_text=$search";

    try {
      var res = await RemoteServices.getRequest(endPoint: endPoint);
      if (res != null) {
        todayCaseList.value = TodayCaseListModel.fromJson(res);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
