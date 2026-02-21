import 'package:advdiary/app/modules/videoList/views/video_card_item.dart';
import 'package:advdiary/app/modules/videoPlayer/controllers/video_player_controller.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/empty_screen.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../../../constraints/dimensions.dart';
import '../../app_bar/custom_app_bar.dart';
import '../../bottom_navigation_bar/custom_bottom_nav_bar.dart';
import '../controllers/video_list_controller.dart';

class VideoListView extends GetView<VideoListController> {
  VideoListView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      loadMoreData();
    });

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: "Video Tutorials",
          scaffoldKey: _scaffoldKey,
          showDrawerButton: controller.showDrawerButton.value,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: Obx(
            () => controller.isLoading.value
                ? const LoadingScreen()
                : bodyContent(),
          ),
        ),
      ),
    );
  }

  void loadMoreData() {
    // currentPosition.value=_scrollController.position.pixels;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (controller.videoListModel.value.pagination?.currentPage !=
              controller.videoListModel.value.pagination?.lastPage &&
          !controller.loadingMore.value) {
        controller.loadMore(
          url: controller.videoListModel.value.pagination?.nextPageUrl ?? "",
        );
      }
    }
  }

  bodyContent() {
    return (controller.videoList).isEmpty
        ? Padding(
            padding: EdgeInsets.only(top: AppDimensions.sectionPadding.h),
            child: const EmptyScreen(title: "No data found!"),
          )
        : Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
          child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppDimensions.contentPadding.h),
                  ),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      childCount: controller.videoList.length,
                      (buildContext, index) {
                    return VideoCardItem(
                       title: controller.videoList[index].title??"",
                      imageUrl: controller.videoList[index].getThumbnailUrl()??"",
                      duration: controller.videoList[index].timeDuration??"",
                      onTap: (){
                         Get.put(VideoPlayerController()).video.value=controller.videoList[index];
                         Get.find<VideoPlayerController>().getVideoUrl();
                         Get.toNamed(Routes.VIDEO_PLAYER);
                      },
                    );
                  }),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                    childAspectRatio: .7,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10
                  ),
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
            ),
        );
  }
}
