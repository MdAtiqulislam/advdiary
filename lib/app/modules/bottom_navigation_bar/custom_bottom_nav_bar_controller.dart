import 'package:advdiary/app/modules/caseList/controllers/case_list_controller.dart';
import 'package:advdiary/app/modules/home/controllers/home_controller.dart';
import 'package:advdiary/app/modules/packages/controllers/packages_controller.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:get/get.dart';
import '../app_bar/app_bar_controller.dart';

class CustomBottomNavigationController extends GetxController {
  var selectedIndex = 0.obs;

  var notice = "".obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getNotice();
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
    actionPerform(index: index);
  }

  Future<void> actionPerform({required int index}) async {
    if (index == 0 && Get.currentRoute != Routes.HOME) {
      await Get.put(AppBarController()).getAppBarData();
      Get.find<HomeController>().getHomeData();
      Get.offAllNamed(Routes.HOME);
    } else if (index == 1 && Get.currentRoute != Routes.CASE_LIST) {
      Get.put(CaseListController());
      Get.find<CaseListController>().getCaseList();
      Get.toNamed(Routes.CASE_LIST);
    } else if (index == 2 && Get.currentRoute != Routes.COURT_SETTING) {
      Get.toNamed(Routes.COURT_SETTING);
    } else if (index == 3 && Get.currentRoute != Routes.PACKAGES) {
      Get.put(PackagesController()).getPackageInfo();
      Get.find<PackagesController>().currentPackage.value;
      Get.toNamed(Routes.PACKAGES);
    } else if (index == 4 && Get.currentRoute != Routes.SUPPORT_TOKEN) {
      Get.toNamed(Routes.SUPPORT_TOKEN);
    }
  }

  Future<void> getNotice() async {
    var endPoint = APIEndPoints.getNotice;
    var res = await RemoteServices.getRequest(endPoint: endPoint);
    if (res != null) {
      notice.value = res["data"];
    }
  }
}
