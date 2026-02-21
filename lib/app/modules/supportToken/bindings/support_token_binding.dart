import 'package:get/get.dart';

import '../controllers/support_token_controller.dart';

class SupportTokenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportTokenController>(
      () => SupportTokenController(),
    );
  }
}
