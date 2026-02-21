import 'package:advdiary/app/modules/archive/models/archive_model.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/models/single_case_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../models/pagination_model.dart';
import '../../../../services/remote_services.dart';
import '../../addOrUpdateCase/models/category_list_model.dart';

class ArchiveController extends GetxController {

  var isLoading=false.obs;
  var loadingMore=false.obs;

  var openPaginationSlider = false.obs;
  var showDrawerButton = false.obs;
  var archiveList=<SingleCaseModel>[].obs;
  var pagination=Pagination().obs;

  var archiveModel=ArchiveModel().obs;

  var filterTextController=TextEditingController();
  var categoryController = TextEditingController();
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();

  var categoryListModel = CategoryListModel().obs;
  var selectedCategory = SingleCategoryModel().obs;
  var categoryNames = <String>[].obs;

  bool isFiltered=false;




  @override
  void onInit()async {
    super.onInit();
    await getDataArchiveData();
    await getCategoryList();
  }


  Future<void> getDataArchiveData()async{
    isLoading.value=true;
    var endPoint=APIEndPoints.getArchive;
    try {
      var res=await RemoteServices.getRequest(endPoint: endPoint);
      if(res!=null){
         archiveModel.value=ArchiveModel.fromJson(res);
        archiveList.value=archiveModel.value.data??[];
        pagination.value=archiveModel.value.pagination??Pagination();
      }
    } finally {
      isLoading.value=false;
    }
  }

  void loadMore({required String url}) async {
    loadingMore.value = true;
    try {
      await RemoteServices.getRequestLoadMore(url: url).then((value) {
        if (value != null) {
           archiveModel.value=ArchiveModel.fromJson(value);
          archiveList.value += archiveModel.value.data ?? [];
          pagination.value=archiveModel.value.pagination??Pagination();
        }
      });
    } finally {
      loadingMore.value = false;
    }
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

  Future<void> clearFilter() async {
    filterTextController.text = "";
    selectedCategory.value = SingleCategoryModel();
    categoryController.text = "";
    startDateController.text = "";
    endDateController.text = "";
    if (isFiltered) {
      await getDataArchiveData();
      isFiltered = false;
    }
  }

  Future<void> filterCaseList() async {
    isLoading.value = true;
    isFiltered = true;
    archiveList.value = [];
    var endPoint = APIEndPoints.getArchive;
    var parameters = getParameters();
    try {
      var response = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);
      if (response != null) {
        archiveModel.value = ArchiveModel.fromJson(response);
        archiveList.value = archiveModel.value.data ?? [];
        pagination.value=archiveModel.value.pagination??Pagination();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, dynamic> getParameters() {
    return {
      "search_text": filterTextController.text,
      "category_id": (selectedCategory.value.id ?? "").toString(),
      "status_id": "",
      "from": startDateController.text,
      "to": endDateController.text,
    };
  }
}
