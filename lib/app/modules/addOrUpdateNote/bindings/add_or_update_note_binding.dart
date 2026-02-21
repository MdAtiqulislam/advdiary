import 'package:get/get.dart';

import '../controllers/add_or_update_note_controller.dart';

class AddOrUpdateNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddOrUpdateNoteController>(
      () => AddOrUpdateNoteController(),
    );
  }
}
