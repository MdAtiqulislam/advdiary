import 'package:get/get.dart';

import '../controllers/video_list_controller.dart';

class VideoListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoListController>(
      () => VideoListController(),
    );
  }
}
