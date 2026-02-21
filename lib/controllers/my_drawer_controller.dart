import 'package:advdiary/app/modules/login/controllers/login_controller.dart';
import 'package:advdiary/app/modules/registration/models/district_model.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/models/single_district.dart';
import 'package:advdiary/models/user_data_model.dart';
import 'package:advdiary/services/local_services.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/utils.dart';

class MyDrawerController extends GetxController {
  var isLoading = false.obs;
  var userData=UserDataModel().obs;
  var districtList=<SingleDistrict>[].obs;

  @override
  void onInit()async {
    super.onInit();
    await getUserData();
    await getDistricts();
  }

  Future<void> selectImage({required ImageSource source}) async {
    picImage(source).then((value) async {
      if (value != null) {
        Get.back();
      }
    });
  }

  void logOut() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.logOut;
    var token=await LocalServices.getToken();
    var body={
      "token":token
    };
    try {
      var response = await RemoteServices.postRequest(endPoint: endPoint,body: body);
      if (response != null) {
        print(response);
      }
    } finally {
     // await LocalServices.deleteData();
      await LocalServices.deleteDataBasedOnRememberMe();

      Get.offAllNamed(Routes.LOGIN);
      Get.put(LoginController()).loadEmailAndPassword();
      isLoading.value = false;
    }
  }

 Future<void> getUserData() async{
    userData.value=await LocalServices.getUser()??UserDataModel();
    print(userData.value.name);
 }




  Future<void> openWebLink() async {
    final Uri url = Uri.parse('https://advdiary.lawsuitbd.com');
    try {
      final canLaunchValue = await canLaunchUrl(url);
      print("Can launch: $canLaunchValue");

      if (!canLaunchValue) {
        throw 'Could not launch $url';
      }

      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      print("Error launching url: $e");
    }
  }

Future<void>  getDistricts()async {
    isLoading.value=true;
    var endPoint=APIEndPoints.getDistrict;
    try {
      var res=await RemoteServices.getRequest(endPoint: endPoint);
      if(res!=null){
        var districtModel=DistrictModel.fromJson(res);
        districtList.value=districtModel.data??[];
      }
    } finally {
      isLoading.value=false;
    }
}

}
