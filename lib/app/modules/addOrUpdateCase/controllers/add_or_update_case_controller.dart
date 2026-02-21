import 'package:advdiary/app/modules/addOrUpdateCase/models/category_list_model.dart';
import 'package:advdiary/app/modules/addOrUpdateCase/models/edit_case_model.dart';
import 'package:advdiary/app/modules/addOrUpdateCase/models/thana_list_model.dart';
import 'package:advdiary/app/modules/addOrUpdateCase/models/update_case_model.dart';
import 'package:advdiary/app/modules/app_bar/app_bar_controller.dart';
import 'package:advdiary/app/modules/caseList/controllers/case_list_controller.dart';
import 'package:advdiary/app/modules/caseReport/models/court_list_model.dart';
import 'package:advdiary/app/modules/home/controllers/home_controller.dart';
import 'package:advdiary/app/modules/registration/models/district_model.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/common_widgets/custom_snackbar.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/constraints/app_strings.dart';
import 'package:advdiary/models/single_case_model.dart';
import 'package:advdiary/models/single_court_model.dart';
import 'package:advdiary/models/single_district.dart';
import 'package:advdiary/models/single_thana.dart';
import 'package:advdiary/models/user_data_model.dart';
import 'package:advdiary/services/local_services.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';

class AddOrUpdateCaseController extends GetxController {
  var isLoading = false.obs;
  var type = "".obs; // New or Update
  var userData = UserDataModel().obs;

  var categoryListModel = CategoryListModel().obs;
  var selectedCategory = SingleCategoryModel().obs;
  var categoryNames = <String>[].obs;

  var dateController = TextEditingController();
  var caseNoController = TextEditingController();
  var clientNameController = TextEditingController();
  var phoneController = TextEditingController();
  var otherSideController = TextEditingController();
  var paymentController = TextEditingController();
  var courtController = TextEditingController();
  var grCaseNoController = TextEditingController();
  var remarksController=TextEditingController();

  var editCaseDataModel = EditCaseModel().obs;
  var caseId = "";

  var districts = <SingleDistrict>[].obs;
  var selectedDistrict = SingleDistrict().obs;

  var thanas = <SingleThana>[].obs;
  var selectedThana = SingleThana().obs;

  var courtList = <SingleCourtModel>[].obs;
  var selectedCourt = SingleCourtModel().obs;



  @override
  void onInit() async {
    updateStatusBar();
    super.onInit();
    await getUserData();
    await getCategoryList();
   // await getDistrictList();
   // await getCourtList();
  }

  @override
  void onClose() {}

  Future<void> getUserData() async {
    userData.value = await LocalServices.getUser() ?? UserDataModel();
  }

