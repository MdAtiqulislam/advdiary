import 'package:advdiary/app/modules/faqAndSupport/models/faq_and_support_model.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';

class FaqAndSupportController extends GetxController {

  var isLoading=false.obs;
  var faqData=FaqAndSupportModel().obs;
  @override
  void onInit() async{
    updateStatusBar();
    super.onInit();
    await getFaqData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> getFaqData()async{
    isLoading.value=true;
    var endPoint=APIEndPoints.getFAQEndPoint;
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint);
      print(response);
      if(response!=null){
        faqData.value=FaqAndSupportModel.fromJson(response);
      }
    } finally {
      isLoading.value=false;
    }
  }

}
