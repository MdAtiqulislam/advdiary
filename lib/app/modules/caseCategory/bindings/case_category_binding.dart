import 'package:get/get.dart';

import '../controllers/case_category_controller.dart';

class CaseCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CaseCategoryController>(
      () => CaseCategoryController(),
    );
  }
}
