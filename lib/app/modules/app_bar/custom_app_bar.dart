/*
import 'package:advdiary/app/modules/todayCaseList/controllers/today_case_list_controller.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common_widgets/custom_bottom_sheet.dart';
import '../../../theme/app_colors.dart';
import 'app_bar_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;

  final VoidCallback? openDrawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final TextAlign? textAlign;

  final bool showDrawerButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.scaffoldKey,
    this.openDrawer,
    this.showDrawerButton = true,
    this.textAlign,
  });

  @override
  Size get preferredSize =>  Size.fromHeight(120.sp);

  @override
  Widget build(BuildContext context) {
    final appBarController = Get.put(AppBarController());

    if (showBack) {
      // ---------- Back Button Mode ----------
      return AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon:  const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: AppTextStyles.title(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      );
    }

    // ---------- Dashboard Mode ----------
    return Obx((){
      return appBarController.isLoading.value
          ?Container()
          :Container(
        height: 120.sp,
        padding:  EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w, vertical: AppDimensions.contentPadding.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.borderRadiusLarge.r),
            topRight: Radius.circular(AppDimensions.borderRadiusLarge.r),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // top row with icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    //icon:  const Icon(Icons.grid_view, color: Colors.white),
                    icon:  const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      scaffoldKey?.currentState?.openDrawer();
                    },
                  ),
                  Expanded(
                    child: Text(
                       title,
                      style: AppTextStyles.title(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign:textAlign?? TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon:
                    const Icon(Icons.notifications_none, color: Colors.white,),
                    onPressed: () {},
                  ),
                ],
              ),

              SizedBox(height: AppDimensions.contentPadding.h),

              // bottom stats row
              Obx(() => Padding(
                padding:  EdgeInsets.symmetric(horizontal: AppDimensions.contentPadding.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfo(
                        "Case Limit", "${appBarController.appBarData.value.data?.totalCases??0}/ ${appBarController.appBarData.value.data?.packageLimit??0}"),
                    _buildInfo("Package", appBarController.appBarData.value.data?.packageName??"",
                        isPackage: true,
                      onTap: (){
                        showCustomBottomSheet(
                          title: "Details about ${appBarController.appBarData.value.data?.packageName} plan",
                          content: Html(
                            data: appBarController.appBarData.value.data?.pkgDetails ?? "<p>No details available.</p>",
                          ),
                          headerColor: AppColors.primaryColor,
                        );
                      }

                    ),
                    _buildInfo("Today Case",
                        "${appBarController.appBarData.value.data?.todayCase??0}",
                    onTap: (){
                      //need to implement
                      if(Get.currentRoute!=Routes.TODAY_CASE_LIST){
                        Get.put(TodayCaseListController()).getTodayCaseList();
                        Get.toNamed(Routes.TODAY_CASE_LIST);
                      }


                    }
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildInfo(
      String label,
      String value, {
        bool isPackage = false,
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap, // callback trigger
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTextStyles.header(color: Colors.white),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: AppTextStyles.header(
              color: isPackage ? const Color(0xffFBB429) : Colors.cyanAccent,
            ),
          ),
        ],
      ),
    );
  }

}
*/

import 'package:advdiary/app/modules/todayCaseList/controllers/today_case_list_controller.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common_widgets/custom_bottom_sheet.dart';
import '../../../theme/app_colors.dart';
import 'app_bar_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final VoidCallback? openDrawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final TextAlign? textAlign;
  final bool showDrawerButton;
  final bool showBottomRow;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.scaffoldKey,
    this.openDrawer,
    this.showDrawerButton = true,
    this.textAlign,
    this.showBottomRow = true,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(showBottomRow ? 120.sp : 70.sp);

  @override
  Widget build(BuildContext context) {
    final appBarController = Get.put(AppBarController());

    if (showBack) {
      return AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: AppTextStyles.title(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      );
    }

    return Obx(() {
      return appBarController.isLoading.value
          ? const SizedBox()
          : Container(
        height: showBottomRow ? 120.sp : 70.sp,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding.w,
          vertical: AppDimensions.contentPadding.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft:
            Radius.circular(AppDimensions.borderRadiusLarge.r),
            topRight:
            Radius.circular(AppDimensions.borderRadiusLarge.r),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// -------- TOP ROW --------
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  showDrawerButton
                      ? IconButton(
                    icon: const Icon(Icons.menu,
                        color: Colors.white),
                    onPressed: () {
                      scaffoldKey
                          ?.currentState
                          ?.openDrawer();
                    },
                  )
                      : const SizedBox(width: 40),

                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.title(
                          color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign:
                      textAlign ?? TextAlign.center,
                    ),
                  ),

                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),

              /// -------- BOTTOM ROW --------
              if (showBottomRow) ...[
                SizedBox(
                    height:
                    AppDimensions.contentPadding.h),

                Obx(
                      () => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                      AppDimensions.contentPadding.w,
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfo(
                          "Case Limit",
                          "${appBarController.appBarData.value.data?.totalCases ?? 0}/ ${appBarController.appBarData.value.data?.packageLimit ?? 0}",
                        ),

                        _buildInfo(
                          "Package",
                          appBarController.appBarData.value
                              .data?.packageName ??
                              "",
                          isPackage: true,
                          onTap: () {
                            showCustomBottomSheet(
                              title:
                              "Details about ${appBarController.appBarData.value.data?.packageName} plan",
                              content: Html(
                                data: appBarController
                                    .appBarData
                                    .value
                                    .data
                                    ?.pkgDetails ??
                                    "<p>No details available.</p>",
                              ),
                              headerColor:
                              AppColors.primaryColor,
                            );
                          },
                        ),

                        _buildInfo(
                          "Today Case",
                          "${appBarController.appBarData.value.data?.todayCase ?? 0}",
                          onTap: () {
                            if (Get.currentRoute !=
                                Routes.TODAY_CASE_LIST) {
                              Get.put(
                                  TodayCaseListController())
                                  .getTodayCaseList();

                              Get.toNamed(
                                  Routes.TODAY_CASE_LIST);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      );
    });
  }

  Widget _buildInfo(
      String label,
      String value, {
        bool isPackage = false,
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTextStyles.header(color: Colors.white),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: AppTextStyles.header(
              color: isPackage
                  ? const Color(0xffFBB429)
                  : Colors.cyanAccent,
            ),
          ),
        ],
      ),
    );
  }
}