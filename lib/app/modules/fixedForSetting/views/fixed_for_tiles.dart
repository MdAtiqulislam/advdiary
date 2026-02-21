import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:advdiary/constraints/dimensions.dart';

import '../../../../theme/app_colors.dart';
import '../models/fixed_for_list_model.dart';


class FixedForTile extends StatelessWidget {
  final SingleFixedForModel fixed;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const FixedForTile({
    super.key,
    required this.fixed,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.contentPadding.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        boxShadow:  [
          BoxShadow(color: AppColors.shadow.withAlpha(125), blurRadius: 5)
        ],
      ),
      child: ListTile(
        title: Text( fixed.fixedFor ?? "",style: AppTextStyles.header(),),
        subtitle: Text(
           "Status: ${(fixed.status ?? 0) == 1 ? "Active" : "Inactive"}",
          style: AppTextStyles.body(),
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete,color: Colors.red,),
        ),
        onTap: onEdit,
      ),
    );
  }
}
