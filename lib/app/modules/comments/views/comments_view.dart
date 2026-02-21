import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/custom_text_field.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/theme/app_colors.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/download_controller.dart';
import '../controllers/comments_controller.dart';

class CommentsView extends GetView<CommentsController> {
   CommentsView({super.key});

   var downloadController=Get.put(DownloadsController());

  final GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommentsController());

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar:  CustomAppBar(title: "Comments",scaffoldKey: _scaffoldKey,),
        drawer: MyDrawer(),
        body: CustomBody(
          child: Obx(() {
            if (controller.isLoading.value) return const LoadingScreen();

            return Stack(
              children: [
                Column(
                  children: [
                    /// 🔹 Post Section
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              controller.tokenDetails.value.data?.tokenData?.token ?? "",
                              style: AppTextStyles.header(color: AppColors.primaryColor),
                              maxLines: 5,
                            ),
                          ),
                        ),
                        if ((controller.tokenDetails.value.data?.tokenData?.downloadUrl ?? "").isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.download, color: Colors.blue),
                            onPressed: () {
                              final url = controller.tokenDetails.value.data?.tokenData?.downloadUrl ?? "";
                              if (url.isNotEmpty) downloadController.downloadFile(fileUrl: url);
                            },
                          ),
                      ],
                    ),
                    const Divider(),

                    /// 🔹 Chat / Comments list
                    Expanded(
                      child: Obx(() {
                        final comments = controller.comments;
                        if (comments.isEmpty) {
                          return _buildEmptyState();
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.all(12),
                          reverse: true, // latest comment at bottom
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final msg = comments[index];
                            final isMe = msg.userType?.toLowerCase() == "admin";
                            return _buildMessageBubble(context, msg.comment, msg.downloadUrl, isMe,msg.createdAt);
                          },
                        );
                      }),
                    ),

                    /// 🔹 Input bar
                    _buildInputBar(controller),
                  ],
                ),

                if (controller.isUpdating.value) const LoadingScreen(),
              ],
            );
          }),
        ),
      ),
    );
  }

  /// Empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 12),
          Text(
            "No conversation yet.\nStart the discussion!",
            textAlign: TextAlign.center,
            style: AppTextStyles.header(fontSize: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  /// Message Bubble widget
  Widget _buildMessageBubble(
      BuildContext context, String? text, String? file, bool isMe, String? createdAt) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // 🔹 File Section
            if (file != null && file.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildFilePreview(context,file),
            ],


            // 🔹 Text Section
            if (text != null && text.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: file != null ? 8 : 0),
                child: Text(
                  text,
                  style: AppTextStyles.body(
                    color: isMe ? Colors.white : Colors.black,
                  ),
                ),
              ),

            // 🔹 Time Section
            if (createdAt != null && createdAt.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  createdAt,
                  style: AppTextStyles.body(
                    fontSize: 12,
                    color: isMe ? Colors.white70 : Colors.black54,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Input bar widget
  Widget _buildInputBar(CommentsController controller) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
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
                        style: AppTextStyles.body(),
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
                    controller: controller.commentController,
                  ),
                ),
                IconButton(
                  onPressed: controller.addComment,
                  icon: const Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

   Widget _buildFilePreview(BuildContext context,String? file) {
     bool  isImage =false;

       if(file!=null){
         final ext = file.toLowerCase();
         isImage= ext.endsWith('.png') || ext.endsWith('.jpg') || ext.endsWith('.jpeg');
       }

     final fileName = file!.split('/').last; // Extract file name from URL
     return Container(
       padding: const EdgeInsets.all(6),
       decoration: BoxDecoration(
         color: Colors.grey.shade200,
         borderRadius: BorderRadius.circular(8),
       ),
       child: Row(
         children: [
           /// 🔹 File Icon or Image Preview
           ClipRRect(
             borderRadius: BorderRadius.circular(6),
             child: isImage
                 ? Image.network(
               file,
               width: 60,
               height: 60,
               fit: BoxFit.cover,
             )
                 : Container(
               width: 40,
               height: 40,
               color: Colors.grey.shade400,
               child: const Icon(Icons.insert_drive_file, color: Colors.white),
             ),
           ),
           const SizedBox(width: 8),

           /// 🔹 File Name
           Expanded(
             child: Text(
               fileName,
               maxLines: 2,
               overflow: TextOverflow.ellipsis,
               style: AppTextStyles.body(),
             ),
           ),

           /// 🔹 Download Button
           IconButton(
             icon: const Icon(Icons.download, color: Colors.blue),
             onPressed: () {
               downloadController.downloadFile(fileUrl: file ?? "");
             },
           ),
         ],
       ),
     );
   }
}
