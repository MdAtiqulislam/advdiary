import 'package:get/get.dart';

import '../controllers/add_or_update_case_controller.dart';

class AddOrUpdateCaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddOrUpdateCaseController>(
      () => AddOrUpdateCaseController(),
    );
  }
}
