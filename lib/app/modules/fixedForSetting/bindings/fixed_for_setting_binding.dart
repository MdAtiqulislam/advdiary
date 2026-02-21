import 'package:get/get.dart';

import '../controllers/fixed_for_setting_controller.dart';

class FixedForSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FixedForSettingController>(
      () => FixedForSettingController(),
    );
  }
}
