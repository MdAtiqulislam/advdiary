import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common_widgets/auto_scroll_text_list.dart';
import 'item_card.dart';
import '../controllers/cases_controller.dart';

class CasesView extends GetView<CasesController> {
   CasesView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(title: "Cases",scaffoldKey: _scaffoldKey,),
        drawer: MyDrawer(),
        floatingActionButton: controller.notice.isEmpty?null:AutoScrollingText(text:controller.notice.value,),
        floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child:  Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: AppDimensions.widgetPadding.h,),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // Prevent nested scrolling issues
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        childAspectRatio: 1.4,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5),
                    children: [
                      ItemCard(
                          name: "Total Case",
                          count: controller.homeDataModel.value.data
                              ?.totalCase ??
                              0,
                          onTap: () {
                           /* controller.page = "";
                            controller.openCaseList();*/
                          },
                         // color: const Color(0xff17a2b8)
                      ),
                      ItemCard(
                          name: "Total Running Case",
                          count: controller.homeDataModel.value.data
                              ?.totalActiveCase ??
                              0,
                          onTap: () {
                            controller.page = "active";
                            controller.openCaseList();
                          },
                         // color: const Color(0xff17a2b8)
                      ),
                      ItemCard(
                          name: "Archive",
                          count: controller.homeDataModel.value.data
                              ?.totalArchiveCase ??
                              0,
                          onTap: () {
                           Get.toNamed(Routes.ARCHIVE);
                          },
                         // color: const Color(0xff17a2b8)
                      ),
                      ItemCard(
                          name: "Judgement",
                          count: controller.homeDataModel.value.data
                              ?.totalJudgment ??
                              0,
                          onTap: () {
                           /* controller.page = "judgement";
                            controller.openCaseList();*/
                            Get.toNamed(Routes.ARCHIVE);
                          },
                          //color: const Color(0xff28a745)
                      ),
                      ItemCard(
                          name: "Pending",
                          count: controller.homeDataModel.value.data
                              ?.totalPendingCase ??
                              0,
                          onTap: () {
                            controller.page = "pending";
                            controller.openCaseList();
                          },
                          //color: const Color(0xffffc107)
                      ),
                      ItemCard(
                          name: "Stay",
                          count: controller.homeDataModel.value.data
                              ?.totalStay ??
                              0,
                          onTap: () {
                            controller.page = "stay";
                            controller.openCaseList();
                          },
                          //color: const Color(0xFFE32CC5)
                      ),
                      ItemCard(
                          name: "Compromise",
                          count: controller.homeDataModel.value.data
                              ?.totalCompromise ??
                              0,
                          onTap: () {
                           /* controller.page = "compromise";
                            controller.openCaseList();*/
                            Get.toNamed(Routes.ARCHIVE);
                          },
                         // color: const Color(0xff007bff)
                      ),
                      ItemCard(
                          name: "Injunction",
                          count: controller.homeDataModel.value.data
                              ?.totalInjunction ??
                              0,
                          onTap: () {
                            controller.page = "injunction";
                            controller.openCaseList();
                          },
                          //color: const Color(0xff12a37c)
                      ),
                      ItemCard(
                          name: "Dismissed/ Rejected",
                          count: controller.homeDataModel.value.data
                              ?.totalDismissed ??
                              0,
                          onTap: () {
                           /* controller.page = "dismissed";
                            controller.openCaseList();*/
                            Get.toNamed(Routes.ARCHIVE);
                          },
                          //color: const Color(0xffdc3545)
                      ),
                      ItemCard(
                        name: "Status Que",
                        count: controller.homeDataModel.value.data
                            ?.totalStatusQuo ??
                            0,
                        onTap: () {
                          controller.page = "status-quo";
                          controller.openCaseList();
                        },
                       // color: const Color(0xff17a2b8),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.sectionPadding*5.h,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
