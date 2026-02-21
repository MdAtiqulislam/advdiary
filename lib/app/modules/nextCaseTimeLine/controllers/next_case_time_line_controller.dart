import 'package:advdiary/app/modules/nextCaseTimeLine/models/next_case_timeline_model.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';

class NextCaseTimeLineController extends GetxController {


  var isLoading=false.obs;
  var nextCaseTimeline=NextCaseTimeLineModel().obs;

  var openPaginationSlider=false.obs;

  @override
  void onInit() {
    super.onInit();
    updateStatusBar();
    getNextCases();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getNextCases()async {
    isLoading.value=true;
    var endPoint=APIEndPoints.getNextCasesTimeLine;
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint);
      if(response!=null){
        nextCaseTimeline.value=NextCaseTimeLineModel.fromJson(response);
      }
    } finally {
      isLoading.value=false;
    }
  }

}
