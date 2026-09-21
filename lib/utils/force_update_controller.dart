import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common_widgets/custom_dialog.dart';
import '../constraints/api_endpoints.dart';
import '../services/remote_services.dart';

class ForceUpdateController extends GetxController {
  var isLoading = false.obs;
  var forceUpdateModel = ForceUpdateModel().obs;

  final RxBool isForceUpdateDialogOpen = false.obs;

  @override
  void onInit() {
    super.onInit();
    getForceUpdateInfo();
  }

  Future<void> getForceUpdateInfo() async {
    isLoading.value = true;

    try {
      var response = await RemoteServices.getRequest(
        endPoint: APIEndPoints.forceUpdate,
      );

      if (response != null) {
        forceUpdateModel.value = ForceUpdateModel.fromJson(response);
        await checkForceUpdate();
      }
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> checkForceUpdate() async {
    final data = forceUpdateModel.value.data;

    if (data == null) return;

    /// Enable false hole return
    if (data.enable != true) return;

    /// Current app version
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    print("Current Version: $currentVersion");

    final liveVersion = data.androidVersion;
    final testVersion = data.androidTestVersion;

    /// Version match hole return
    final isMatched =
        currentVersion == liveVersion ||
            currentVersion == testVersion;

    if (isMatched) return;

    /// Sob existing dialog close
    if (Get.isDialogOpen == true) {
      Get.back(closeOverlays: true);
    }

    /// Already open thakle abar open korbe na
    if (isForceUpdateDialogOpen.value) return;

    isForceUpdateDialogOpen.value = true;

    final updateMessage = data.message;

    final isForce =
        updateMessage?.buttonAction?.toLowerCase() == 'force';

    Get.dialog(
      PopScope(
        canPop: !isForce,

        /// ===== CUSTOM DIALOG =====
        child: CustomDialog(
          title: updateMessage?.title ?? "Update Required",

          description:
          updateMessage?.msg ??
              "A new version of the app is available.",

          /// Update Button
          confirmButtonText: "Update Now",

          onConfirmButtonPressed: () async {
            final url = updateMessage?.url?.apk;

            if (url != null && url.isNotEmpty) {
              await launchUrl(
                Uri.parse(url),
                mode: LaunchMode.externalApplication,
              );
            }

            /// Optional hole close hobe
            if (!isForce) {
              Get.back();
            }
          },

          /// Force hole cancel -> app close
          cancelButtonText:
          isForce ? "Cancel" : "Remind Me Later",

          onCancelButtonPressed: () {
            if (isForce) {
              exit(0);
            } else {
              Get.back();
            }
          },
        ),
      ),

      barrierDismissible: !isForce,
    ).then((_) {
      isForceUpdateDialogOpen.value = false;
    });
  }
}

class ForceUpdateModel {
  final bool? status;
  final String? msg;
  final AppData? data;

  ForceUpdateModel({
    this.status,
    this.msg,
    this.data,
  });

  factory ForceUpdateModel.fromJson(Map<String, dynamic> json) {
    return ForceUpdateModel(
      status: json['status'],
      msg: json['msg'],
      data: json['data'] != null
          ? AppData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
      'data': data?.toJson(),
    };
  }
}

class AppData {
  final String? appName;
  final String? androidVersion;
  final String? androidTestVersion;
  final bool? enable;
  final UpdateMessage? message;

  AppData({
    this.appName,
    this.androidVersion,
    this.androidTestVersion,
    this.enable,
    this.message,
  });

  factory AppData.fromJson(Map<String, dynamic> json) {
    return AppData(
      appName: json['app_name'],
      androidVersion: json['android_version'],
      androidTestVersion: json['android_test_version'],
      enable: json['enable'],
      message: json['message'] != null
          ? UpdateMessage.fromJson(json['message'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'app_name': appName,
      'android_version': androidVersion,
      'android_test_version': androidTestVersion,
      'enable': enable,
      'message': message?.toJson(),
    };
  }
}

class UpdateMessage {
  final String? title;
  final String? msg;
  final String? buttonAction;
  final UpdateUrl? url;

  UpdateMessage({
    this.title,
    this.msg,
    this.buttonAction,
    this.url,
  });

  factory UpdateMessage.fromJson(Map<String, dynamic> json) {
    return UpdateMessage(
      title: json['title'],
      msg: json['msg'],
      buttonAction: json['button_action'],
      url: json['url'] != null
          ? UpdateUrl.fromJson(json['url'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'msg': msg,
      'button_action': buttonAction,
      'url': url?.toJson(),
    };
  }
}

class UpdateUrl {
  final String? apk;

  UpdateUrl({
    this.apk,
  });

  factory UpdateUrl.fromJson(Map<String, dynamic> json) {
    return UpdateUrl(
      apk: json['apk'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apk': apk,
    };
  }
}