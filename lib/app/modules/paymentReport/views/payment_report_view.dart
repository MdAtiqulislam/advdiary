import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/app/modules/paymentReport/views/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../constraints/dimensions.dart';
import '../controllers/payment_report_controller.dart';
import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';


class PaymentReportView extends GetView<PaymentReportController> {
  PaymentReportView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      loadMoreData();
    });

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: "Payment History",
          scaffoldKey: _scaffoldKey,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: Obx(
                () => Stack(
              children: [
                controller.isLoading.value
                    ? const LoadingScreen()
                    : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w,vertical: AppDimensions.contentPadding.h),
                        itemCount: controller.reportList.length + 1,
                        itemBuilder: (context, index) {
                          if (index < controller.reportList.length) {
                            return PaymentCard(payment: controller.reportList[index]);
                          } else if (controller.loadingMore.value) {
                            return const Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                    if(controller.loadingMore.value)const Center(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loadMoreData() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (controller.paymentReport.value.pagination?.currentPage !=
          controller.paymentReport.value.pagination?.lastPage &&
          !controller.loadingMore.value) {
        controller.loadMore(
          url: controller.paymentReport.value.pagination?.nextPageUrl ?? "",
        );
      }
    }
  }
}
