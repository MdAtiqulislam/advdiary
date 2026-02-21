import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../bookDetails/controllers/book_details_controller.dart';
import '../controllers/books_controller.dart';

class BooksView extends GetView<BooksController> {
  BooksView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _getIconPath(int index) {
    final iconIndex = index % 10; // 0-9 repeat
    return "assets/moc_icons/moc_icons_$iconIndex.png";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(()=>Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: controller.currentTitle.value,
          scaffoldKey: _scaffoldKey,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        floatingActionButton: Obx(() {
          if (controller.level.value != BookLevel.books) {
            return FloatingActionButton(
              onPressed: controller.goBack,
              backgroundColor: AppColors.primaryColor,
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            );
          }
          return const SizedBox.shrink();
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: CustomBody(child: Obx(() {

          if (controller.isLoading.value) {
            return const LoadingScreen();
          }

          switch (controller.level.value) {
            case BookLevel.books:
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: controller.books.length,
                itemBuilder: (context, index) {
                  final book = controller.books[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    margin:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      leading: Image.asset(
                        _getIconPath(index),
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                      title: Text(
                        book.heading ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.grey,
                      ),
                      onTap: () => controller.openChapters(book),
                    ),
                  );
                },
              );

            case BookLevel.chapters:
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: controller.selectedChapters.length,
                itemBuilder: (context, index) {
                  final chapter = controller.selectedChapters[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    margin:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      leading: Image.asset(
                        _getIconPath(index),
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                      title: Text(
                        chapter.title ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.grey,
                      ),
                      onTap: () => controller.openSubChapters(chapter),
                    ),
                  );
                },
              );

            case BookLevel.subchapters:
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: controller.selectedSubChapters.length,
                itemBuilder: (context, index) {
                  final sub = controller.selectedSubChapters[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    margin:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      leading: Image.asset(
                        _getIconPath(index),
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                      title: Text(
                        sub.title ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        Get.put(BookDetailsController()).title.value=sub.title??"";
                        Get.find<BookDetailsController>().initialUrl=sub.urlLink??"";
                        Get.toNamed(Routes.BOOK_DETAILS,);
                      },
                    ),
                  );
                },
              );
          }
        })),
      ),)
    );
  }
}
