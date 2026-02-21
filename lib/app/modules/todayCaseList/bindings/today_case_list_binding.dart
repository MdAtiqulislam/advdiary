import 'package:get/get.dart';

import '../controllers/today_case_list_controller.dart';

class TodayCaseListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodayCaseListController>(
      () => TodayCaseListController(),
    );
  }
}
