import 'package:advdiary/app/modules/privacyPolicy/models/privacy_policy_data_model.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {

  var isLoading=false.obs;
  var privacyPolicyData=PrivacyPolicyDataModel().obs;
  
  @override
  void onInit() {
    super.onInit();
    getPrivacyPolicy();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();

  }

  Future<void>getPrivacyPolicy()async{
    isLoading.value=true;
    var endPoint=APIEndPoints.getPrivacyPolicy;
    try {
      var res=await RemoteServices.getRequest(endPoint: endPoint);
      if(res!=null){
        privacyPolicyData.value=PrivacyPolicyDataModel.fromJson(res);
      }
    } finally {
      isLoading.value=false;
    }
  }

}
