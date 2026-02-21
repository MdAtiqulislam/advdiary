import 'package:advdiary/app/modules/addOrUpdateNote/controllers/add_or_update_note_controller.dart';
import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/app/modules/notes/models/notes_model.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../controllers/notes_controller.dart';

class NotesView extends GetView<NotesController> {
  NotesView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: "My Notes",
          scaffoldKey: _scaffoldKey,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        floatingActionButton: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle,color: AppColors.primaryColor),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.put(AddOrUpdateNoteController()).resetValue();
              Get.toNamed(Routes.ADD_OR_UPDATE_NOTE);
            },

            icon: const Icon(
              Icons.add,
              color: Colors.white,
              // size: 36,
            ), // Makes sure it's circular
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.notes.isEmpty) {
            return const Center(child: Text("No notes available"));
          }
          return Stack(
            children: [
              CustomBody(
                child: ListView.builder(
                  itemCount: controller.notes.length,
                  itemBuilder: (context, index) {
                    final note = controller.notes[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Get.put(AddOrUpdateNoteController()).selectedNote = note;
                          Get.find<AddOrUpdateNoteController>().preloadData();
                          Get.toNamed(Routes.ADD_OR_UPDATE_NOTE);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 📝 Icon or leading indicator
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.note, color: Colors.blue),
                            ),
                            const SizedBox(width: 12),

                            // 📄 Title & description
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note.title ?? "Untitled",
                                    style: AppTextStyles.title().copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    note.description ?? "No description",
                                    style: AppTextStyles.body().copyWith(
                                      color: Colors.grey.shade700,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),

                            // 🗑️ Delete button with confirm dialog
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              tooltip: "Delete Note",
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text("⚠️ Warning!"),
                                    content: const Text("Are you sure you want to delete this note?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(ctx).pop(false),
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(ctx).pop(true),
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  controller.removeNote(id: note.id.toString());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if(controller.isReLoading.value)const LoadingScreen()
            ],
          );


        }),
      ),
    );
  }
}
