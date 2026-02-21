import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/empty_screen.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/models/single_next_case_data_model.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/pagination_side_menu.dart';
import '../../../../theme/app_colors.dart';
import '../controllers/next_case_time_line_controller.dart';

class NextCaseTimeLineView extends GetView<NextCaseTimeLineController> {
  NextCaseTimeLineView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: "Your Cases",
          scaffoldKey: _scaffoldKey,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: Obx(
            () => Stack(
              children: [
                bodyContent(),
                if ((controller.nextCaseTimeline.value.data ?? []).isNotEmpty)
                  PaginationSideMenu(
                    isExpanded: controller.openPaginationSlider,
                    pdfDownloadLink:
                        controller.nextCaseTimeline.value.pdfDownloadLink ?? "",
                    totalCase:
                        (controller.nextCaseTimeline.value.data ?? []).length,
                  ),
                if (controller.isLoading.value) const LoadingScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyContent() {
    final cases = controller.nextCaseTimeline.value.data ?? [];

    if (cases.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.horizontalPadding.w,
            vertical: AppDimensions.widgetPadding.h),
        child: const EmptyScreen(title: "No data found"),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding.w,
          vertical: AppDimensions.widgetPadding.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width,
            child: Text(
              "Upcoming Cases",
              textAlign: TextAlign.center,
              style: AppTextStyles.title(),
            ),
          ),
          SizedBox(height: 10.h),

          /// List of cases
          Expanded(
            child: ListView.builder(
              itemCount: cases.length,
              itemBuilder: (context, index) {
                final caseData = cases[index];
                return IntrinsicHeight(
                  // 👈 ensures equal height row
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// LEFT SIDE: Date Circle + Line
                      Column(
                        children: [
                          Container(
                            width: 55.sp,
                            height: 55.sp,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _getDay(caseData.nextDate ?? ""),
                                  style: AppTextStyles.header(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  _getMonth(caseData.nextDate ?? ""),
                                  style: AppTextStyles.header(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (index != cases.length - 1)
                            Expanded(
                              child: Container(
                                width: 2,
                                color: Colors.grey.shade400,
                              ),
                            ),
                        ],
                      ),

                      SizedBox(width: 12.w),

                      /// RIGHT SIDE: Case Card
                      Expanded(child: _buildCaseCard(caseData)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaseCard(SingleNextCaseTimelineModel caseData) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r)),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: AppDimensions.contentPadding.h),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.horizontalPadding.w,
            vertical: AppDimensions.verticalPadding.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bold Section
            if ((caseData.caseNumber ?? "").isNotEmpty) ...[
              Text(
                "Case Number: ${caseData.caseNumber ?? '--'}",
                style: AppTextStyles.body(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
            ] else if ((caseData.grCaseNumber ?? "").isNotEmpty) ...[
              Text(
                "G.R. Case Number: ${caseData.grCaseNumber ?? '--'}",
                style: AppTextStyles.body(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
            ],

            SizedBox(height: AppDimensions.contentPadding.w),

// Normal Info Section
            if ((caseData.caseNumber ?? "").isNotEmpty &&
                (caseData.grCaseNumber ?? "").isNotEmpty)
              Text("G.R. Case Number: ${caseData.grCaseNumber ?? '--'}"),

            Text("Next Date: ${caseData.nextDate ?? '--'}"),
            Text("Client: ${caseData.clientName ?? '--'}"),
            Text("Mobile: ${caseData.mobileNo ?? '--'}"),
            Text("Court: ${caseData.courtName ?? '--'}"),
            Text("Step: ${caseData.fixedFor ?? '--'}"),
            SizedBox(height: AppDimensions.contentPadding.h),

            /*Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPadding.w,
                  vertical: AppDimensions.contentPadding.h),
              decoration: BoxDecoration(
                  // color: AppColors.warning,
                  gradient:  const LinearGradient(
                      colors: [
                        Color(0xfff8af30),
                        Color(0xffae4e00),

                      ]),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.borderRadiusLarge.r)),
              child: Text(
                caseData.statusName ?? "Pending",
                style: AppTextStyles.header(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )*/

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPadding.w * 1.5,
                vertical: AppDimensions.contentPadding.h * 0.8,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xfff8af30),
                    Color(0xffae4e00),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius:
                    BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.1*254).toInt()),
                    blurRadius: 6,
                    offset: const Offset(2, 3),
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.circle, size: 10, color: Colors.white),
                  SizedBox(width: 6.w),
                  Text(
                    caseData.statusName ?? "Pending",
                    style: AppTextStyles.header(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Helpers
  String _getDay(String fullDate) {
    if (fullDate.isEmpty) return "--";
    final parts = fullDate.split("-");
    return parts.isNotEmpty ? parts[0] : "--";
  }

  String _getMonth(String fullDate) {
    if (fullDate.isEmpty) return "--";
    final parts = fullDate.split("-");
    if (parts.length < 2) return "--";
    return _getMonthAbbreviation(parts[1]);
  }

  String _getMonthAbbreviation(String monthNumber) {
    const months = {
      "01": "Jan",
      "02": "Feb",
      "03": "Mar",
      "04": "Apr",
      "05": "May",
      "06": "Jun",
      "07": "Jul",
      "08": "Aug",
      "09": "Sep",
      "10": "Oct",
      "11": "Nov",
      "12": "Dec"
    };
    return months[monthNumber] ?? "--";
  }
}
