import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
   PrivacyPolicyView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // total tabs
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar:  CustomAppBar(title: "Privacy Policy",scaffoldKey: _scaffoldKey,),
          bottomNavigationBar: CustomBottomNavigationBar(),
          drawer: MyDrawer(),
          body: Column(
            children: [
              // TabBar placed manually under CustomAppBar
              Container(
                color: Theme.of(context).primaryColor,
                child: const TabBar(
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  isScrollable: false, // full width equal share
                  // 🔑 Default padding override
                  labelPadding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  tabs: [
                    Tab(
                      child: Text(
                        "Terms & Condition",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                    Tab(
                      child: Text(
                        "FAQs",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Return Policy",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              )
              ,



              // Expanded TabBarView
              Expanded(
                child: CustomBody(
                  child: Obx(() {
                    final data = controller.privacyPolicyData.value.data;
                    if (data == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return TabBarView(
                      physics: const NeverScrollableScrollPhysics(), // 🔒 Swipe disable
                      children: [
                        _PdfViewerTab(url: data.termsCondition ?? ""),
                        _PdfViewerTab(url: data.faqSupport ?? ""),
                        _PdfViewerTab(url: data.returnPolicy ?? ""),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PdfViewerTab extends StatelessWidget {
  final String url;
  const _PdfViewerTab({required this.url});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return const Center(child: Text("No PDF available"));
    }

    return SfPdfViewer.network(url);
  }
}
