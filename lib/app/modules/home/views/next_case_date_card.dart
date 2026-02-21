
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../theme/app_colors.dart';

class NextCaseDateCard extends StatelessWidget {
  final String caseNumber;
  final String nextDate;
  final String courtName;
  final String fixedFor;
  final VoidCallback onViewMore;
  final VoidCallback onViewDetails;

  const NextCaseDateCard({
    super.key,
    required this.caseNumber,
    required this.nextDate,
    required this.courtName,
    required this.onViewMore,
    required this.onViewDetails,
    required this.fixedFor,
  });

  String formatDate(String dateStr) {
    try {
      DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(dateStr);
      return DateFormat("dd MMM").format(parsedDate);
    } catch (e) {
      return dateStr; // If parsing fails, return original string
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = formatDate(nextDate);
    List<String> dateParts = formattedDate.split(" ");

    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall.r),
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.primaryColor, width: 1),
              ),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPadding.w,
                vertical: AppDimensions.contentPadding.h),
            width: Get.width,
            // color: AppColors.primaryColor,
            child:  Text(
               "Upcomming Case Date",
              // color: Colors.white,
              style: AppTextStyles.header(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPadding.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Circular Date Box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                         dateParts[0], // Day
                        style: AppTextStyles.title(color: Colors.white),
                      ),
                      Text(
                         dateParts[1], // Month
                      style: AppTextStyles.body(color: Colors.white),
                      ),
                    ],
                  ),
                ),

                // Case Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                         "Case No: $caseNumber",
                        style: AppTextStyles.header(),
                      ),
                      Text(
                        "Court: $courtName",
                        style: AppTextStyles.body(),
                      ),
                    Text(
                       "Fixed for/ Step: $fixedFor",
                      style: AppTextStyles.body(),
                      ),
                    ],
                  ),
                ),

                // View More Button
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: onViewMore,
              child:  Text(
                 "View More",
                style: AppTextStyles.header(color: AppColors.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
