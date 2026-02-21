import 'package:get/get.dart';

import '../../../../constraints/api_endpoints.dart';
import '../../../../services/remote_services.dart';
import '../../../../utils/utils.dart';

class TermsAndConditionsController extends GetxController {

  var isLoading=false.obs;
  var termsAndConditionData="".obs;

  @override
  Future<void> onInit() async {
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
    var endPoint=APIEndPoints.getTermsAndConditionsFile;
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint);

      if(response!=null){
        termsAndConditionData.value=response["data"]["uploaded_file"];
        print(termsAndConditionData);
      }
    } finally {
      isLoading.value=false;
    }
  }

}
