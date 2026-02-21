/*
import 'package:advdiary/app/modules/supportToken/models/support_token_model.dart';
import 'package:advdiary/common_widgets/custom_snackbar.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';

class SupportTokenController extends GetxController {

  var isLoading=false.obs;
  var tokensModel=SupportTokenModel().obs;
  var supportTokenList=<SupportToken>[].obs;

  var tokenController=TextEditingController();
  var loadingMore=false.obs;

  @override
  void onInit() {
    updateStatusBar();
    super.onInit();
    getTokenList();
  }





  Future<void>getTokenList()async{
    isLoading.value=true;
    var endPoint=APIEndPoints.getTokens;
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint);
      if(response!=null){
        tokensModel.value=SupportTokenModel.fromJson(response);
        supportTokenList.value=tokensModel.value.data??[];
      }
    } finally {
      isLoading.value=false;
    }
  }

  void createSupportToken() async {
    if (tokenController.text.isEmpty) {
      CustomSnackBar(
        isSuccess: false,
        msg: "Please enter your support token before submitting.",
      ).showSnackBar();
    } else {
      isLoading.value = true;
      var endPoint = APIEndPoints.createSupportToken;
      var body = {"token": tokenController.text};
      try {
        var response = await RemoteServices.postRequest(endPoint: endPoint, body: body);
        if (response != null && response["status"] == true) {
          CustomSnackBar(
            isSuccess: true,
            msg: response["msg"],
          ).showSnackBar();
          tokenController.text = "";

          var data = response["data"];
          supportTokenList.insert(
            0,
            SupportToken(
              id: data["id"],
              date: formatFullDate(data["created_at"]),
              tokenNo: data["token_no"],
              token: data["token"],
            ),
          );

        }
      } finally {
        isLoading.value = false;
      }
    }
  }

  void loadMore({required String url}) async {
    loadingMore.value = true;
    try {
      await RemoteServices.getRequestLoadMore(url: url).then((value) {
        if (value != null) {
          tokensModel.value = SupportTokenModel.fromJson(value);
          supportTokenList.value += tokensModel.value.data ?? [];
        }
      });
    } finally {
      loadingMore.value = false;
    }
  }


}
*/


import 'dart:io';
import 'package:advdiary/app/modules/supportToken/models/support_token_model.dart';
import 'package:advdiary/common_widgets/custom_snackbar.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';

class SupportTokenController extends GetxController {
  var isLoading = false.obs;
  var tokensModel = SupportTokenModel().obs;
  var supportTokenList = <SupportToken>[].obs;

  var tokenController = TextEditingController();
  var loadingMore = false.obs;

  /// Selected File for attachment
  var selectedFile = Rx<File?>(null);

  @override
  void onInit() {
    updateStatusBar();
    super.onInit();
    getTokenList();
  }

  Future<void> getTokenList() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getTokens;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        tokensModel.value = SupportTokenModel.fromJson(response);
        supportTokenList.value = tokensModel.value.data ?? [];
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Pick file (image/pdf/etc.)
  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        withData: false,
      );
      if (result != null && result.files.single.path != null) {
        selectedFile.value = File(result.files.single.path!);
      }
    } catch (e) {
      CustomSnackBar(isSuccess: false, msg: "File pick failed: $e").showSnackBar();
    }
  }

  void createSupportToken() async {
    if (tokenController.text.isEmpty && selectedFile.value == null) {
      CustomSnackBar(
        isSuccess: false,
        msg: "Please enter a token or attach a file before submitting.",
      ).showSnackBar();
      return;
    }

    isLoading.value = true;
    var endPoint = APIEndPoints.createSupportToken;

    // Normally, for file upload, use Multipart request
    var body = {
      "token": tokenController.text,
      // "file": selectedFile.value?.path // will be handled if needed
    };

    try {
      var response = await RemoteServices.multipartRequest(
          endPoint: endPoint,
          body: body,
          filePath: selectedFile.value?.path??"",
          fieldName: 'attatchment_file',
          requestType: 'POST');
      if (response != null && response["status"] == true) {
        CustomSnackBar(
          isSuccess: true,
          msg: response["msg"],
        ).showSnackBar();
        tokenController.text = "";
        selectedFile.value = null;

        var data = response["data"];
        supportTokenList.insert(
          0,
          SupportToken(
            id: data["id"],
            date: formatFullDate(data["created_at"]),
            tokenNo: data["token_no"],
            token: data["token"],
            downloadUrl: data["download_url"]
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void loadMore({required String url}) async {
    loadingMore.value = true;
    try {
      await RemoteServices.getRequestLoadMore(url: url).then((value) {
        if (value != null) {
          tokensModel.value = SupportTokenModel.fromJson(value);
          supportTokenList.value += tokensModel.value.data ?? [];
        }
      });
    } finally {
      loadingMore.value = false;
    }
  }
}
