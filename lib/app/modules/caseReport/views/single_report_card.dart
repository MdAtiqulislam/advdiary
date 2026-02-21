import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/info_row.dart';
import '../../../../models/single_cort_report_model.dart';
import '../../../../theme/app_colors.dart';
class SingleReportCard extends StatelessWidget {
  final SingleCourtReportModel reportModel;
  const SingleReportCard({super.key,required this.reportModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppDimensions.horizontalPadding.w,
        vertical: AppDimensions.contentPadding.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBg,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.contentPadding.w,vertical: AppDimensions.contentPadding.h),
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
                    Icon(Icons.account_balance,size: AppDimensions.iconSizeMedium.sp,color: AppColors.primaryColor,),
                    SizedBox(width: AppDimensions.contentPadding.w,),
                    Text(
                      "Court Name:",
                      style: AppTextStyles.title(fontWeight: FontWeight.bold,),
                      maxLines: 3,
                    ),
                  ],
                ),
                Text(reportModel.cortName ?? '--',style: AppTextStyles.title(
                    fontWeight: FontWeight.w500, fontSize: 18),),
                SizedBox(height: 4.h),
                Text(
                  "Case No: ${reportModel.caseNumber ?? '--'}",
                  style: AppTextStyles.header(
                      context: Get.context,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPadding.w,
                vertical: AppDimensions.verticalPadding.h),
            child: Column(
              children: [
                Column(
                  children: [
                    InfoRow(
                        icon: Icons.category,
                        label: 'Category',
                        value: reportModel.category ?? "--"),
                    if ((reportModel.district ?? "").isNotEmpty)
                      InfoRow(icon:Icons.location_city, label:'District',
                          value:  reportModel.district ?? "--"),
                    if ((reportModel.thana ?? "").isNotEmpty)
                      InfoRow(icon:Icons.home_work_outlined, label: 'Thana',
                          value:reportModel.thana ?? "--"),
                    if ((reportModel.grCaseNo ?? "").isNotEmpty)
                      InfoRow(
                        icon: Icons.balance,
                        label: 'G.R. Case No.',
                        value: reportModel.grCaseNo ?? "--",

                      ),
                    InfoRow(icon: Icons.date_range, label: 'Filing Date', value: reportModel.caseDate ?? "--"),
                    InfoRow(icon: Icons.person, label: 'Client', value: reportModel.clientName ?? "--"),
                    InfoRow(icon: Icons.phone, label: 'Mobile No.', value: reportModel.mobileNo ?? "--"),
                    InfoRow(icon: Icons.people, label: 'Other Side', value: reportModel.otherSide ?? "--"),
                    InfoRow(icon: Icons.calendar_today, label: 'Next Date', value: reportModel.nextDate ?? "--"),
                    InfoRow(icon: Icons.fact_check_outlined, label: 'Fixed For', value: reportModel.fixedFor ?? "--"),
                    InfoRow(icon: Icons.info, label: 'Status', value: reportModel.status ?? "--"),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

}
