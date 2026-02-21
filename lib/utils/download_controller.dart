import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../common_widgets/custom_snackbar.dart';
import 'package:flutter/services.dart';

import '../services/local_services.dart';

class DownloadsController extends GetxController {
  var isDownloading = false.obs;
  var downloadProgress = 0.0.obs;

  static const MethodChannel _channel = MethodChannel('com.advocatesdiary/files');

  Future<void> downloadFile({
    required String fileUrl,
    String? fileExtension,
  }) async {
    if (fileUrl.isEmpty) {
      Get.snackbar("Error", "File URL is empty");
      return;
    }

    try {
      isDownloading.value = true;
      downloadProgress.value = 0.0;
      EasyLoading.show(status: 'Downloading...');

      final token = await LocalServices.getToken();
      final uri = Uri.parse(fileUrl);
      final request = http.Request('GET', uri)
        ..headers.addAll({
          "Authorization": "Bearer $token",
          "User-Agent": "Mozilla/5.0",
        });

      final streamedResponse = await request.send();
      if (streamedResponse.statusCode != 200) {
        throw Exception("Download failed: ${streamedResponse.statusCode}");
      }

      final contentLength = streamedResponse.contentLength ?? 0;
      List<int> bytes = [];
      int received = 0;

      streamedResponse.stream.listen(
            (chunk) {
          bytes.addAll(chunk);
          received += chunk.length;
          downloadProgress.value = contentLength != 0 ? received / contentLength : 0;
        },
        onDone: () async {
          String fileName = fileUrl.split('/').last;
          if (fileExtension != null && fileExtension.isNotEmpty) {
            if (!fileName.toLowerCase().endsWith(fileExtension.toLowerCase())) {
              fileName += ".$fileExtension";
            }
          } else if (!fileName.contains('.')) {
            fileName += ".pdf";
          }

          final fileUri = await _channel.invokeMethod<String>(
            'saveFile',
            {
              'fileName': fileName,
              'bytes': Uint8List.fromList(bytes),
            },
          );

          isDownloading.value = false;
          EasyLoading.dismiss();

          if (fileUri != null) {
            final openFile = await Get.dialog<bool>(
              AlertDialog(
                title: const Text("Download Complete"),
                content: const Text("Do you want to open the file?"),
                actions: [
                  TextButton(
                      onPressed: () => Get.back(result: false),
                      child: const Text("No")),
                  TextButton(
                      onPressed: () => Get.back(result: true),
                      child: const Text("Yes")),
                ],
              ),
            );

            if (openFile == true) {
              await _channel.invokeMethod('openFile', {'fileUri': fileUri});
            }

            CustomSnackBar(
              title: "Success",
              msg: "File saved to Downloads",
              isSuccess: true,
            ).showSnackBar();
          } else {
            throw Exception("Failed to save file");
          }
        },
        onError: (e) {
          isDownloading.value = false;
          EasyLoading.dismiss();
          CustomSnackBar(title: "Download Failed", msg: "$e", isSuccess: false).showSnackBar();
        },
        cancelOnError: true,
      );
    } catch (e) {
      isDownloading.value = false;
      EasyLoading.dismiss();
      CustomSnackBar(
        title: "Download Failed",
        msg: "Error: $e",
        isSuccess: false,
      ).showSnackBar();
    }
  }
}
