/*
import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/empty_screen.dart';
import '../../../../common_widgets/pagination_side_menu.dart';
import '../../caseList/views/single_case_card.dart';
import '../controllers/today_case_list_controller.dart';

class TodayCaseListView extends GetView<TodayCaseListController> {
   TodayCaseListView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: 'Today CaseList',
          scaffoldKey: _scaffoldKey,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: Obx(
                () => Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: AppDimensions.widgetPadding.h,),
                    Expanded(
                      child: bodyContent(),
                    ),
                  ],
                ),
                Container(
                  height: Get.height,
                ),
                if ((controller.todayCaseList.value.data??[]).isNotEmpty)
                  PaginationSideMenu(
                    isExpanded: controller.openPaginationSlider,
                    //pagination: controller.caseListModel.value.pagination,
                    pdfDownloadLink: controller.todayCaseList.value.todayCaseListDownloadLink??"",
                    //exelDownloadLink: controller.caseListModel.value.exelDownloadLink??"",
                    totalCase: (controller.todayCaseList.value.data??[]).length,
                  ),
                if (controller.isLoading.value) const LoadingScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bodyContent() {
    return (controller.todayCaseList.value.data ?? []).isEmpty
        ? Padding(
      padding: EdgeInsets.only(top: AppDimensions.sectionPadding.h),
      child: const EmptyScreen(title: "No data found!"),
    )
        : CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPadding.w),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: controller.todayCaseList.value.data?.length,
                  (buildContext, index) {
                return SingleCaseCard(
                  caseModel: controller.todayCaseList.value.data![index],
                  isButtonEnable: false,

                );
              }),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 100.h,
          ),
        )
      ],
    );
  }
}
*/


import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/empty_screen.dart';
import '../../../../common_widgets/pagination_side_menu.dart';
import '../../../routes/app_pages.dart';
import '../../caseDetails/controllers/case_details_controller.dart';
import '../../caseList/views/single_case_card.dart';
import '../controllers/today_case_list_controller.dart';

class TodayCaseListView extends GetView<TodayCaseListController> {
  TodayCaseListView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: 'Today CaseList',
          scaffoldKey: _scaffoldKey,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: Obx(
                () => Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: AppDimensions.widgetPadding.h),

                    /// SEARCH BOX
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.horizontalPadding.w,
                      ),
                      child: Obx(() {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.07),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: TextEditingController(text: controller.searchText.value)
                              ..selection = TextSelection.fromPosition(
                                TextPosition(offset: controller.searchText.value.length),
                              ),
                            onChanged: (value) {
                              controller.searchText.value = value;
                            },
                            style: const TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              hintText: "Search case...",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),

                              // **Clear Button**
                              suffixIcon: controller.searchText.value.isNotEmpty
                                  ? InkWell(
                                onTap: () {
                                  controller.searchText.value = "";
                                  controller.getTodayCaseList(search: "");
                                },
                                child: Icon(Icons.close, color: Colors.grey.shade600),
                              )
                                  : null,

                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                            ),
                          ),
                        );
                      }),
                    ),


                    const SizedBox(height: 10),

                    Expanded(child: bodyContent()),
                  ],
                ),

                if ((controller.todayCaseList.value.data ?? []).isNotEmpty)
                  PaginationSideMenu(
                    isExpanded: controller.openPaginationSlider,
                    pdfDownloadLink:
                    controller.todayCaseList.value.todayCaseListDownloadLink ?? "",
                    totalCase: (controller.todayCaseList.value.data ?? []).length,
                  ),

                if (controller.isLoading.value) const LoadingScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bodyContent() {
    return (controller.todayCaseList.value.data ?? []).isEmpty
        ? Padding(
      padding: EdgeInsets.only(top: AppDimensions.sectionPadding.h),
      child: const EmptyScreen(title: "No data found!"),
    )
        : CustomScrollView(
      slivers: [

        SliverList(
          delegate: SliverChildBuilderDelegate(
                (buildContext, index) {
              return SingleCaseCard(
                caseModel: controller.todayCaseList.value.data![index],
                //isButtonEnable: false,
                onDetails: () {
                  Get.put(CaseDetailsController());
                  Get.find<CaseDetailsController>().getCaseDetails(
                      caseId:
                      (controller.todayCaseList.value.data![index].id).toString());
                  Get.toNamed(Routes.CASE_DETAILS);
                },
              );
            },
            childCount: controller.todayCaseList.value.data?.length ?? 0,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 100.h),
        )
      ],
    );
  }
}
