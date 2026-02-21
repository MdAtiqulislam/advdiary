import 'package:get/get.dart';

import '../controllers/payment_report_controller.dart';

class PaymentReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentReportController>(
      () => PaymentReportController(),
    );
  }
}
