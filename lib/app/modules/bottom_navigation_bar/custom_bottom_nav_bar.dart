import 'package:advdiary/app/modules/app_bar/app_bar_controller.dart';
import 'package:advdiary/common_widgets/auto_scroll_text_list.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import 'custom_bottom_nav_bar_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final bool showNotice;

  CustomBottomNavigationBar({this.showNotice = false, super.key});

  final CustomBottomNavigationController controller =
      Get.put(CustomBottomNavigationController());

  final List<Map<String, dynamic>> navItems = [
    {'icon': Icons.home, 'label': 'Home'}, // 🏠 হোম
    {'icon': Icons.receipt_long, 'label': 'Cases List'}, // 📄 কেস লিস্ট
    {'icon': Icons.gavel, 'label': 'Court Setup'}, // ⚖️ কোর্ট সেটআপ
    {'icon': Icons.workspace_premium, 'label': 'Packages'}, // 🎁 প্যাকেজ
    {'icon': Icons.support_agent, 'label': 'Support'}, // 👤 প্রোফাইল
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: AppColors.shadow.withAlpha((.3 * 254).toInt()),
                    blurRadius: 5,
                    offset: const Offset(0, -2))
              ],
              border: Border(
                  top: BorderSide(color: AppColors.shadow, width: .5.h))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showNotice && controller.notice.value.isNotEmpty)
                AutoScrollingText(
                  text: controller.notice.value,
                  height: 30.h,
                ),
              BottomNavigationBar(
                selectedItemColor: AppColors.primaryColor,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                currentIndex: controller.selectedIndex.value,
                iconSize: AppDimensions.iconSizeMedium.sp,
                selectedLabelStyle: AppTextStyles.body(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                unselectedLabelStyle: AppTextStyles.body(
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                ),
                unselectedItemColor: AppColors.bodyText,
                onTap: (index) {
                  controller.changeIndex(index);
                },
                items: navItems.asMap().entries.map((entry) {
                  var item = entry.value;
                  var appBarData = Get.put(AppBarController()).appBarData;

                  bool isSupportItem = item['label'] == 'Support'; // ✅ শুধু Support এ badge

                  return BottomNavigationBarItem(
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(item['icon']),
                        if (isSupportItem &&
                            (appBarData.value.data?.supportTokenCount ?? 0) > 0)
                          Positioned(
                            right: -6,
                            top: -3,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.danger,
                              ),
                              child: Text(
                                "${appBarData.value.data?.supportTokenCount ?? 0}",
                                style: AppTextStyles.body(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    label: item['label'],
                  );
                }).toList(),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
