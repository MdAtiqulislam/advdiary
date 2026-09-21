import 'dart:async';
import 'dart:io';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../theme/app_colors.dart';


void showHtmlDialog({
  required String title,
  required String htmlContent,
}) {
  Get.dialog(
    Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: AppDimensions.horizontalPadding.w,
        vertical: AppDimensions.verticalPadding.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.8,
          minWidth: Get.width * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPadding.w,
                vertical: AppDimensions.verticalPadding.h / 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppDimensions.borderRadius.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,style: AppTextStyles.header(color: Colors.white),),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.cancel_outlined, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppDimensions.horizontalPadding.w),
                child: Html(data: htmlContent),
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}




Future<XFile?> picImage(ImageSource imageSource) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: imageSource);
  if (file != null) {
    return file;
  } else {
    return null;
  }
}

/*  ******Function to crop image***** */

/*Future<CroppedFile?> cropImage({required String filePath,  CropStyle? cropStyle}) async {
  return await ImageCropper().cropImage(
    cropStyle: cropStyle??CropStyle.circle,
    sourcePath: filePath,
    aspectRatioPresets: [
      // CropAspectRatioPreset.square,
      //CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      // CropAspectRatioPreset.ratio4x3,
      //CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Edit',
          toolbarColor: Colors.white,
          toolbarWidgetColor: AppColors.primaryColor,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Edit',
      ),
    ],
  );
}*/

String formatDate(
    String? date, {
      String format = "MMM -yy",
    }) {
  if (date != null && date.isNotEmpty) {
    DateTime dDate = DateFormat('y-M-d').parse(date);

    return DateFormat(format).format(dDate);
  } else {
    return "";
  }
}

/*  ******Function to get http success status***** */
bool isHttpStatusSuccess(int statusCode) {
  if (kDebugMode) {
    print(statusCode);
  }

  return statusCode >= 200 && statusCode < 300;
}

/*  ******Function to generate http error message***** */
String generateHttpErrorMessage(int errorCode) {
  switch (errorCode) {
    case 400:
      return "400 Bad Request: The server cannot process the request due to a client error.";
    case 401:
      return "401 Unauthorized: The request has not been applied because it lacks valid authentication credentials for the target resource.";
    case 403:
      return "403 Forbidden: The server understood the request but refuses to authorize it.";
    case 404:
      return "404 Not Found: The server cannot find the requested resource.";
    case 405:
      return "405 Method Not Allowed: The method specified in the request is not allowed for the resource identified by the request.";
    case 406:
      return "406 Not Acceptable: The server cannot produce a response matching the list of acceptable values.";
    case 408:
      return "408 Request Timeout: The server did not receive a complete request message within the time that it was prepared to wait.";
    case 409:
      return "409 Conflict: The request could not be completed due to a conflict with the current state of the target resource.";
    case 410:
      return "410 Gone: The requested resource is no longer available and will not be available again.";
    case 500:
      return "500 Internal Server Error: The server encountered an unexpected condition that prevented it from fulfilling the request.";
    case 501:
      return "501 Not Implemented: The server does not support the functionality required to fulfill the request.";
    case 502:
      return "502 Bad Gateway: The server, while acting as a gateway or proxy, received an invalid response from an inbound server it accessed while attempting to fulfill the request.";
    case 503:
      return "503 Service Unavailable: The server is currently unable to handle the request due to temporary overloading or maintenance of the server.";
    case 504:
      return "504 Gateway Timeout: The server, while acting as a gateway or proxy, did not receive a timely response from an upstream server it needed to access in order to complete the request.";
    case 505:
      return "505 HTTP Version Not Supported: The server does not support, or refuses to support, the HTTP protocol version that was used in the request message.";
    default:
      return "$errorCode: Unknown Error";
  }
}

Future<String?> selectDate() async {
  final DateTime? picked = await showDatePicker(
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2101),
    context: Get.context!,
  );
  if (picked != null) {
    return  DateFormat("dd-MM-yyyy").format(picked);
  }
  return null;
}


Future<File?> pickFile() async {
  try {
    // Open the file picker and let the user select a file
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      // If the user selected a file, return the File object
      return File(result.files.single.path!);
    } else {
      // If the user canceled the selection, return null
      return null;
    }
  } catch (e) {
    // Handle any errors that occur during file selection
    if (kDebugMode) {
      print('Error picking file: $e');
    }
    return null;
  }
}


Future<CroppedFile?> cropImage({
  required String filePath,
  CropStyle? cropStyle,
}) async {
  return await ImageCropper().cropImage(
    sourcePath: filePath,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Edit',
        toolbarColor: Colors.white,
        toolbarWidgetColor: AppColors.primaryColor,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
        cropStyle: cropStyle ?? CropStyle.circle,
        hideBottomControls: false,
        showCropGrid: true,
        // 👇 এইটা UI টাকে fullscreen না করে safe area এর respect করবে
        cropFrameStrokeWidth: 2,
      ),
      IOSUiSettings(
        title: 'Edit',
        cropStyle: cropStyle ?? CropStyle.circle,
        aspectRatioLockEnabled: false,
        // 👇 iOS এ fullscreen crop UI off রাখে
        resetAspectRatioEnabled: true,
      ),
    ],
  );
}


void updateStatusBar(){
  WidgetsBinding.instance.addPostFrameCallback((_) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        //systemNavigationBarColor: AppColors.mainColorRed, // navigation bar color
        statusBarColor: Colors.white, // status bar color
        statusBarIconBrightness: Brightness.dark,   // Only honored in Android M and above
        statusBarBrightness: Brightness.dark,
      ),
    );
  });
}





String formatFullDate(String dateTimeStr) {
  try {
    // Parse the input string as UTC time
    DateTime dateTimeUtc = DateTime.parse(dateTimeStr).toUtc();

    // Convert UTC time to Dhaka timezone (UTC+6)
    DateTime dateTimeDhaka = dateTimeUtc.add(const Duration(hours: 6));

    // Format the datetime to desired format
    return DateFormat('dd-MM-yyyy hh:mm a').format(dateTimeDhaka);
  } catch (e) {
    return dateTimeStr; // যদি format fail করে, তাহলে আগের string-টাই ফেরত দেবে
  }
}
Future<void> requestInitialPermissions() async {
  if (await Permission.storage.isDenied) {
    await Permission.storage.request();
  }

  // Android 11+ (Optional)
  if (await Permission.manageExternalStorage.isDenied &&
      await Permission.manageExternalStorage.isPermanentlyDenied) {
    await openAppSettings(); // User কে settings এ পাঠাবে
  }
}
