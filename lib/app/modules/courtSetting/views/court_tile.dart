import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:advdiary/constraints/dimensions.dart';
import '../../../../models/single_court_model.dart';
import '../../../../theme/app_colors.dart';

class CourtTile extends StatelessWidget {
  final SingleCourtModel court;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CourtTile({
    super.key,
    required this.court,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppDimensions.contentPadding.h),
      padding: EdgeInsets.symmetric(vertical: AppDimensions.contentPadding.h, horizontal: AppDimensions.widgetPadding.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 5,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(court.cortName ?? 'Unnamed Court',style: AppTextStyles.header(),),
        subtitle: Text(
          "Status: ${(court.status ?? 0) == 1 ? 'Active' : 'Inactive'}",
          style: AppTextStyles.body(color: (court.status ?? 0) == 1 ? Colors.green : Colors.red,),
        ),
        trailing: Wrap(
          spacing: 10.w,
          children: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
              tooltip: 'Delete',
            ),
          ],
        ),
        onTap: onEdit,
      ),
    );
  }
}
