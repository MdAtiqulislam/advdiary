import 'package:get/get.dart';

import '../controllers/pending_next_date_controller.dart';

class PendingNextDateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendingNextDateController>(
      () => PendingNextDateController(),
    );
  }
}
