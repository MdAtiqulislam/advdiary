import 'package:advdiary/app/modules/addOrUpdateCase/models/category_list_model.dart';
import 'package:advdiary/app/modules/caseReport/models/cort_report_list_model.dart';
import 'package:advdiary/app/modules/caseReport/models/court_list_model.dart';
import 'package:advdiary/models/single_cort_report_model.dart';
import 'package:advdiary/models/status_model.dart';
import 'package:get/get.dart';
import '../../../../constraints/api_endpoints.dart';
import '../../../../models/single_court_model.dart';
import '../../../../services/remote_services.dart';
import '../../../../utils/utils.dart';

class CaseReportController extends GetxController {

  var isLoading=false.obs;
  var loadingMore=false.obs;
  var isFiltered=false;

  var courtReportListModel=CourtReportListModel().obs;
  var courtReportList=<SingleCourtReportModel>[].obs;
  var courtListModel=CourtListModel().obs;
  var categoryListModel=CategoryListModel().obs;
  var statusListModel=StatusListModel().obs;

  var isFilterExpanded = false.obs;

  var courtNames=<String>[].obs;
  var categoryNames=<String>[].obs;
  var statusNames=<String>[].obs;

  var selectedCourt=SingleCourtModel().obs;
  var selectedCategory=SingleCategoryModel().obs;
  var selectedStatus=SingleStatusModel().obs;

  var openPaginationSlider=false.obs;

  var showDrawerButton=false.obs;

  @override
  void onInit()async {
    updateStatusBar();
    super.onInit();
    await getCategoryList();
    await getStatus();
    await getCourtList();
  }


  @override
  void onClose() {}


  Future<void> getCategoryList() async {
    isLoading.value = true;
   // categoryNames.value=["Select One"];
    var endPoint = APIEndPoints.getCategoryList;
    try {
      var response = await RemoteServices.getRequest(endPoint: endPoint);
      if (response != null) {
        categoryListModel.value = CategoryListModel.fromJson(response);
        categoryListModel.value.data?.forEach((value){
          categoryNames.add(value.caseCategory??"");
        });
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getStatus()async {
    isLoading.value=true;
    var endPoint=APIEndPoints.getStatusEndPoint;
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint);
      if(response!=null){
        print(response.toString());
        statusListModel.value=StatusListModel.fromJson(response);
        statusListModel.value.data?.forEach((value){
          statusNames.add(value.name??"");
        });
      }
    } finally {
      isLoading.value=false;
    }
  }

  Future<void> getCourtList() async{
    isLoading.value=true;
    var endPoint=APIEndPoints.getCourtListEndpoint;
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint);
      if(response!=null){
        courtListModel.value=CourtListModel.fromJson(response);
        courtListModel.value.data?.forEach((value){
          courtNames.add(value.cortName??"");
        });
      }
    } finally {
      isLoading.value=false;
    }
  }

  Future<void>getCaseReport()async{
    isLoading.value=true;
    courtReportList.value=[];
    var endPoint=APIEndPoints.getCourtReportEndPoint;
    var parameters={
      "court_id":(selectedCourt.value.id??"").toString(),
      "category_id":(selectedCategory.value.id??"").toString(),
      "status_id":(selectedStatus.value.id??"").toString(),
    };
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint,parameters: parameters);
      if(response!=null){
       courtReportListModel.value=CourtReportListModel.fromJson(response);
       courtReportList.value=courtReportListModel.value.data??[];
      }
    } finally {
      isLoading.value=false;
    }
  }








  Future<void> clearFilter() async{
    selectedStatus.value=SingleStatusModel();
    selectedCourt.value=SingleCourtModel();
    selectedCategory.value=SingleCategoryModel();
    courtReportList.value=[];
   if (isFiltered) {
     await getCaseReport();
     isFiltered=false;
   }
  }

  void loadMore({required String url})async{
    loadingMore.value=true;
    try {
      await RemoteServices.getRequestLoadMore(url: url).then((value){
        if(value!=null){
          courtReportListModel.value=CourtReportListModel.fromJson(value);
          courtReportList.value+=courtReportListModel.value.data??[];
        }
      });
    } finally {
      loadingMore.value=false;
    }
  }

}
