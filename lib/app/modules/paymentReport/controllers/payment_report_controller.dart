import 'package:advdiary/app/modules/paymentReport/model/payment_report_model.dart';
import 'package:get/get.dart';

import '../../../../constraints/api_endpoints.dart';
import '../../../../services/remote_services.dart';
import '../../../../utils/utils.dart';

class PaymentReportController extends GetxController {

  var loadingMore=false.obs;
  var isLoading=false.obs;

  var paymentReport=PaymentReportModel().obs;
  var reportList=<SinglePayment>[].obs;

  @override
  void onInit() {
    updateStatusBar();
    getPaymentReports();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void>getPaymentReports()async{
    isLoading.value=true;
    reportList.value=[];
    var endPoint=APIEndPoints.getPaymentReportEndPoint;
    try {
      var response=await RemoteServices.getRequest(endPoint: endPoint);
      if(response!=null){
       paymentReport.value=PaymentReportModel.fromJson(response);
       reportList.value=paymentReport.value.data??[];
      }
    } finally {
      isLoading.value=false;
    }
  }


  void loadMore({required String url})async{
    loadingMore.value=true;
    try {
      await RemoteServices.getRequestLoadMore(url: url).then((value){
        if(value!=null){
          paymentReport.value=PaymentReportModel.fromJson(value);
          reportList.value+=paymentReport.value.data??[];
        }
      });
    } finally {
      loadingMore.value=false;
    }
  }
}
