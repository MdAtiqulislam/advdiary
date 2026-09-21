import 'package:advdiary/app/modules/app_bar/app_bar_controller.dart';
import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../controllers/bkash_payment_controller.dart';

class BkashPaymentView extends GetView<BkashPaymentController> {
  const BkashPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "Make Payment",showBottomRow: false,),

        body: CustomBody(
          child: Obx(() {
            return InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(controller.url.value), // ✅ Corrected WebUri usage
              ),
              onWebViewCreated: (webViewController) {
                controller.webViewController = webViewController; // ✅ Store it in the controller
              },
              onLoadStop: (webViewController, url) {
                if (url.toString().contains("success")) { // ✅ Check for a success keyword in the URL
                  Get.back(); // ✅ Navigate back after success
                 CustomSnackBar(
                   isSuccess: true,
                   title: "Payment Success",
                   msg: "Your bKash payment was successful!"
                 ).showSnackBar();
                 Get.put(AppBarController()).getAppBarData();
                }
          
          
          
          
          
               else if (url.toString().contains("cancel")) { // ✅ Check for a success keyword in the URL
                  Get.back(); // ✅ Navigate back after success
                  CustomSnackBar(
                      isSuccess: false,
                      title: "Payment Cancel",
                      msg: "Your bKash payment was cancel!"
                  ).showSnackBar();
                }
          
               else if (url.toString().contains("failure")) { // ✅ Check for a success keyword in the URL
                  Get.back(); // ✅ Navigate back after success
          
                  CustomSnackBar(
                      isSuccess: false,
                      title: "Payment Failed",
                      msg: "Your bKash payment was failed!"
                  ).showSnackBar();
                }
              },
            );
          }),
        ),
      ),
    );
  }
}
