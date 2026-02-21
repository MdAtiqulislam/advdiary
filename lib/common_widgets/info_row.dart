import 'package:advdiary/theme/app_colors.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoRow extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;

  final String label;
  final TextStyle? labelStyle;

  final String value;
  final TextStyle? valueStyle;

  final double spacing;
  final MainAxisAlignment rowAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const InfoRow({
    super.key,
    this.icon,
    this.iconColor,
    this.iconSize,
    required this.label,
    this.labelStyle,
    required this.value,
    this.valueStyle,
    this.spacing = 6.0,
    this.rowAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: rowAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Expanded(
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: iconColor ?? AppColors.primaryColor, size: iconSize ?? 14.sp),
                  SizedBox(width: spacing),
                ],
                Text(
                  "$label: ",
                  style: labelStyle ??
                      AppTextStyles.header(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: valueStyle ??
                  AppTextStyles.header(
                   // fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.bodyText,
                  ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
