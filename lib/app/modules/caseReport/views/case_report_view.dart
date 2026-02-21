import 'package:advdiary/app/modules/caseReport/views/cort_report_filter.dart';
import 'package:advdiary/app/modules/caseReport/views/single_report_card.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/common_widgets/pagination_side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/empty_screen.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../models/single_cort_report_model.dart';
import '../../app_bar/custom_app_bar.dart';
import '../../bottom_navigation_bar/custom_bottom_nav_bar.dart';
import '../controllers/case_report_controller.dart';

class CaseReportView extends GetView<CaseReportController> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  CaseReportView({super.key});

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(_loadMoreListener);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: "Court Report",
          scaffoldKey: _scaffoldKey,
          showDrawerButton: controller.showDrawerButton.value,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: AppDimensions.widgetPadding.h),
                  const CortReportFilter(),
                  Expanded(
                    child: Obx(() => _bodyContent()),
                  ),
                ],
              ),
              Obx(() {
                if (controller.courtReportList.isNotEmpty) {
                  return PaginationSideMenu(
                    isExpanded: controller.openPaginationSlider,
                    pagination: controller.courtReportListModel.value.pagination!,
                    pdfDownloadLink: controller.courtReportListModel.value.pdfDownloadLink ?? "",
                   // exelDownloadLink: controller.courtReportListModel.value.exelDownloadLink ?? "",
                  );
                }
                return const SizedBox.shrink();
              }),
              Obx(() => controller.isLoading.value ? const LoadingScreen() : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyContent() {
    final list = controller.courtReportList;
    if (list.isEmpty && !controller.isLoading.value) {
      return const EmptyScreen(title: "No data found!");
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: list.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final report = list[index] ?? SingleCourtReportModel();
        return SingleReportCard(reportModel: report);
      },
    );
  }

  void _loadMoreListener() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
        controller.courtReportListModel.value.pagination?.currentPage !=
            controller.courtReportListModel.value.pagination?.lastPage &&
        !controller.loadingMore.value) {
      controller.loadMore(
        url: controller.courtReportListModel.value.pagination?.nextPageUrl ?? "",
      );
    }
  }
}
