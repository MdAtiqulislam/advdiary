import 'package:get/get.dart';

import '../controllers/comming_soon_controller.dart';

class CommingSoonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComingSoonController>(
      () => ComingSoonController(),
    );
  }
}
