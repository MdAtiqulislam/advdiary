
import 'package:advdiary/app/modules/caseCategory/models/case_category_list_model.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/app_colors.dart';
class SingleCaseCategoryCard extends StatelessWidget {
  final SingleCaseCategoryModel caseCategory;
  final Function() onDelete;
  final Function() onEdit;
  const SingleCaseCategoryCard({super.key,required this.caseCategory,required this.onDelete,required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10
          )
        ]
      ),
      child: ListTile(
        title: Text(caseCategory.caseCategory??"",style: AppTextStyles.header(),),
        subtitle: Text( "Status: ${(caseCategory.status??1)==1?"Active":"Inactive"}",style: AppTextStyles.body(),),
        trailing: IconButton(onPressed: (){
          onDelete();

        }, icon:  const Icon(Icons.delete,color:AppColors.danger),),
        onTap: (){
          onEdit();
        },
      ),
    );
  }
}
