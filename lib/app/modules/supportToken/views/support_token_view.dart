/*
import 'package:advdiary/app/modules/supportToken/views/token_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../app_bar/custom_app_bar.dart';
import '../controllers/support_token_controller.dart';

class SupportTokenView extends GetView<SupportTokenController> {
  SupportTokenView({super.key}) {
    _scrollController.addListener(_onScroll);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
            () => Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            title: 'Support Token',
            scaffoldKey: _scaffoldKey,
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  /// 🧾 Token List
                  Expanded(
                    child: Obx(() {
                      if (controller.supportTokenList.isEmpty) {
                        return const Center(child: Text('No tokens found'));
                      }

                      return ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        padding: const EdgeInsets.all(16),
                        itemCount: controller.supportTokenList.length +
                            (controller.loadingMore.value ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == controller.supportTokenList.length) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final token = controller.supportTokenList[index];
                          return TokenItem(
                            date: token.date ?? '',
                            tokenNo: token.tokenNo ?? '',
                            tokenText: token.token ?? '',
                          );
                        },
                      );
                    }),
                  ),


                  /// ✏️ Token Input Section
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.tokenController,
                            decoration: InputDecoration(
                              hintText: 'Create new token...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) {
                              controller.createSupportToken();
                              scrollToBottom();
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.send, color: Colors.blue),
                          onPressed: () {
                            controller.createSupportToken();
                            scrollToBottom();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// ⏳ Overlay Loader
              if (controller.isLoading.value) const LoadingScreen(),
            ],
          ),
        ),
      ),
    );
  }
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      final pagination = controller.tokensModel.value.pagination;
      if (pagination?.currentPage != pagination?.lastPage &&
          !controller.loadingMore.value) {
        controller.loadMore(url: pagination?.nextPageUrl ?? '');
      }
    }
  }


  /// 🔽 Scroll to bottom (newest message)
  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0, // Because reverse: true
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
*/

import 'package:advdiary/app/modules/comments/controllers/comments_controller.dart';
import 'package:advdiary/app/modules/supportToken/views/token_item.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/custom_text_field.dart';
import '../../../../common_widgets/my_drawer.dart';
import '../../app_bar/custom_app_bar.dart';
import '../controllers/support_token_controller.dart';

class SupportTokenView extends GetView<SupportTokenController> {
  SupportTokenView({super.key}) {
    _scrollController.addListener(_onScroll);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            title: 'Support Token',
            scaffoldKey: _scaffoldKey,
          ),
          drawer: MyDrawer(),
          body: CustomBody(
            child: Stack(
              children: [
                Column(
                  children: [
                    /// Token List
                    Expanded(
                      child: Obx(() {
                        if (controller.supportTokenList.isEmpty) {
                          return const Center(child: Text('No tokens found'));
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          reverse: true,
                          padding: const EdgeInsets.all(16),
                          itemCount: controller.supportTokenList.length +
                              (controller.loadingMore.value ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == controller.supportTokenList.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }

                            final token = controller.supportTokenList[index];
                            return TokenItem(
                              date: token.date ?? '',
                              tokenNo: token.tokenNo ?? '',
                              tokenText: token.token ?? '',
                              fileUrl: token.downloadUrl,
                              commentCount: int.tryParse(
                                      (token.totalComment ?? 0).toString()) ??
                                  0,
                              onAddComment: () {
                                Get.put(CommentsController())
                                    .getSupportTokenDetails(
                                        id: token.id.toString());
                                Get.toNamed(Routes.COMMENTS);
                              },
                            );
                          },
                        );
                      }),
                    ),
                    _buildInputBar()
                  ],
                ),

                /// Loader
                if (controller.isLoading.value) const LoadingScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      final pagination = controller.tokensModel.value.pagination;
      if (pagination?.currentPage != pagination?.lastPage &&
          !controller.loadingMore.value) {
        controller.loadMore(url: pagination?.nextPageUrl ?? '');
      }
    }
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Input bar widget
  Widget _buildInputBar() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.05*254).toInt()),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          children: [
            /// File Preview (if any)
            Obx(() {
              final file = controller.selectedFile.value;
              if (file == null) return const SizedBox.shrink();
              final fileName = file.path.split('/').last;
              final isImage = fileName.toLowerCase().endsWith('.png') ||
                  fileName.toLowerCase().endsWith('.jpg') ||
                  fileName.toLowerCase().endsWith('.jpeg');

              return Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: isImage
                          ? Image.file(
                              file,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 40,
                              height: 40,
                              color: Colors.grey.shade400,
                              child: const Icon(Icons.insert_drive_file,
                                  color: Colors.white),
                            ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        fileName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:  AppTextStyles.header(fontSize: 13),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => controller.selectedFile.value = null,
                    ),
                  ],
                ),
              );
            }),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.blue),
                  onPressed: controller.pickFile,
                ),
                Expanded(
                  child: CustomTextField(
                    hintText: "Type a message...",
                    maxLine: 20,
                    minLine: 1,
                    controller: controller.tokenController,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.createSupportToken();
                    scrollToBottom();
                  },
                  icon: const Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
