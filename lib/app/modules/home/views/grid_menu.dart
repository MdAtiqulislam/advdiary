import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../theme/app_colors.dart';

class MenuItemModel {
  final IconData icon;
  final String title;

  MenuItemModel({required this.icon, required this.title});
}

class GridMenu extends StatefulWidget {
  final List<MenuItemModel> items;
  final Function(int index)? onItemTap;

  const GridMenu({super.key, required this.items, this.onItemTap});

  @override
  State<GridMenu> createState() => _GridMenuState();
}

class _GridMenuState extends State<GridMenu> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
     // padding: const EdgeInsets.all(AppDimensions.widgetPadding),
      itemCount: widget.items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final isSelected = selectedIndex == index;

        return InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            if (widget.onItemTap != null) widget.onItemTap!(index);
          },
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall.r),
          child: Container(
            decoration: BoxDecoration(
              color:  Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall.r),
              boxShadow:  [
                BoxShadow(
                  color: Colors.black.withAlpha((.15*254).toInt()),
                  blurRadius: 3,

                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon,
                    size: AppDimensions.iconSizeLarge, color: isSelected ? AppColors.primaryColor : AppColors.icon),
                 const SizedBox(height: AppDimensions.contentPadding),
                Text(
                  item.title,
                  style: AppTextStyles.header()
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
