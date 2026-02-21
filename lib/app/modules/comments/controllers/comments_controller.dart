import 'dart:io';

import 'package:advdiary/app/modules/app_bar/app_bar_controller.dart';
import 'package:advdiary/app/modules/comments/models/token_details_model.dart';
import 'package:advdiary/app/modules/supportToken/controllers/support_token_controller.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_snackbar.dart';

class CommentsController extends GetxController {
  var isLoading=false.obs;
  var isUpdating=false.obs;
  var tokenDetails=TokenDetailsModel().obs;

  var selectedFile = Rx<File?>(null);


  var postText = "".obs;

  var comments = <TokenComment>[].obs;

  final TextEditingController commentController = TextEditingController();

  Future<void> addComment() async {
    final text = commentController.text.trim();

    if (text.isEmpty && selectedFile.value == null) {
      CustomSnackBar(
        isSuccess: false,
        msg: "Please enter a token or attach a file before submitting.",
      ).showSnackBar();
      return;
    }
    isUpdating.value=true;
    var endPoint=APIEndPoints.addComment;
    var body={
      "token_id":(tokenDetails.value.data?.tokenData?.id).toString(),
      "token_comment":text.toString(),
      "type":"client"
    };

    try {
      var response = await RemoteServices.multipartRequest(
          endPoint: endPoint,
          body: body,
          filePath: selectedFile.value?.path??"",
          fieldName: 'attatchment_file',
          requestType: 'POST');
      
      if(response!=null){
        commentController.text="";
        selectedFile.value=null;
        getSupportTokenDetails(id:response["data"]["token_id"],showLoading: false );

      }
    } finally {
      isUpdating.value=false;
    }

  }

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

  Future<void> getSupportTokenDetails({String? id,bool showLoading=true}) async{
    showLoading?isLoading.value=true:isLoading.value=false;
    var endPoint=APIEndPoints.getSupportTokenDetails;
    var parameters={"token_id":id.toString()};
    try {
      var res=await RemoteServices.getRequest(endPoint: endPoint,parameters: parameters);
      if(res!=null){
        tokenDetails.value=TokenDetailsModel.fromJson(res);
        postText.value=tokenDetails.value.data?.tokenData?.token??"";
        comments.value=tokenDetails.value.data?.tokenComment??[];
        Get.put(SupportTokenController()).getTokenList();
        Get.put(AppBarController()).getAppBarData();
      }
    } finally {
      isLoading.value=false;
    }

  }
}
