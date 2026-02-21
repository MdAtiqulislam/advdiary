import 'package:advdiary/app/modules/userGuide/models/user_guide_data_model.dart';
import 'package:get/get.dart';

import '../../../../constraints/api_endpoints.dart';
import '../../../../services/remote_services.dart';
import '../../../../utils/utils.dart';
import '../../faqAndSupport/models/faq_and_support_model.dart';

class UserGuideController extends GetxController {

  var isLoading=false.obs;
  var userGuideData=UserGuideDataModel().obs;
  @override
  void onInit()async {
    super.onInit();
    updateStatusBar();
   await getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getData()async{
    isLoading.value=true;
    var endPoint=APIEndPoints.getUserGuide;
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint);
      if(response!=null){
        userGuideData.value=UserGuideDataModel.fromJson(response);
        print(userGuideData.value.data?.uploadedFile);
      }
    } finally {
      isLoading.value=false;
    }
  }

}
