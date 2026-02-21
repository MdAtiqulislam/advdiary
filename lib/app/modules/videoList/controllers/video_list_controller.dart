import 'package:advdiary/app/modules/videoList/models/video_list_model.dart';
import 'package:get/get.dart';

import '../../../../constraints/api_endpoints.dart';
import '../../../../models/single_video_model.dart';
import '../../../../services/remote_services.dart';
import '../../../../utils/utils.dart';

class VideoListController extends GetxController {
  var showDrawerButton = false.obs;
  var videoListModel = VideoListModel().obs;
  var videoList=<SingleVideo>[].obs;

  var isLoading = false.obs;

  var loadingMore = false.obs;

  @override
  Future<void> onInit() async {
    updateStatusBar();
    await getVideos();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getVideos() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getVideoList;
    videoList.value = [];
      try {
        var response = await RemoteServices.getRequest(
            endPoint: endPoint);
        if (response != null) {
          videoListModel.value = VideoListModel.fromJson(response);
          videoList.value = videoListModel.value.data ?? [];

            }
      } finally {
       isLoading.value=false;
      }

  }

  void loadMore({required String url}) async {
    loadingMore.value = true;
    try {
      await RemoteServices.getRequestLoadMore(url: url).then((value) {
        if (value != null) {
          videoListModel.value = VideoListModel.fromJson(value);
          videoList.value += videoListModel.value.data ?? [];
        }
      });
    } finally {
      loadingMore.value = false;
    }
  }
}
