import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/models/app_bar_data_model.dart';
import 'package:advdiary/models/user_data_model.dart';
import 'package:advdiary/services/local_services.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:get/get.dart';

class AppBarController extends GetxController{
  var isLoading=false.obs;
  var userData=UserDataModel().obs;

  var caseCount = 0.obs;
  var packageName = "Basic".obs;
  var todayCase = 0.obs;

  var appBarData=AppBaraDataModel().obs;

  @override
  void onInit() {
    super.onInit();
  }


 Future<void> getUserData() async{
   userData.value=await LocalServices.getUser()??UserDataModel();
 }

 Future<void>getAppBarData()async{
   isLoading.value=true;
   var endPoint=APIEndPoints.getAppBarData;
   try {
     var res=await RemoteServices.getRequest(endPoint: endPoint);
     if(res!=null){
       appBarData.value=AppBaraDataModel.fromJson(res);
     }
   } finally {
     isLoading.value=false;
   }
 }
  
}
