import 'package:get/get.dart';

import '../controllers/next_case_time_line_controller.dart';

class NextCaseTimeLineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NextCaseTimeLineController>(
      () => NextCaseTimeLineController(),
    );
  }
}
