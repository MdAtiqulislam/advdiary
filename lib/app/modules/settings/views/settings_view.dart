import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/custom_drawer_button.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
   SettingsView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar:  CustomAppBar(
          title: "Settings",
          scaffoldKey: _scaffoldKey,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
            child: Column(
              children: [
                SizedBox(height: AppDimensions.sectionPadding.h,),
                CustomDrawerButton(
                    onTap: () {
                      // Get.put(VideoTutorialController()).fetchData();
                      Get.back();
                      Get.toNamed(Routes.SUPPORT_TOKEN);
                    },
                    imageIcon: "",
                    icon: Icon(Icons.support),
                    text: "Support Token"),

                CustomDrawerButton(
                    onTap: (){
                      Get.toNamed(Routes.COURT_SETTING);
                    },
                    imageIcon: "",
                    text: "Court Settings",
                  icon: const Icon(Icons.brightness_low_outlined),

                ) ,
                CustomDrawerButton(
                    onTap: (){
                      Get.toNamed(Routes.FIXED_FOR_SETTING);
                    },
                    imageIcon: "",
                    text: "Fixed For/Step Settings",
                  icon: const Icon(Icons.start),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
