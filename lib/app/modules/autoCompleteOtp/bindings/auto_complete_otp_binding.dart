import 'package:get/get.dart';

import '../controllers/auto_complete_otp_controller.dart';

class AutoCompleteOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AutoCompleteOtpController>(
      () => AutoCompleteOtpController(),
    );
  }
}
