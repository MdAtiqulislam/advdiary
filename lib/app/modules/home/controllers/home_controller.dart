import 'package:advdiary/app/modules/app_bar/app_bar_controller.dart';
import 'package:advdiary/app/modules/bkashPayment/controllers/bkash_payment_controller.dart';
import 'package:advdiary/app/modules/books/controllers/books_controller.dart';
import 'package:advdiary/app/modules/cases/controllers/cases_controller.dart';
import 'package:advdiary/app/modules/commingSoon/controllers/comming_soon_controller.dart';
import 'package:advdiary/app/modules/home/models/home_data_model.dart';
import 'package:advdiary/app/modules/home/models/package_info_model.dart';
import 'package:advdiary/app/modules/home/models/upcoming_case_date_model.dart';
import 'package:advdiary/app/modules/notes/controllers/notes_controller.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/common_widgets/custom_snackbar.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/constraints/app_strings.dart';
import 'package:advdiary/controllers/my_drawer_controller.dart';
import 'package:advdiary/models/user_data_model.dart';
import 'package:advdiary/services/local_services.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:get/get.dart';

import '../../../../constraints/app_colors.dart';
import '../../../../models/single_next_case_data_model.dart';
import '../../calendar/controllers/calendar_controller.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var isReLoading = false.obs;
  var homeDataModel = HomeDataModel().obs;
  var packageInfoModel = PackageInfoModel().obs;
  var page = "";
  var cancelDialogue = false.obs;

  var notice = "".obs;

  var userData = UserDataModel().obs;

  var upcomingCaseDateList = UpComingCaseDateModel().obs;
  var upcomingCase = SingleNextCaseTimelineModel().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getUserData();
    await getPackageInfo().then((value) async {
      await getHomeData().then((v) async {
        await getNotice();
      });
    });
    //await getUpComingCaseDate();
    await Get.put(AppBarController()).getUserData();
  }

  @override
  void onClose() {}

  Future<void> getHomeData() async {
    isLoading.value = true;
    homeDataModel.value = HomeDataModel();
    var endPoint = APIEndPoints.getHomeData;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        homeDataModel.value = HomeDataModel.fromJson(response);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPackageInfo() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getPackageInfo;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        packageInfoModel.value = PackageInfoModel.fromJson(response);
        Get.find<MyDrawerController>().newSubscription.value =
            packageInfoModel.value.data?.newSubscriber ?? NewSubscriber();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getUserData() async {
    userData.value = await LocalServices.getUser() ?? UserDataModel();
  }

  void newSubscribe({required String amount}) async {
    isLoading.value = true;
    var endPoint = APIEndPoints.newSubscriber;
    var parameters = {"subscriber_fees": amount};
    try {
      var responses = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);
      if (responses != null) {
        Get.put(BkashPaymentController()).url.value = responses["bkash_url"];
        await Get.toNamed(Routes.BKASH_PAYMENT)?.then((value) async {
          await getUserData();
          await getPackageInfo().then((value) async {
            await getHomeData();
          });
        });
      } else {
        CustomSnackBar(isSuccess: false, msg: AppStrings.httpErrorMSG.value)
            .showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> yearlySubscribe({required String amount}) async {
    isLoading.value = true;
    var endPoint = APIEndPoints.yearlySubscriber;
    var parameters = {"yearly_fees": amount};
    try {
      var responses = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);
      if (responses != null) {
        Get.put(BkashPaymentController()).url.value = responses["bkash_url"];
        await Get.toNamed(Routes.BKASH_PAYMENT)?.then((value) async {
          await getUserData();
          await getPackageInfo().then((value) async {
            await getHomeData();
          });
        });
      } else {
        CustomSnackBar(isSuccess: false, msg: AppStrings.httpErrorMSG.value)
            .showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> monthlySubscribe({required String amount}) async {
    isLoading.value = true;
    var endPoint = APIEndPoints.monthlySubscriber;
    var parameters = {"monthly_fees": amount};
    try {
      var responses = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);
      if (responses != null) {
        Get.put(BkashPaymentController()).url.value = responses["bkash_url"];
        await Get.toNamed(Routes.BKASH_PAYMENT)?.then((value) async {
          await getUserData();
          await getPackageInfo().then((value) async {
            await getHomeData();
          });
        });
      } else {
        CustomSnackBar(isSuccess: false, msg: AppStrings.httpErrorMSG.value)
            .showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getUpComingCaseDate() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.upComingCaseDate;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        upcomingCaseDateList.value = UpComingCaseDateModel.fromJson(response);
        if ((upcomingCaseDateList.value.data ?? []).isNotEmpty)
          upcomingCase.value = upcomingCaseDateList.value.data?.first ??
              SingleNextCaseTimelineModel();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getNotice() async {
    var endPoint = APIEndPoints.getNotice;
    var res = await RemoteServices.getRequest(endPoint: endPoint);
    if (res != null) {
      notice.value = res["data"];
    }
  }

  void openTargetPage({required int index}) {
    if (index == 0) {
      Get.put(CasesController()).notice.value = notice.value;
      Get.find<CasesController>().homeDataModel = homeDataModel;
      Get.toNamed(Routes.CASES);
    } else if (index == 1) {
      Get.put(CalendarController()).getEvents();
      Get.toNamed(Routes.CALENDAR);
    } else if (index == 2) {
      Get.put(BooksController()).getBooks();
      Get.put(BooksController()).level.value = BookLevel.books;
      Get.toNamed(Routes.BOOKS);
    } else if (index == 3) {
      Get.put(NotesController()).getNotes();
      Get.toNamed(Routes.NOTES);
    } else if (index == 4) {
      Get.put(ComingSoonController()).title = "Privacy Policy";
      Get.toNamed(Routes.PRIVACY_POLICY);
    } else if (index == 5) {
      Get.toNamed(Routes.VIDEO_LIST);
    } else if (index == 6) {
      Get.toNamed(Routes.SUPPORT_TOKEN);
    } else if (index == 7) {
      Get.toNamed(Routes.USER_GUIDE);
    } else if (index == 8) {
      Get.toNamed(Routes.COMMING_SOON);
    }
  }
}
