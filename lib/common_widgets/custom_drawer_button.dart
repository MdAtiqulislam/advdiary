import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomDrawerButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget? icon;
  final String imageIcon;
  final String text;
  final double spacing;
  final double verticalPadding;
  final TextStyle? textStyle;
  final Color backgroundColor;
  final BorderRadius borderRadius;

  const CustomDrawerButton({
    super.key,
    required this.onTap,
    required this.imageIcon,
    required this.text,
    this.icon,
    this.spacing = 12.0,
    this.verticalPadding = 6.0,
    this.textStyle,
    this.backgroundColor = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalPadding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: spacing),
            child: Row(
              children: [
                icon ??
                    Image.asset(
                      imageIcon,
                      height: 20,
                      width: 20,
                      fit: BoxFit.contain,
                    ),
                SizedBox(width: spacing),
                Expanded(
                  child: Text(
                    text,
                    style: textStyle ??AppTextStyles.body(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
