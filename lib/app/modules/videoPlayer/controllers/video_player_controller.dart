import 'package:advdiary/models/single_video_model.dart';
import 'package:get/get.dart';

class VideoPlayerController extends GetxController {
  var isLoading = false.obs;

  var videoURL = "".obs;
  var video = SingleVideo().obs;

  @override
  void onInit() {
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

  getVideoUrl() {
    video.value.videoType == "youtube_link"
        ? videoURL.value = video.value.youtubeLink ?? ""
        : videoURL.value = video.value.uploadedVideo ?? "";
    print(videoURL);
  }
}
