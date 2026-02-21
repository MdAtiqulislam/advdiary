import 'package:advdiary/app/modules/home/models/home_data_model.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../caseList/controllers/case_list_controller.dart';

class CasesController extends GetxController {


  var notice="".obs;
  var homeDataModel=HomeDataModel().obs;

  var page="";

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void openCaseList() {
    Get.put(CaseListController());
    Get.find<CaseListController>().page=page;
    Get.find<CaseListController>().showDrawerButton.value=false;
    Get.find<CaseListController>().getCaseList();
    Get.toNamed(Routes.CASE_LIST);
  }

}
