
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constraints/dimensions.dart';
import '../theme/app_colors.dart';

enum TextTransform { uppercase, lowercase, none }

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Color? bgColor, textColor, borderColor, splashColor;
  final double?  height, width, horizontalPadding, verticalPadding;
  final FontWeight fontWeight;
  final double borderRadius, fontSize;
  final bool showBorder;
  final TextTransform textTransform;
  final Widget? leading; // Optional leading icon or image

  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.bgColor,
    this.textColor,
    this.borderColor,
    this.splashColor,
    this.borderRadius = AppDimensions.borderRadius,
    this.height,
    this.width,
    this.fontSize = 14,
    this.fontWeight = FontWeight.bold,
    this.horizontalPadding = 10,
    this.verticalPadding = 10,
    this.showBorder = true,
    this.textTransform = TextTransform.uppercase, // Default: uppercase transformation
    this.leading, // Initialize leading
  });

  String _applyTextTransform(String text) {
    switch (textTransform) {
      case TextTransform.uppercase:
        return text.toUpperCase();
      case TextTransform.lowercase:
        return text.toLowerCase();
      case TextTransform.none:
        return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: bgColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall.r),
        border: showBorder ? Border.all(color: borderColor ?? AppColors.primaryColor, width: 1.5) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: splashColor ?? (bgColor == null ? AppColors.primaryColor : Colors.white54),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding!, vertical: verticalPadding!),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) ...[
                    leading!,
                    SizedBox(width: 8.w), // Spacing between icon and text
                  ],
                  Text(
                     _applyTextTransform(text),
                    style: AppTextStyles.header(fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: textColor ?? (bgColor == null ? AppColors.primaryColor : Colors.white),
                    ),
                                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}