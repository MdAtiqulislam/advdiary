import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../theme/app_colors.dart';

class ItemCard extends StatelessWidget {
  final int count;
  final String name;
  final VoidCallback onTap;

  const ItemCard({
    super.key,
    required this.name,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),

      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 5,
          ),
        ],
        color: Colors.white
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              // Count and Name Section
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          count.toString(),
                          style: AppTextStyles.title(resizeAble: false,fontWeight: FontWeight.w600),
                        ),
                       // SizedBox(height: AppDimensions.contentPadding.h),
                        Text(
                          name,
                         // color: Colors.white,
                          style: AppTextStyles.header(fontWeight: FontWeight.w400),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Details Button Section
            ],
          ),
        ),
      ),
    );
  }
}
