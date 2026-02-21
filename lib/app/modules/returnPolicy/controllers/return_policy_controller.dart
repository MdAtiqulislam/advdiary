import 'package:get/get.dart';

import '../../../../constraints/api_endpoints.dart';
import '../../../../services/remote_services.dart';
import '../../../../utils/utils.dart';

class ReturnPolicyController extends GetxController {
 var isLoading=false.obs;
 var returnPolicyData="".obs;
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
   var endPoint=APIEndPoints.getReturnPolicy;
   try {
     var response=await RemoteServices.getRequest(endPoint: endPoint);

     if(response!=null){
       returnPolicyData.value=response["data"]["uploaded_file"];
       print(returnPolicyData);
     }
   } finally {
     isLoading.value=false;
   }
 }
}
