import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../controllers/book_details_controller.dart';

class BookDetailsView extends GetView<BookDetailsController> {
  BookDetailsView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final url = controller.initialUrl;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: controller.title.value,
          scaffoldKey: _scaffoldKey,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: url.toLowerCase().endsWith(".pdf")
              ? const PDF().fromUrl(
            url,
            placeholder: (progress) =>
                Center(child: Text('$progress %')),
            errorWidget: (error) =>
            const Center(child: Text('Failed to load PDF')),
          )
              : InAppWebView(
            key: controller.webViewKey,
            initialUrlRequest: URLRequest(url: WebUri(url)),
            onWebViewCreated: (c) {
              controller.webViewController = c;
            },
            onLoadStart: (c, url) {
              controller.isLoading.value = true;
            },
            onLoadStop: (c, url) {
              controller.isLoading.value = false;
            },
          ),
        ),
      ),
    );
  }
}
