import 'dart:io';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../app/routes/app_pages.dart';
import '../common_widgets/custom_drawer_button.dart';
import '../controllers/my_drawer_controller.dart';
import '../theme/app_colors.dart';
import '../utils/utils.dart';
import 'custom_circle_avatar.dart';
import 'custom_loading_screen.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final MyDrawerController controller = Get.put(MyDrawerController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Stack(
            children: [
              Drawer(
                backgroundColor: Colors.white,
                width:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? Get.width * 0.8
                        : Get.width * 0.5,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ Updated Profile Section (centered)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.horizontalPadding.w,
                            vertical: AppDimensions.verticalPadding.h),
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(28.r),
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.primaryColor.withOpacity(.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(.18),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            /// TOP SECTION
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// PROFILE IMAGE
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  child: CustomCircleAvatar(
                                    width: 90,
                                    height: 90,
                                    image:
                                        controller.userData.value.userImage ??
                                            '',
                                    fit: BoxFit.cover,
                                    bgColor: Colors.white.withOpacity(.15),
                                  ),
                                ),

                                SizedBox(width: 14.w),

                                /// USER INFO
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// NAME + EDIT
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              controller.userData.value.name ??
                                                  "User Name",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles.header(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                resizeAble: false,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            onTap: () {
                                              Get.back();
                                              Get.toNamed(Routes.EDIT_PROFILE);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(.15),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 8.h),

                                      /// EMAIL
                                      Row(
                                        children: [
                                          const Icon(Icons.email_outlined,
                                              color: Colors.white70, size: 16),
                                          SizedBox(width: 6.w),
                                          Expanded(
                                            child: Text(
                                              controller.userData.value.email ??
                                                  "",
                                              style: AppTextStyles.body(
                                                color: Colors.white70,
                                                resizeAble: false,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 4.h),

                                      /// PHONE
                                      Row(
                                        children: [
                                          const Icon(Icons.call_outlined,
                                              color: Colors.white70, size: 16),
                                          SizedBox(width: 6.w),
                                          Text(
                                            controller.userData.value.phone ??
                                                "",
                                            style: AppTextStyles.body(
                                              color: Colors.white70,
                                              resizeAble: false,
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 4.h),

                                      /// LOCATION
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on_outlined,
                                              color: Colors.white70, size: 16),
                                          SizedBox(width: 6.w),
                                          Expanded(
                                            child: Text(
                                              controller.districtList
                                                      .firstWhereOrNull(
                                                        (d) =>
                                                            d.id.toString() ==
                                                            controller
                                                                .userData
                                                                .value
                                                                .districtId
                                                                .toString(),
                                                      )
                                                      ?.name ??
                                                  "",
                                              style: AppTextStyles.body(
                                                color: Colors.white70,
                                                resizeAble: false,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: AppDimensions.widgetPadding.h),

                            /// WHITE INFO CARD
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppDimensions.horizontalPadding.w,
                                  vertical: AppDimensions.verticalPadding.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.borderRadius.r),
                              ),
                              child: Column(
                                children: [
                                  /// REG DATE
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today,
                                          size: 16.sp,
                                          color: AppColors.primaryColor),
                                      SizedBox(
                                          width:
                                              AppDimensions.contentPadding.w),
                                      Expanded(
                                        child: Text(
                                          "Reg. Date: ${formatDate(controller.userData.value.regDate, format: "dd MMM yyyy")}",
                                          style: AppTextStyles.body(
                                            resizeAble: false,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  /// SUBSCRIPTION
                                  if ((controller.newSubscription.value
                                              .newSubscriptionDate ??
                                          "")
                                      .isNotEmpty)
                                    Container(
                                      margin: EdgeInsets.only(top: AppDimensions.widgetPadding.h),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 10.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.danger.withOpacity(.08),
                                        borderRadius: BorderRadius.circular(
                                            AppDimensions.borderRadius.r),
                                        border: Border.all(
                                          color:
                                              AppColors.danger.withOpacity(.3),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.workspace_premium,
                                            color: AppColors.danger,
                                            size: 18.sp,
                                          ),
                                          SizedBox(width: AppDimensions.contentPadding.w),
                                          Expanded(
                                            child: Text(
                                              "Subscription Date: ${formatDate(controller.newSubscription.value.newSubscriptionDate, format: "dd MMM yyyy")}",
                                              style: AppTextStyles.body(
                                                resizeAble: false,
                                                color: AppColors.danger,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ✅ Account Section
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                            horizontal: AppDimensions.horizontalPadding.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle("Account"),
                            CustomDrawerButton(
                              onTap: () =>
                                  Get.offAndToNamed(Routes.RESET_PASSWORD),
                              imageIcon: "",
                              icon: Icon(
                                Icons.vpn_key_outlined,
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              text: "Change Password",
                            ),
                            CustomDrawerButton(
                              onTap: () {
                                Get.back();
                                Get.toNamed(
                                  Routes.PACKAGES,
                                );
                              },
                              imageIcon: "",
                              icon: Icon(
                                Icons.workspace_premium_outlined,
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              text: "Package Upgrade",
                            ),
                            const Divider(),
                            _sectionTitle("Report"),
                            CustomDrawerButton(
                              onTap: () {
                                Get.back();
                                Get.toNamed(Routes.PAYMENT_REPORT);
                              },
                              imageIcon: "",
                              icon: Icon(
                                Icons.receipt_long,
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              text: "Payment Report",
                            ),
                            CustomDrawerButton(
                              onTap: () => Get.toNamed(Routes.CASE_REPORT),
                              imageIcon: "",
                              icon: Icon(
                                Icons.report,
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              text: "Court Report",
                            ),
                            CustomDrawerButton(
                              onTap: () => Get.toNamed(Routes.ARCHIVE),
                              imageIcon: "",
                              icon: Icon(
                                Icons.archive_outlined,
                                // ✅ Relevant & standard archive icon
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              text: "Archive",
                            ),
                            const Divider(),
                            // ✅ App Features Section
                            _sectionTitle("Features"),
                            CustomDrawerButton(
                              onTap: () =>
                                  Get.toNamed(Routes.FIXED_FOR_SETTING),
                              imageIcon: "",
                              icon: Icon(
                                Icons.route_outlined,
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              text: "Fixed For/Step Settings",
                            ),
                            CustomDrawerButton(
                              onTap: () => Get.toNamed(Routes.CASE_CATEGORY),
                              imageIcon: "",
                              icon: Icon(
                                Icons.settings,
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              text: "Category Settings",
                            ),
                            CustomDrawerButton(
                              onTap: () {
                                Get.back();
                                Get.toNamed(Routes.SUPPORT_TOKEN);
                              },
                              imageIcon: "",
                              icon: Icon(
                                Icons.support_agent,
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              text: "Support Token",
                            ),
                            CustomDrawerButton(
                              onTap: () {
                                Get.back();
                                //Get.toNamed(Routes.VIDEO_PLAYER);
                                Get.toNamed(Routes.VIDEO_LIST);
                              },
                              imageIcon: "",
                              icon: Icon(
                                Icons.ondemand_video_outlined,
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              text: "Video Tutorial",
                            ),
                            CustomDrawerButton(
                              onTap: () => controller.openWebLink(),
                              imageIcon: "",
                              icon: Icon(
                                Icons.language,
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              text: "WebLink",
                            ),
                            const Divider(),
                            _sectionTitle("Privacy Policy"),
                            CustomDrawerButton(
                              onTap: () =>
                                  Get.offAndToNamed(Routes.FAQ_AND_SUPPORT),
                              imageIcon: "", // still required
                              icon: Icon(
                                Icons.help_outline,
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              text: "FAQ & Support",
                            ),
                            CustomDrawerButton(
                              onTap: () => Get.offAndToNamed(
                                  Routes.TERMS_AND_CONDITIONS),
                              imageIcon: "",
                              // still required
                              icon: Icon(
                                Icons.gavel,
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              // Logical icon
                              text: "Terms and Conditions",
                            ),
                            CustomDrawerButton(
                              onTap: () =>
                                  Get.offAndToNamed(Routes.RETURN_POLICY),
                              imageIcon: "",
                              // still required
                              icon: Icon(
                                Icons.assignment_return,
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              // Logical icon
                              text: "Return Policy",
                            ),
                            CustomDrawerButton(
                              onTap: () {
                                Get.back();
                                Get.toNamed(Routes.USER_GUIDE);
                              },
                              imageIcon: "",
                              icon: Icon(
                                Icons.menu_book_outlined,
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              // 📖 Book icon for guide
                              text: "User Guide",
                            ),
                            const Divider(),
                            _sectionTitle("System"),
                            CustomDrawerButton(
                              onTap: () => controller.logOut(),
                              imageIcon: "",
                              icon: Icon(
                                Icons.logout,
                                size: AppDimensions.iconSizeSmall.sp,
                              ),
                              text: "Log Out",
                            ),
                            if (Platform.isIOS)
                              CustomDrawerButton(
                                onTap: () {},
                                imageIcon: "",
                                icon: Icon(
                                  Icons.delete_forever,
                                  size: AppDimensions.iconSizeSmall.sp,
                                ),
                                text: "Delete Account",
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // ✅ Loading Screen
              if (controller.isLoading.value) const LoadingScreen(),
            ],
          ),
        ));
  }

  /// 🧾 Section Title Widget
  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}
