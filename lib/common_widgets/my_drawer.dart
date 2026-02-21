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
            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? Get.width * 0.8
                : Get.width * 0.5,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Updated Profile Section (centered)
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomCircleAvatar(
                              width: 100,
                              height: 100,
                              image: controller.userData.value.userImage ?? '',
                              bgColor: AppColors.primaryColor.withAlpha((0.2*254).toInt()),
                              fit: BoxFit.cover,
                            ),
                            Expanded(child: Align(
                              alignment: Alignment.topRight,
                              child:  IconButton(
                                icon: const Icon(Icons.edit, color: AppColors.primaryColor, size: 20),
                                onPressed: () {
                                  Get.back();
                                  Get.toNamed(Routes.EDIT_PROFILE);
                                },
                              ),
                            ),)
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                           controller.userData.value.name ?? "User Name",
                          textAlign: TextAlign.center,
                         style: AppTextStyles.header( color: AppColors.primaryColor,
                           resizeAble: false,),
                        ),
                        SizedBox(height: 4.h),
                        Text( controller.userData.value.email ?? "",style: AppTextStyles.body(resizeAble: false),),
                        Text( controller.userData.value.phone ?? "",style: AppTextStyles.body(resizeAble: false),),
                        Text(
                           controller.districtList
                              .firstWhereOrNull((d) => d.id.toString() == controller.userData.value.districtId.toString())
                              ?.name ??
                              "",
                          style: AppTextStyles.body(resizeAble: false),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),

                  // ✅ Account Section
                  _sectionTitle("Account"),
                  CustomDrawerButton(
                    onTap: () => Get.offAndToNamed(Routes.RESET_PASSWORD),
                    imageIcon: "",
                    icon:  Icon(Icons.vpn_key_outlined,size: AppDimensions.iconSizeSmall.sp,),
                    text: "Change Password",
                  ),
                  CustomDrawerButton(
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.PACKAGES,);
                    },
                    imageIcon: "",
                    icon:  Icon(Icons.workspace_premium_outlined,size: AppDimensions.iconSizeSmall.sp,),
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
                    icon:  Icon(Icons.receipt_long,size: AppDimensions.iconSizeSmall.sp,),
                    text: "Payment Report",
                  ),
                  CustomDrawerButton(
                    onTap: () => Get.toNamed(Routes.CASE_REPORT),
                    imageIcon: "",
                    icon:  Icon(Icons.report,size: AppDimensions.iconSizeSmall.sp,),
                    text: "Court Report",
                  ),
                  CustomDrawerButton(
                    onTap: () => Get.toNamed(Routes.ARCHIVE),
                    imageIcon: "",
                    icon: Icon(
                      Icons.archive_outlined, // ✅ Relevant & standard archive icon
                      size: AppDimensions.iconSizeSmall.sp,
                    ),
                    text: "Archive",
                  ),

                  const Divider(),
                  // ✅ App Features Section
                  _sectionTitle("Features"),
                  CustomDrawerButton(
                    onTap: () => Get.toNamed(Routes.FIXED_FOR_SETTING),
                    imageIcon: "",
                    icon:  Icon(Icons.route_outlined,size: AppDimensions.iconSizeSmall.sp,),
                    text: "Fixed For/Step Settings",
                  ),
                  CustomDrawerButton(
                    onTap: () => Get.toNamed(Routes.CASE_CATEGORY),
                    imageIcon: "",
                    icon:  Icon(Icons.settings,size: AppDimensions.iconSizeSmall.sp,),
                    text: "Category Settings",
                  ),
                  CustomDrawerButton(
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.SUPPORT_TOKEN);
                    },
                    imageIcon: "",
                    icon:  Icon(Icons.support_agent,size: AppDimensions.iconSizeSmall.sp,),
                    text: "Support Token",
                  ),

                  CustomDrawerButton(
                    onTap: () {
                      Get.back();
                      //Get.toNamed(Routes.VIDEO_PLAYER);
                      Get.toNamed(Routes.VIDEO_LIST);
                    },
                    imageIcon: "",
                    icon:  Icon(Icons.ondemand_video_outlined,size: AppDimensions.iconSizeSmall.sp,),
                    text: "Video Tutorial",
                  ),

                  CustomDrawerButton(
                    onTap: () => controller.openWebLink(),
                    imageIcon: "",
                    icon:  Icon(Icons.language,size: AppDimensions.iconSizeSmall.sp,),
                    text: "WebLink",
                  ),

                  const Divider(),
                  _sectionTitle("Privacy Policy"),

                  CustomDrawerButton(
                    onTap: () => Get.offAndToNamed(Routes.FAQ_AND_SUPPORT),
                    imageIcon: "", // still required
                    icon:  Icon(Icons.help_outline,size: AppDimensions.iconSizeSmall.sp,),
                    text: "FAQ & Support",
                  ),

                  CustomDrawerButton(
                    onTap: () => Get.offAndToNamed(Routes.TERMS_AND_CONDITIONS),
                    imageIcon: "", // still required
                    icon:  Icon(Icons.gavel,size: AppDimensions.iconSizeSmall.sp,), // Logical icon
                    text: "Terms and Conditions",
                  ),
                  CustomDrawerButton(
                    onTap: () => Get.offAndToNamed(Routes.RETURN_POLICY),
                    imageIcon: "", // still required
                    icon:  Icon(Icons.assignment_return,size: AppDimensions.iconSizeSmall.sp,), // Logical icon
                    text: "Return Policy",
                  ),

                  CustomDrawerButton(
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.USER_GUIDE);
                    },
                    imageIcon: "",
                    icon:  Icon(Icons.menu_book_outlined,size: AppDimensions.iconSizeSmall.sp,), // 📖 Book icon for guide
                    text: "User Guide",
                  ),

                  const Divider(),
                  // ✅ System Section
                  _sectionTitle("System"),
                  CustomDrawerButton(
                    onTap: () => controller.logOut(),
                    imageIcon: "",
                    icon:  Icon(Icons.logout,size: AppDimensions.iconSizeSmall.sp,),
                    text: "Log Out",
                  ),
                  if (Platform.isIOS)
                    CustomDrawerButton(
                      onTap: () {},
                      imageIcon: "",
                      icon:  Icon(Icons.delete_forever,size: AppDimensions.iconSizeSmall.sp,),
                      text: "Delete Account",
                    ),
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
