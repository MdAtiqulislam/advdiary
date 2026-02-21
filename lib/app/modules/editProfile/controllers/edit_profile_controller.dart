import 'dart:convert';

import 'package:advdiary/app/modules/app_bar/app_bar_controller.dart';
import 'package:advdiary/app/modules/editProfile/models/edit_profile_response_model.dart';
import 'package:advdiary/common_widgets/custom_snackbar.dart';
import 'package:advdiary/constraints/app_strings.dart';
import 'package:advdiary/controllers/my_drawer_controller.dart';
import 'package:advdiary/models/single_district.dart';
import 'package:advdiary/models/user_data_model.dart';
import 'package:advdiary/services/local_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constraints/api_endpoints.dart';
import '../../../../services/remote_services.dart';
import '../../../../utils/utils.dart';
import '../../registration/models/district_model.dart';

class EditProfileController extends GetxController {


  var isLoading=false.obs;

  var userData=UserDataModel().obs;
  var editProfileResponseModel=EditProfileResponseModel();

  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var addressController=TextEditingController();

  var base64ImageProfile = "".obs;
  String profileImage = "";

  var licenceController=TextEditingController();

  var districts=<SingleDistrict>[].obs;

  var selectedDistrict=SingleDistrict().obs;
  @override
  void onInit()async {
    updateStatusBar();
    super.onInit();
   await getDistricts();
   await getUserData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void>getUserData()async{
    userData.value=await LocalServices.getUser()??UserDataModel();

    preLoadData();
  }

  void preLoadData() {
    nameController.text    = userData.value.name ?? "";
    emailController.text   = userData.value.email ?? "";
    phoneController.text   = userData.value.phone ?? "";
    addressController.text = userData.value.address ?? "";
    licenceController.text = userData.value.licenceNo ?? "";

    // Find the district that matches the stored districtId
    final matchedDistrict = districts.firstWhereOrNull(
          (d) {
            return (d.id.toString()) == userData.value.districtId.toString();
          },
    );

    // Update the observable (use your own null‑handling or default value as needed)
    if (matchedDistrict != null) {
      selectedDistrict.value = matchedDistrict;
    }
  }



  Future<void> selectImage(
      {required ImageSource source, CropStyle? cropStyle})
  async {
    picImage(source).then((value) async {
      if (value != null) {
        Get.back();
        await cropImage(filePath: value.path, cropStyle: cropStyle)
            .then((value) async {
          if (value != null) {

              profileImage = value.path;
              {
                base64ImageProfile.value = await getImageAsBase64(value);
              }

          }
        });
      }
    });
  }

  Future<String> getImageAsBase64(CroppedFile imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  Future<void> updateUserProfile() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.updateUserProfile;
    var body = {
      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "address": addressController.text,
      "title":"Adv.",
      "district_id":selectedDistrict.value.id.toString(),
      "licence_no":licenceController.text
    };

    try {
      var response = await RemoteServices.multipartRequest(
          endPoint: endPoint,
          body: body,
          filePath: profileImage,
          fieldName: 'user_image',
          requestType: "POST");
      if (response != null) {
        editProfileResponseModel=EditProfileResponseModel.fromJson(response);
        await LocalServices().storeUser(editProfileResponseModel.data??UserDataModel());
       await Get.put(MyDrawerController()).getUserData();
       await Get.put(AppBarController()).getUserData();

       CustomSnackBar(
         msg: response["msg"],
         isSuccess: true
       ).showSnackBar();
      }else{
        CustomSnackBar(
          msg: AppStrings.httpErrorMSG.value,
          isSuccess: false
        ).showSnackBar();
      }
    } finally {
      isLoading.value = false;
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
