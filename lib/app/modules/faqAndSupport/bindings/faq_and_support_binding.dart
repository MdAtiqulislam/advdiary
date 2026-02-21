import 'package:get/get.dart';

import '../controllers/faq_and_support_controller.dart';

class FaqAndSupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaqAndSupportController>(
      () => FaqAndSupportController(),
    );
  }
}
