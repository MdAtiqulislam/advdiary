import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/app/modules/commingSoon/controllers/comming_soon_controller.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';

class ComingSoonView extends GetView<ComingSoonController> {
   ComingSoonView({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key:_scaffoldKey,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: controller.title,scaffoldKey: _scaffoldKey,),
        bottomNavigationBar: CustomBottomNavigationBar(),
        drawer: MyDrawer(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// 🕒 Clock / Hourglass Icon
                Icon(
                  Icons.hourglass_empty_rounded,
                  size: 100,
                  color: Colors.blueGrey.shade400,
                ),
                const SizedBox(height: 30),
      
                /// 📝 Title
                Text(
                  "Coming Soon",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
                const SizedBox(height: 12),
      
                /// 📄 Subtitle
                Text(
                  "We are working hard to bring this feature for you.\nStay tuned for updates!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 40),
      
                /// ⏳ Progress Indicator

      
                /// 🔙 Back Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Back",style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: AppColors.primaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
