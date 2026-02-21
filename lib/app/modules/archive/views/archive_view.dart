import 'package:advdiary/app/modules/archive/views/archive_case_list_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/empty_screen.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../common_widgets/pagination_side_menu.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../utils/download_controller.dart';
import '../../../routes/app_pages.dart';
import '../../app_bar/custom_app_bar.dart';
import '../../bottom_navigation_bar/custom_bottom_nav_bar.dart';
import '../../caseDetails/controllers/case_details_controller.dart';
import '../../caseList/views/single_case_card.dart';
import '../controllers/archive_controller.dart';

class ArchiveView extends GetView<ArchiveController> {
   ArchiveView({super.key});

   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   final ScrollController _scrollController = ScrollController();
   final downloadController=Get.put(DownloadsController());

  @override
  Widget build(BuildContext context) {

    _scrollController.addListener(() {
      loadMoreData();
    });


    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: "Archive List",
          scaffoldKey: _scaffoldKey,
          showDrawerButton: controller.showDrawerButton.value,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: Obx(
                () => Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: AppDimensions.widgetPadding.h,),
                    const ArchiveCaseListFilter(),
                    SizedBox(height: AppDimensions.contentPadding.h,),
                    Expanded(
                      child: bodyContent(),
                    ),
                  ],
                ),
                Container(
                  height: Get.height,
                ),
                if (controller.archiveList.isNotEmpty)
                  PaginationSideMenu(
                    isExpanded: controller.openPaginationSlider,
                    pagination: controller.archiveModel.value.pagination,
                    pdfDownloadLink: controller.archiveModel.value.pdfDownloadLink??"",
                    exelDownloadLink: controller.archiveModel.value.excelDownloadLink??"",
                  ),
                if (controller.isLoading.value) const LoadingScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }


   Widget bodyContent() {
     return (controller.archiveList).isEmpty
         ? Padding(
       padding: EdgeInsets.only(top: AppDimensions.sectionPadding.h),
       child: const EmptyScreen(title: "No data found!"),
     )
         : CustomScrollView(
       controller: _scrollController,
       slivers: [
         SliverToBoxAdapter(
           child: Padding(
             padding: EdgeInsets.symmetric(
                 horizontal: AppDimensions.horizontalPadding.w),
           ),
         ),
         SliverList(
           delegate: SliverChildBuilderDelegate(
               childCount: controller.archiveList.length,
                   (buildContext, index) {
                 return SingleCaseCard(
                   caseModel: controller.archiveList.value[index],
                  // isButtonEnable: controller.getButtonEnableStatue(),
                   onDetails: () async {
                     Get.put(CaseDetailsController());
                     Get.find<CaseDetailsController>().getCaseDetails(
                         caseId:
                         (controller.archiveList.value[index].id).toString());
                     await Get.toNamed(Routes.CASE_DETAILS)?.then((value){
                       controller.getDataArchiveData();
                     });
                   },
                   onDownloads: () {

                     print(controller.archiveList.value[index]
                         .caseDetailsPdfDownloadLink);

                     downloadController.downloadFile(
                         fileUrl: controller.archiveList.value[index]
                             .caseDetailsPdfDownloadLink ??
                             "");
                   },
                 );
               }),
         ),
         if (controller.loadingMore.value)
           const SliverToBoxAdapter(
             child: Center(
               child: Padding(
                 padding: EdgeInsets.all(8.0),
                 child: CircularProgressIndicator(),
               ),
             ),
           ),
         SliverToBoxAdapter(
           child: SizedBox(
             height: 100.h,
           ),
         )
       ],
     );
   }


   void loadMoreData() {
     // currentPosition.value=_scrollController.position.pixels;
     if (_scrollController.position.pixels ==
         _scrollController.position.maxScrollExtent) {
       if (controller.pagination.value.currentPage !=
           controller.pagination.value.lastPage &&
           !controller.loadingMore.value) {
         controller.loadMore(
           url: controller.pagination.value.nextPageUrl ?? "",
         );
       }
     }
   }
}
