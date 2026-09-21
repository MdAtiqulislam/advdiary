import 'package:advdiary/app/modules/app_bar/app_bar_controller.dart';
import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/app/modules/home/views/home_shimmer_view.dart';
import 'package:advdiary/app/modules/home/views/monthly_payment_card.dart';
import 'package:advdiary/app/modules/home/views/package_info_shimmer.dart';
import 'package:advdiary/app/modules/home/views/subscription_card.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/custom_dialog.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/app/modules/home/views/package_info_card.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/auto_scroll_text_list.dart';
import '../../../../theme/app_colors.dart';
import '../controllers/home_controller.dart';
import 'grid_menu.dart';

class HomeView extends GetView<HomeController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        if (controller.isLoading.value) return const HomeShimmerView();

        /// yearly expired check
        if ((controller.packageInfoModel.value.data?.yearlySubscriber
                        ?.yearlyPaymentStatus ??
                    0) ==
                1 &&
            !controller.isLoading.value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (Get.isDialogOpen != true) {
              showYearlyExpiredDialog(context);
            }
          });
        }

        /// yearly expired check
        if ((controller.packageInfoModel.value.data?.yearlySubscriber
                        ?.yearlyPaymentStatus ??
                    0) ==
                0 &&
            (controller.packageInfoModel.value.data?.yearlySubscriber
                    ?.lastFiveDaysWarning ??
                false) &&
            !controller.cancelDialogue.value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (Get.isDialogOpen != true) {
              showYearlyExpiredWarningDialog(context);
            }
          });
        }

        return Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            title: "Advocates Diary",
            scaffoldKey: _scaffoldKey,
            textAlign: TextAlign.start,
          ),
          drawer: MyDrawer(),
          bottomNavigationBar: CustomBottomNavigationBar(
            showNotice: false,
          ),
          floatingActionButton: controller.notice.value.isEmpty
              ? null
              : AutoScrollingText(
                  text: controller.notice.value,
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: CustomBody(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPadding.w),
              child: Column(
                children: [
                  SizedBox(
                    height: AppDimensions.widgetPadding.h,
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.horizontalPadding.w,
                        vertical: AppDimensions.verticalPadding.h),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/images/moc_img_2.png"),
                          fit: BoxFit.cover,
                          opacity: .1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppDimensions.borderRadius.r),
                      ),
                      color: AppColors.secondaryColor
                          .withAlpha((.25 * 254).toInt()),
                    ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.NEXT_CASE_TIME_LINE);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Upcoming Case",
                                    style: AppTextStyles.header(
                                        color: AppColors.primaryColor),
                                  ),
                                  Text(
                                    "${Get.find<AppBarController>().appBarData.value.data?.totalUpcomingNextDate ?? 0}",
                                    style: AppTextStyles.header(
                                        color: const Color(0xffDD9200),
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 1.5,
                            color: AppColors.primaryColor,
                            height: 30.h,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.PENDING_NEXT_DATE);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Pending Next Date",
                                    style: AppTextStyles.header(
                                        color: AppColors.primaryColor),
                                  ),
                                  Text(
                                    "${Get.find<AppBarController>().appBarData.value.data?.notUpdatedPendingNextDate ?? 0}",
                                    style: AppTextStyles.header(
                                        color: const Color(0xffDD9200),
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppDimensions.widgetPadding.h,
                  ),
                  if ((controller.packageInfoModel.value.data?.monthlyPackage
                              ?.bannerStatus ??
                          0) ==
                      1) ...[
                    MonthlyPaymentCard(
                      message:
                          "Please pay your monthly fee to continue using your current package without interruption.",
                      onPayNow: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: "Confirm Payment",
                              //  subtitle: "Unlock Lifetime Access! 🚀",
                              description:
                                  "Complete your monthly payment of Tk ${controller.packageInfoModel.value.data?.monthlyPackage?.monthlyPackageAmount ?? ""}",
                              icon: Icon(
                                Icons.verified,
                                color: AppColors.success,
                                size: 40.sp,
                              ),
                              confirmButtonText: "Pay Now",
                              confirmButtonColor: AppColors.primaryColor,
                              cancelButtonText: "Maybe Later",
                              cancelButtonColor: AppColors.danger,
                              onConfirmButtonPressed: () {
                                Get.back();
                                controller.monthlySubscribe(
                                    amount:
                                        "${controller.packageInfoModel.value.data?.monthlyPackage?.monthlyPackageAmount ?? ""}");
                              },
                            );
                          },
                        );
                      },
                      packageName: controller.packageInfoModel.value.data
                              ?.monthlyPackage?.monthlyPackageName ??
                          "",
                      amount:
                          "${controller.packageInfoModel.value.data?.monthlyPackage?.monthlyPackageAmount}",
                    ),
                    SizedBox(
                      height: AppDimensions.widgetPadding.h,
                    ),
                  ],
                  if ((controller.packageInfoModel.value.data?.newSubscriber
                                  ?.newSubscriberStatus ??
                              0) ==
                          1 &&
                      (controller.packageInfoModel.value.data?.yearlySubscriber
                                  ?.yearlyPaymentStatus ??
                              1) ==
                          0 &&
                      !controller.isLoading.value) ...[
                    PackageInfoCard(
                      packageName: controller.packageInfoModel.value.data
                              ?.currentPackage?.packageName ??
                          "",
                      caseLimit: controller.packageInfoModel.value.data
                              ?.currentPackage?.packageLimit ??
                          "0",
                      addedCases: controller.packageInfoModel.value.data
                              ?.currentPackage?.totalCase ??
                          0,
                      isBasic: controller.packageInfoModel.value.data
                              ?.currentPackage?.packageName ==
                          "Basic",
                      onUpgrade: () {
                        Get.toNamed(Routes.PACKAGES);
                      },
                      onViewMore: () {
                        Get.toNamed(Routes.PACKAGES);
                      },
                    ),
                    SizedBox(
                      height: AppDimensions.contentPadding.h,
                    )
                  ],
                  if ((controller.packageInfoModel.value.data?.newSubscriber
                                  ?.newSubscriberStatus ??
                              0) ==
                          0 &&
                      !controller.isLoading.value) ...[
                    SubscriptionCard(
                      isYearly: false,
                      onSubscribe: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: "Confirm Subscription",
                              //  subtitle: "Unlock Lifetime Access! 🚀",
                              description:
                                  "Subscribe now & enjoy yearly access for payment of Tk ${controller.packageInfoModel.value.data?.newSubscriber?.newSubscriberAmount ?? ""}",
                              icon: Icon(
                                Icons.verified,
                                color: AppColors.success,
                                size: 40.sp,
                              ),
                              confirmButtonText: "Subscribe Now",
                              confirmButtonColor: AppColors.primaryColor,
                              cancelButtonText: "Maybe Later",
                              cancelButtonColor: AppColors.danger,
                              onConfirmButtonPressed: () {
                                Get.back();
                                controller.newSubscribe(
                                    amount:
                                        "${controller.packageInfoModel.value.data?.newSubscriber?.newSubscriberAmount ?? ""}");
                              },
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: AppDimensions.contentPadding.h,
                    ),
                  ],
                  if ((controller.packageInfoModel.value.data?.yearlySubscriber
                              ?.yearlyPaymentStatus ??
                          0) ==
                      1) ...[
                    SubscriptionCard(
                      isYearly: true,
                      onSubscribe: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: "Yearly Subscription",
                              subtitle: "Get Full Access for a Year! 🎯",
                              description:
                                  "Unlock premium features and seamless case management with our yearly subscription. Pay just Tk ${controller.packageInfoModel.value.data?.yearlySubscriber?.yearlySubscriberAmount ?? ""} for an entire year of continuous service!",
                              icon: Icon(
                                Icons.workspace_premium,
                                color: AppColors.success,
                                size: 40.sp,
                              ),
                              confirmButtonText: "Subscribe Now",
                              confirmButtonColor: AppColors.primaryColor,
                              cancelButtonText: "Maybe Later",
                              cancelButtonColor: AppColors.danger,
                              onConfirmButtonPressed: () {
                                Get.back();
                                controller.yearlySubscribe(
                                    amount:
                                        "${controller.packageInfoModel.value.data?.newSubscriber?.newSubscriberAmount ?? ""}");
                              },
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: AppDimensions.contentPadding.h,
                    ),
                  ],
                  if (controller.isLoading.value) ...[
                    const ShimmerPackageInfoCard(),
                    SizedBox(
                      height: AppDimensions.contentPadding.h,
                    )
                  ],
                  SizedBox(
                    height: AppDimensions.widgetPadding -
                        AppDimensions.contentPadding.h,
                  ),
                  GridMenu(
                    items: [
                      MenuItemModel(icon: Icons.assignment, title: "Cases"),
                      MenuItemModel(
                          icon: Icons.calendar_month, title: "Calendar"),
                      MenuItemModel(icon: Icons.menu_book, title: "Books"),
                      MenuItemModel(icon: Icons.note, title: "Notes"),
                      MenuItemModel(
                        icon: Icons.privacy_tip,
                        title: "Privacy Policy",
                      ),
                      MenuItemModel(
                          icon: Icons.video_camera_back, title: "Video"),
                      MenuItemModel(
                          icon: Icons.support_agent, title: "Support"),
                      MenuItemModel(
                          icon: Icons.description, title: "User Guide"),
                      MenuItemModel(icon: Icons.language, title: "Website"),
                    ],
                    onItemTap: (index) {
                      controller.openTargetPage(index: index);
                    },
                  ),
                  SizedBox(
                    height: AppDimensions.sectionPadding * 5.h,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void showYearlyExpiredDialog(BuildContext context) {
    final amount = controller.packageInfoModel.value.data?.yearlySubscriber
            ?.yearlySubscriberAmount ??
        "";
    Get.dialog(
      PopScope(
        canPop: false,
        child: CustomDialog(
          title: "Subscription Expired",
          description: "Your annual subscription has expired.\n"
              "Please renew your subscription to maintain full access to the system.",

          /// 👇 Highlight Section
          otherInfo: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 12.w,
            ),
            margin: EdgeInsets.only(top: 8.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(.08),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.primaryColor.withOpacity(.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Amount Payable",
                    style: AppTextStyles.header(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "৳$amount / Year",
                  style: AppTextStyles.title(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          icon: Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
            size: 40.sp,
          ),

          confirmButtonText: "Subscribe Now",
          confirmButtonColor: AppColors.primaryColor,

          cancelButtonText: "Cancel",
          cancelButtonColor: AppColors.danger,

          /// Subscribe
          onConfirmButtonPressed: () {
            Get.back();
            controller.yearlySubscribe(amount: "$amount");
          },

          /// Cancel
          onCancelButtonPressed: () {
            Future.delayed(const Duration(milliseconds: 300), () {
              SystemNavigator.pop();
            });
          },
        ),
      ),
      barrierDismissible: false,
    );
  }

  void showYearlyExpiredWarningDialog(BuildContext context) {
    final amount = controller.packageInfoModel.value.data?.yearlySubscriber
            ?.yearlySubscriberAmount ??
        "";
    Get.dialog(
      PopScope(
        canPop: false,
        child: CustomDialog(
          title: "Subscription Expiry Alert",
          descriptionWidget: RichText(
            text: TextSpan(
              style: AppTextStyles.body(),
              children: [
                const TextSpan(
                  text: "Your annual subscription will expire ",
                ),
                TextSpan(
                  text: controller.packageInfoModel.value.data?.yearlySubscriber
                          ?.yearlyPaymentDate ??
                      "soon",
                  style: AppTextStyles.body(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      ".\nPlease renew your subscription before the due date to avoid any interruption in accessing services.",
                ),
              ],
            ),
          ),

          /// 👇 Highlight Section
          otherInfo: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 12.w,
            ),
            margin: EdgeInsets.only(top: 8.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(.08),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.primaryColor.withOpacity(.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Amount Payable",
                    style: AppTextStyles.header(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "৳$amount / Year",
                  style: AppTextStyles.title(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          icon: Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
            size: 40.sp,
          ),

          confirmButtonText: "Subscribe Now",
          confirmButtonColor: AppColors.primaryColor,

          cancelButtonText: "Cancel",
          cancelButtonColor: AppColors.danger,

          /// Subscribe
          onConfirmButtonPressed: () {
            Get.back();
            controller.yearlySubscribe(amount: "$amount");
          },

          /// Cancel
          onCancelButtonPressed: () {
            controller.cancelDialogue.value=true;
            Get.back();
          },
        ),
      ),
      barrierDismissible: false,
    );
  }
}
