import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_colors.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/download_controller.dart';

/// Token item card with optional file and comment functionality
class TokenItem extends StatelessWidget {
  final String date;           // Token date
  final String tokenNo;        // Token number
  final String tokenText;      // Token description text
  final String? fileUrl;       // Optional file URL
  final int commentCount;      // Number of comments
  final VoidCallback? onAddComment; // Callback when Add Comment pressed

   TokenItem({
    super.key,
    required this.date,
    required this.tokenNo,
    required this.tokenText,
    this.fileUrl,
    this.commentCount = 0,
    this.onAddComment,
  });

  bool get isImage {
    if (fileUrl == null) return false;
    final ext = fileUrl!.toLowerCase();
    return ext.endsWith('.png') || ext.endsWith('.jpg') || ext.endsWith('.jpeg');
  }

  var downloadController=Get.put(DownloadsController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Token Number and Date Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tokenNo,
                    style: AppTextStyles.header(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    date,
                    style: AppTextStyles.body(
                    ),
                  ),
                ],
              ),
               SizedBox(height: AppDimensions.contentPadding.h),

              /// 🔹 Token Text / Description
              Text(
                tokenText,
                style:  AppTextStyles.header(
                ),
              ),

              /// 🔹 File Preview Section
              if (fileUrl != null && fileUrl!.isNotEmpty) ...[
                const SizedBox(height: 8),
                _buildFilePreview(context),
              ],

              /// 🔹 Comment Section (Count + Add Comment Button)
              if (onAddComment != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    /// Comment Count
                   if(commentCount>0)...[ Icon(Icons.comment, size: 16, color: Colors.grey.shade600),
                     const SizedBox(width: 4),
                     Text(
                       "$commentCount Unread",
                       style: const TextStyle(
                         fontSize: 13,
                         color: Colors.red,
                       ),
                     ),],
                    const Spacer(),

                    /// Add Comment Button
                    TextButton.icon(
                      onPressed: onAddComment,
                      icon: const Icon(Icons.add_comment, size: 16, color: Colors.blue),
                      label: const Text(
                        "Comment",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the file preview widget (icon/image + file name + download button)
  Widget _buildFilePreview(BuildContext context) {
    final fileName = fileUrl!.split('/').last; // Extract file name from URL
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
              fileUrl!,
              width: 40,
              height: 40,
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13),
            ),
          ),

          /// 🔹 Download Button
          IconButton(
            icon: const Icon(Icons.download, color: Colors.blue),
            onPressed: () {
              downloadController.downloadFile(fileUrl: fileUrl ?? "");
            },
          ),
        ],
      ),
    );
  }
}
