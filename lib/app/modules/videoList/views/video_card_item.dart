
import 'dart:ui';
import 'package:advdiary/constraints/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_widgets/custom_network_image.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../theme/app_text_styles.dart';


class VideoCardItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String duration;
  final VoidCallback? onTap;
  final double? width;

  const VideoCardItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.duration,
    this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
      child: SizedBox(
        width: width,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              flex: 7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background blurred image (as a low-resolution, safe blur)
                    ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: CustomNetworkImage(
                        image: imageUrl,
                        fit: BoxFit.cover,
                        localImage: AppImagePath.videoIcon,
                      ),
                    ),

                    // Centered foreground image (sharp)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: CustomNetworkImage(
                          image: imageUrl,
                          fit: BoxFit.contain,
                          localImage: AppImagePath.playButton,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Flexible(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( title,style: AppTextStyles.title(resizeAble: false),),
                    const SizedBox(height: AppDimensions.contentPadding),
                    Row(
                      children: [
                        const Icon(Icons.watch_later_outlined,size: 20,),
                        SizedBox(width: AppDimensions.contentPadding.w,),
                        Text( duration, maxLines: 1,style: AppTextStyles.body(resizeAble: false),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

