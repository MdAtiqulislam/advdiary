import 'package:advdiary/common_widgets/info_row.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/models/single_case_model.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../theme/app_colors.dart';

class SingleCaseCard extends StatelessWidget {
  final SingleCaseModel caseModel;
  final bool isButtonEnable;
  final Function()? onToggleSMS;
  final Function()? onEdit;
  final Function()? onDelete;
  final Function()? onNextDate;
  final Function()? onDetails;
  final Function()? onDownloads;

  const SingleCaseCard({
    super.key,
    required this.caseModel,
    this.onToggleSMS,
    this.onEdit,
    this.onDelete,
    this.onNextDate,
    this.onDetails,
    this.onDownloads,
    this.isButtonEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    // List of buttons with callbacks
    final buttons = <Map<String, dynamic>>[
      {
        'text': 'SMS',
        'icon': caseModel.smsStatus == 0
            ? Icons.mark_chat_unread_rounded
            : Icons.mark_chat_unread_outlined,
        'callback': onToggleSMS,
        "iconColor": caseModel.smsStatus == 0 ? Colors.green : AppColors.danger
      },
      {'text': 'Edit', 'icon': Icons.edit, 'callback': onEdit},
      {'text': 'Delete', 'icon': Icons.delete, 'callback': onDelete},
      {
        'text': 'Next Date',
        'icon': Icons.calendar_today,
        'callback': onNextDate,
        'isIgnored': /*caseModel.status == 5 ||
            caseModel.status == 6 ||
            caseModel.status == 7 ||*/
            !isButtonEnable
      },
      {'text': 'Details', 'icon': Icons.notes, 'callback': onDetails},
      {'text': 'Download', 'icon': Icons.download, 'callback': onDownloads},
    ];

    // Filter only buttons which have callback
    final activeButtons =
        buttons.where((btn) => btn['callback'] != null).toList();

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppDimensions.horizontalPadding.w,
        vertical: AppDimensions.contentPadding.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Top Header (Court Name + Case No.)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.contentPadding.w,
                vertical: AppDimensions.contentPadding.h),
            decoration: BoxDecoration(
              color: AppColors.titleBg,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppDimensions.borderRadius.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.account_balance,
                      size: AppDimensions.iconSizeMedium.sp,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: AppDimensions.contentPadding.w),
                    Text(
                      "Court Name:",
                      style: AppTextStyles.title(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
                Text(
                  caseModel.cortName ?? '--',
                  style: AppTextStyles.title(
                      fontWeight: FontWeight.w500, fontSize: 18),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Case No: ${caseModel.caseNumber ?? '--'}",
                  style: AppTextStyles.header(
                      context: Get.context,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
          ),

          /// 🔹 Info Section
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPadding.w,
              vertical: AppDimensions.verticalPadding.h,
            ),
            child: Column(
              children: [
                InfoRow(
                    icon: Icons.category,
                    label: 'Category',
                    value: caseModel.category ?? "--"),
                if ((caseModel.district ?? "").isNotEmpty)
                  InfoRow(
                      icon: Icons.location_city,
                      label: 'District',
                      value: caseModel.district ?? "--"),
                if ((caseModel.thana ?? "").isNotEmpty)
                  InfoRow(
                      icon: Icons.home_work_outlined,
                      label: 'Thana',
                      value: caseModel.thana ?? "--"),
                if ((caseModel.grCaseNo ?? "").isNotEmpty)
                  InfoRow(
                    icon: Icons.balance,
                    label: 'G.R. Case No.',
                    value: caseModel.grCaseNo ?? "--",
                  ),
                InfoRow(
                    icon: Icons.date_range,
                    label: 'Filing Date',
                    value: caseModel.caseDate ?? "--"),
                InfoRow(
                    icon: Icons.person,
                    label: 'Client',
                    value: caseModel.clientName ?? "--"),
                InfoRow(
                    icon: Icons.phone,
                    label: 'Mobile No.',
                    value: caseModel.mobileNo ?? "--"),
                InfoRow(
                    icon: Icons.people,
                    label: 'Other Side',
                    value: caseModel.otherSide ?? "--"),
                InfoRow(
                    icon: Icons.calendar_today,
                    label: 'Next Date',
                    value: caseModel.nextDate ?? "--"),
                InfoRow(
                    icon: Icons.fact_check_outlined,
                    label: 'Fixed For/ Step',
                    value: caseModel.fixedFor ?? "--"),
                InfoRow(
                    icon: Icons.info,
                    label: 'Status',
                    value: caseModel.statusName ?? "--"),
                if((caseModel.remarks??"").isNotEmpty)InfoRow(
                    icon: Icons.note_alt,
                    label: 'Notes',
                    value: caseModel.remarks ?? "--"),
              ],
            ),
          ),

          /// 🔹 Actions Row (only if activeButtons exist)
          if (activeButtons.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xffC8E6FF),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(AppDimensions.borderRadius.r),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Action:",
                      style:
                          AppTextStyles.header(color: AppColors.primaryColor),
                    ),
                  ),
                  Row(
                    children: activeButtons.map((btn) {
                      return _buildActionButton(btn['text'], btn['icon'],
                          onPressed: btn['callback'],
                          isIgnored: btn['isIgnored'] ?? false,
                          iconColor: btn["iconColor"]);
                    }).toList(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// Button Builder
  Widget _buildActionButton(String text, IconData icon,
      {required Function() onPressed,
      bool isIgnored = false,
      Color? iconColor}) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: IgnorePointer(
        ignoring: isIgnored,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.all(5.sp),
            child: Icon(
              icon,
              size: AppDimensions.iconSizeMedium,
              color: isIgnored
                  ? AppColors.mutedText
                  : iconColor ?? const Color(0xff4B4B4B),
            ),
          ),
        ),
      ),
    );
  }
}
