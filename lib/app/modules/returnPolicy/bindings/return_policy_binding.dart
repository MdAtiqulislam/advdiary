import 'package:get/get.dart';

import '../controllers/return_policy_controller.dart';

class ReturnPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReturnPolicyController>(
      () => ReturnPolicyController(),
    );
  }
}
