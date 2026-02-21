import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/constraints/app_strings.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme/app_text_styles.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:CustomBody(
          child: Obx(()=> Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(child: Image.asset(AppImagePath.appLogo,scale: 2,)),
              if(controller.isLoading.value) Text( "Please Wait",style: AppTextStyles.header(),),
            ],),),
        ),
      ),
    );
  }
}
