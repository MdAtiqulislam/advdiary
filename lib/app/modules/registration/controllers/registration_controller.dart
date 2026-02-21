import 'package:advdiary/app/modules/registration/models/district_model.dart';
import 'package:advdiary/app/modules/registration/models/sign_up_model.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/common_widgets/custom_snackbar.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/constraints/app_strings.dart';
import 'package:advdiary/models/single_district.dart';
import 'package:advdiary/models/user_data_model.dart';
import 'package:advdiary/services/local_services.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';

class RegistrationController extends GetxController {

  final _captchaKey = "6LfjKwQqAAAAAJpeQv-eo1r7Kelh04r3NB2gE3K8";
  var isLoading=false.obs;
 
  var signUpModel=SignUpModel();

  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final phoneController=TextEditingController();
  final passwordController=TextEditingController();
  final confirmPasswordController=TextEditingController();
  final addressController=TextEditingController();

  var showPassword=false.obs;

  var isChecked=true.obs;
  var termsAndConditions="".obs;
  var districts=<SingleDistrict>[].obs;

  var licenceController=TextEditingController();

  var selectedDistrict=SingleDistrict().obs;



  @override
  void onInit() async{
    updateStatusBar();
    super.onInit();
    await getDistricts();
    await getTermsAndCondition();
  }

  @override
  void onClose() {}

  Future<void> verifyCaptcha() async {

  }

  void register() async{
    if(isChecked.value){
      isLoading.value=true;
      var endPoint= APIEndPoints.register;
      var body={
        "name":nameController.text,
        "title":"Adv.",
        "district_id":(selectedDistrict.value.id??"").toString(),
        "licence_no":licenceController.text,
        "email":emailController.text,
        "phone":phoneController.text,
        "address":addressController.text,
        "password":passwordController.text,
        "password_confirmation":confirmPasswordController.text,
        "user_type":"1",
        "status":"0",
      };

      try {
        var response=await RemoteServices.postRequest(endPoint: endPoint,body: body);
        if(response!=null){
          signUpModel=SignUpModel.fromJson(response);
         // await LocalServices.storeToken(signUpModel.apiToken??"");
          //await LocalServices().storeUser(signUpModel.data??UserDataModel());
          Get.toNamed(Routes.LOGIN);
        }else{
          CustomSnackBar(
              msg: AppStrings.httpErrorMSG.value,
              isSuccess: false
          ).showSnackBar();
        }
      } finally {
        isLoading.value=false;
      }
    }else{
      CustomSnackBar(
        msg: "You must agree with with terms and conditions to continue.",
        isSuccess: false,
      ).showSnackBar();
    }
  }

  Future<void> getTermsAndCondition()async{

    isLoading.value=true;
    var endPoint=APIEndPoints.getTermsAndCondition;
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint);
      if(response!=null){
        termsAndConditions.value=response["data"];
      }
    } finally {
      isLoading.value=false;
    }

  }

 Future<void> getDistricts() async{
    isLoading.value=true;
    var endPoint=APIEndPoints.getDistrict;
    try {
      var rs =await RemoteServices.getRequest(endPoint: endPoint);
      if(rs!=null){
        DistrictModel districtModel=DistrictModel.fromJson(rs);
        districts.value=districtModel.data??[];
      }
    } finally {
      isLoading.value=false;
    }

 }
}
