import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_body.dart';
import '../controllers/faq_and_support_controller.dart';

class FaqAndSupportView extends GetView<FaqAndSupportController> {
   FaqAndSupportView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(title: "FAQ & Support",scaffoldKey: _scaffoldKey,),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: Obx(()=> controller.isLoading.value
              ?const LoadingScreen()
             :  const PDF().fromUrl(
            controller.faqData.value.data?.faqFile??"",
            placeholder: (progress) => Center(child: Text('$progress %')),
            errorWidget: (error) => const Center(child: Text('Failed to load PDF')),
          ),

            /*LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight,
                  maxWidth: constraints.maxWidth,
                ),
                child: const PDF().fromUrl(
                 controller.faqData.value.data?.faqFile??"",
                  placeholder: (progress) => Center(child: Text('$progress %')),
                  errorWidget: (error) => const Center(child: Text('Failed to load PDF')),
                ),
              );
            },
          )*/
          ),
        ),
      ),
    );
  }
}
