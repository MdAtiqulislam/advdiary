/*
import 'package:advdiary/app/modules/caseList/models/case_list_model.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../utils/download_document.dart';
import 'custom_clipper.dart';

class PaginationSideMenu extends StatelessWidget {
  final RxBool isExpanded;
  final Rx<CaseListModel> caseListModel;
  final double menuWidth;
  final double bottomOffset;

  const PaginationSideMenu({
    super.key,
    required this.isExpanded,
    required this.caseListModel,
    this.menuWidth = 220,
    this.bottomOffset = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        left: isExpanded.value ? 0 : -menuWidth.w,
        bottom: bottomOffset.h,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- Main Menu ---
              Container(
                width: menuWidth.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.95),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppDimensions.borderMedium.r),
                    bottomRight: Radius.circular(AppDimensions.borderMedium.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [



                      // Cases Count
                      Text(
                        (caseListModel.value.pagination?.currentPage ?? 0) ==
                            (caseListModel.value.pagination?.lastPage ?? 0)
                            ? "📂 Cases: ${caseListModel.value.pagination?.total ?? ""} of ${caseListModel.value.pagination?.total ?? ""}"
                            : "📂 Cases: ${(caseListModel.value.pagination?.currentPage ?? 0) * (caseListModel.value.pagination?.perPage ?? 0)} of ${caseListModel.value.pagination?.total ?? ""}",
                        style: AppTextStyles.header(
                          color: Colors.white,
                        ),
                      ),
                      Divider(
                        color: Colors.white.withOpacity(0.4),
                        thickness: 1,
                      ),
                      SizedBox(height: 16.h),

                      // --- PDF Button ---
                      _buildMenuButton(
                        icon: Icons.picture_as_pdf,
                        label: "Download PDF",
                        iconColor: Colors.redAccent,
                        onPressed: () {
                          downloadFile(
                            fileUrl: caseListModel.value.pdfDownloadLink ?? '',
                          );
                        },
                      ),
                      SizedBox(height: 10.h),

                      // --- Excel Button ---
                      _buildMenuButton(
                        icon: Icons.table_chart_outlined,
                        label: "Export Excel",
                        iconColor: Colors.greenAccent,
                        onPressed: () {
                          downloadFile(fileUrl: caseListModel.value.exelDownloadLink??"");
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // --- Toggle Handle ---


              ClipPath(
                clipper: CustomMenuClipper(position: "right"),
                child: Container(
                  width: 28,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.95),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 6,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () => isExpanded.value = !isExpanded.value,
                    child: Center(
                      child: Icon(
                        isExpanded.value
                            ? Icons.arrow_back_ios_new_rounded
                            : Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: AppDimensions.iconSizeSmall.sp,
                      ),
                    ),
                  ),
                ),
              ),

           */
/*   Container(
                width: 20,
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.95),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.only(topRight: Radius.circular(AppDimensions.borderMedium.r),bottomRight: Radius.circular(AppDimensions.borderMedium.r))
                ),
                child: InkWell(
                  onTap: () => isExpanded.value = !isExpanded.value,
                  child: Center(
                    child: Icon(
                      isExpanded.value
                          ? Icons.arrow_back_ios_new_rounded
                          : Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: AppDimensions.iconSizeSmall.sp,
                    ),
                  ),
                ),
              ),*/ /*

            ],
          ),
        ),
      ),
    );
  }

  /// reusable menu button
  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.15),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        elevation: 0,
        minimumSize: Size(15, 45.h), // পুরো width নেবে
      ),
      icon: Icon(icon, color: iconColor, size: AppDimensions.iconSizeMedium.sp),
      label: Text(
        label,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
      ),
    );
  }

}
*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../constraints/dimensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/download_controller.dart';
import '../utils/download_document.dart';
import 'custom_clipper.dart';
import '../models/pagination_model.dart';

class PaginationSideMenu extends StatelessWidget {
  final RxBool isExpanded;
  final Pagination? pagination;
  final String? pdfDownloadLink;
  final String? exelDownloadLink;
  final double menuWidth;
  final double bottomOffset;
  final int totalCase;

    PaginationSideMenu({
    super.key,
    required this.isExpanded,
    this.pagination,
    this.pdfDownloadLink,
    this.exelDownloadLink,
    this.menuWidth = 220,
    this.bottomOffset = 0,
    this.totalCase = 0,
  });

  var downloadController=Get.put(DownloadsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        left: isExpanded.value ? 0 : -menuWidth.w,
        bottom: bottomOffset.h,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- Main Menu ---
              Container(
                width: menuWidth.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.95),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppDimensions.borderMedium.r),
                    bottomRight: Radius.circular(AppDimensions.borderMedium.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Cases Count
                      Text(
                        _casesCountText(),
                        style: AppTextStyles.header(color: Colors.white),
                      ),
                      Divider(
                          color: Colors.white.withOpacity(0.4), thickness: 1),
                      SizedBox(height: 16.h),

                      // --- PDF Button ---
                      if ((pdfDownloadLink ?? '').isNotEmpty)
                        _buildMenuButton(
                          icon: Icons.picture_as_pdf,
                          label: "Download PDF",
                          iconColor: Colors.redAccent,
                          onPressed: () =>
                              downloadController.downloadFile(fileUrl: pdfDownloadLink!),
                        ),
                      if ((pdfDownloadLink ?? '').isNotEmpty)
                        SizedBox(height: 10.h),

                      // --- Excel Button ---
                      if ((exelDownloadLink ?? '').isNotEmpty)
                        _buildMenuButton(
                          icon: Icons.table_chart_outlined,
                          label: "Export Excel",
                          iconColor: Colors.greenAccent,
                          onPressed: () =>
                              downloadController.downloadFile(fileUrl: exelDownloadLink!,fileExtension:"xlsx"),
                        ),
                    ],
                  ),
                ),
              ),

              // --- Toggle Handle ---
              ClipPath(
                clipper: CustomMenuClipper(position: "right"),
                child: Container(
                  width: 28,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.95),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 6,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () => isExpanded.value = !isExpanded.value,
                    child: Center(
                      child: Icon(
                        isExpanded.value
                            ? Icons.arrow_back_ios_new_rounded
                            : Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: AppDimensions.iconSizeSmall.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _casesCountText() {
    if ((pagination?.total) == null && totalCase > 0) {
      return "📂 Cases: $totalCase of $totalCase";
    }
    return (pagination?.currentPage ?? 0) == (pagination?.lastPage ?? 0)
        ? "📂 Cases: ${pagination?.total ?? ""} of ${pagination?.total ?? ""}"
        : "📂 Cases: ${(pagination?.currentPage ?? 0) * (pagination?.perPage ?? 0)} of ${pagination?.total ?? ""}";
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.15),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        elevation: 0,
        minimumSize: Size(double.infinity, 45.h),
      ),
      icon: Icon(icon, color: iconColor, size: AppDimensions.iconSizeMedium.sp),
      label: Text(
        label,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
      ),
    );
  }
}
