import 'package:get/get.dart';

import '../controllers/case_report_controller.dart';

class CaseReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CaseReportController>(
      () => CaseReportController(),
    );
  }
}