  Future<void> getCategoryList() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getCategoryList;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        categoryListModel.value = CategoryListModel.fromJson(response);
        categoryListModel.value.data?.forEach((value) {
          categoryNames.add(value.caseCategory ?? "");
        });
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getDistrictList({bool stopReload=true}) async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getDistrict;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        var districtModel = DistrictModel.fromJson(response);
        districts.value = districtModel.data ?? [];
      }
    } finally {
      if(stopReload)isLoading.value = false;
    }
  }

  Future<void> getCourtList({bool stopReload=true}) async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getCourtListEndpoint;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        var courtModel = CourtListModel.fromJson(response);
        courtList.value = courtModel.data ?? [];
      }
    } finally {
     if(stopReload) isLoading.value = false;
    }
  }

  Future<void> getThana() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getThana;
    var parameters = {
      "district_id": selectedDistrict.value.id.toString(),
    };
    try {
      var res =
      await RemoteServices.getRequest(endPoint: endPoint, parameters: parameters);
      if (res != null) {
        var thanaListModel = ThanaListModel.fromJson(res);
        thanas.value = thanaListModel.data ?? [];
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getEditCaseData() async {
     resetFormData();
    isLoading.value = true;
    await getDistrictList(stopReload: false).then((value) async {
      await getCourtList(stopReload: false).then((value) async {
        var endPoint = APIEndPoints.editCaseEndPoint;
        var parameter = {"edit_id": caseId};
        try {
          var response = await RemoteServices.getRequest(
            endPoint: endPoint,
            parameters: parameter,
          );
          if (response != null) {
            editCaseDataModel.value = EditCaseModel.fromJson(response);
            await setFormData(); // 🟢 loader বন্ধ করার আগে wait কর
          }
        } finally {
          isLoading.value = false;
        }
      });
    });
  }

  Future<void> setFormData() async {
    final data = editCaseDataModel.value.data;
    if (data == null) return;

    caseNoController.text = data.caseNumber ?? '';
    dateController.text = data.caseDate ?? '';
    clientNameController.text = data.clientName ?? '';
    phoneController.text = data.mobileNo ?? '';
    otherSideController.text = data.otherSide ?? '';
    paymentController.text = (data.payment ?? 0).toString();
    grCaseNoController.text = data.grCaseNo ?? '';
    remarksController.text = data.remarks ?? '';
    courtController.clear();

    selectedCategory.value = categoryListModel.value.data?.firstWhere(
            (e) => e.id == data.categoryId,
        orElse: () => SingleCategoryModel()) ??
        SingleCategoryModel();

    selectedDistrict.value = districts.firstWhere(
            (e) => e.id == data.districtId,
        orElse: () => SingleDistrict(id: data.districtId));

    await getThana(); // District select করার পরে Thana আনো

    selectedThana.value = thanas.firstWhere(
            (e) => e.id == data.thanaId,
        orElse: () => SingleThana(id: data.thanaId));

    selectedCourt.value = courtList.firstWhere(
            (e) => e.id == data.courtId,
        orElse: () => SingleCourtModel(id: data.courtId));

    courtController.text = selectedCourt.value.cortName ?? '';
  }

  void resetFormData() {
    caseNoController.clear();
    dateController.clear();
    clientNameController.clear();
    phoneController.clear();
    otherSideController.clear();
    paymentController.text = '0';
    courtController.clear();
    grCaseNoController.clear();
    remarksController.clear();

    selectedCategory.value = SingleCategoryModel();
    selectedDistrict.value = SingleDistrict();
    selectedThana.value = SingleThana();
    selectedCourt.value = SingleCourtModel();
  }

  Map<String, dynamic> getBody() {
    final body = {
      "case_number": caseNoController.text,
      "category_id": selectedCategory.value.id,
      "case_date": dateController.text,
      "client_name": clientNameController.text,
      "other_side": otherSideController.text,
      "mobile_no": phoneController.text,
      "payment": paymentController.text,
      "court_id": selectedCourt.value.id.toString(),
      "district_id": selectedDistrict.value.id.toString(),
      "thana_id": selectedThana.value.id.toString(),
      "remarks":remarksController.text,
    };

    if (selectedCategory.value.id == 3) {
      body["gr_case_no"] = grCaseNoController.text;
    }

    return body;
  }

  void addNewCase() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.addCaseEndPoint;
    var body = getBody();
    try {
      var response = await RemoteServices.postRequestWithJsonData(
        endPoint: endPoint,
        body: body,
      );
      if (response != null) {
        CustomSnackBar(msg: response["msg"], isSuccess: true).showSnackBar();
        Get.put(AppBarController()).getAppBarData();

        Get.put(HomeController()).getHomeData();
        Get.put(CaseListController()).getCaseList();
        openCaseList();
      } else {
        CustomSnackBar(
            msg: AppStrings.httpErrorMSG.value, isSuccess: false)
            .showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void updateCase({required String editId}) async {
    isLoading.value = true;
    var endPoint = APIEndPoints.updateCaseEndPoint;
    var body = getBody();
    var parameter = {"edit_id": editId};
    try {
      var response = await RemoteServices.postRequestWithJsonData(
        endPoint: endPoint,
        body: body,
        parameters: parameter,
      );
      if (response != null) {
        Get.put(HomeController()).getHomeData();

        UpdateCaseModel updateCaseModel=UpdateCaseModel.fromJson(response);
        SingleCaseModel? singleCaseModel=updateCaseModel.data;

        Get.put(CaseListController()).updateCaseInList(singleCaseModel??SingleCaseModel());

        Get.back();
        CustomSnackBar(msg: response["msg"], isSuccess: true).showSnackBar();
      } else {
        CustomSnackBar(
            msg: AppStrings.httpErrorMSG.value, isSuccess: false)
            .showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void openCaseList() {
    Get.put(CaseListController());
    Get.find<CaseListController>().page = "";
    Get.find<CaseListController>().getCaseList();
    Get.toNamed(Routes.CASE_LIST);
  }
}
