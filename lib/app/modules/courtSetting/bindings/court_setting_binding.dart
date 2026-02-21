import 'package:get/get.dart';

import '../controllers/court_setting_controller.dart';

class CourtSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourtSettingController>(
      () => CourtSettingController(),
    );
  }
}
