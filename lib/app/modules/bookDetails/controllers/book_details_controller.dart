import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class BookDetailsController extends GetxController {
  var title = "Web View".obs;
  var isLoading = false.obs;

  InAppWebViewController? webViewController;
  GlobalKey webViewKey = GlobalKey();

  String initialUrl = ""; // এখানে pdf url বা সাধারণ url সেট করবি
}
