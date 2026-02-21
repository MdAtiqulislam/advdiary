import 'package:get/get.dart';

import '../controllers/subscriprtion_controller.dart';

class SubscriprtionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriprtionController>(
      () => SubscriprtionController(),
    );
  }
}
