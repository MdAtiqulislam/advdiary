import 'package:get/get.dart';
import '../../../../services/local_services.dart';
import '../../../routes/app_pages.dart';


class SplashScreenController extends GetxController {
  var isLoading=false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }


  @override
  void onClose() {}

  Future<void> fetchData() async {
    isLoading.value=false;

   var token= await LocalServices.getToken()??"";

      if (token.isNotEmpty) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
  }
}
