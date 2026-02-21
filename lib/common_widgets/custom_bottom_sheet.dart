import 'package:advdiary/constraints/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final Widget content;
  final Color headerColor;

  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.content,
    this.headerColor = AppColors.primaryColor // Default header color
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.borderRadiusLarge.r)),
          image: const DecorationImage(image: AssetImage("assets/images/bg.png"),fit: BoxFit.cover)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Get.textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showCustomBottomSheet({
  required String title,
  required Widget content,
  Color headerColor = AppColors.primaryColor // Default header color
}) {
  Get.bottomSheet(
    CustomBottomSheet(
      title: title,
      content: content,
      headerColor: headerColor,
    ),
    ignoreSafeArea: false,
    isScrollControlled: true, // Allows the bottom sheet to take full height if needed
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    backgroundColor: Colors.transparent, // Ensure background color of the sheet is transparent
  );
}
