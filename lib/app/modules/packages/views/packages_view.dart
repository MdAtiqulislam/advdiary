import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/common_widgets/app_button.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_bottom_sheet.dart';
import '../../../../common_widgets/custom_dialog.dart';
import '../../../../theme/app_colors.dart';
import '../controllers/packages_controller.dart';

class PackagesView extends GetView<PackagesController> {
  PackagesView({super.key});

  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxInt _currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: CustomBottomNavigationBar(),
        appBar: CustomAppBar(
          title: "Upgrade Your Package",
          scaffoldKey: _scaffoldKey,
        ),
        drawer: MyDrawer(),
        body: CustomBody(
          child: Obx(
            () => Stack(
              children: [
                bodyContent(),
                if (controller.isLoading.value) const LoadingScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyContent() {
    List<Color> cardColors = [
      Colors.blue.shade200,
      Colors.green.shade200,
      Colors.purple.shade200,
      Colors.orange.shade200,
      Colors.teal.shade200,
    ];
    int itemCount = controller.packages.value.data?.length ?? 0;
    return SingleChildScrollView(
      child: Column(
        children: [
          // Package Info Container
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPadding.w,
            ),
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: Get.width,
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPadding.w,
                  vertical: AppDimensions.verticalPadding.h),
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("assets/images/moc_img_2.png"),
                    fit: BoxFit.cover,
                    opacity: .1),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.borderRadius.r),
                ),
                color: AppColors.secondaryColor.withAlpha((.25 * 254).toInt()),
              ),
              child: Column(children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    children: [
                      const TextSpan(
                          text: "You are using ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.headerText)),
                      TextSpan(
                        text:
                            "${controller.currentPackage.value.packageName ?? ""} ",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.danger),
                      ),
                      const TextSpan(
                          text: "plan.\n",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.headerText)),
                      const TextSpan(
                          text: "Case Limit: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.headerText)),
                      TextSpan(
                        text:
                            "${controller.currentPackage.value.packageLimit ?? ""}\n",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      //   const TextSpan(text: "⚖️\n"),
                      const TextSpan(
                          text: "Case Used: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.headerText)),
                      TextSpan(
                        text:
                            "${controller.currentPackage.value.totalCase ?? "0"} ",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(
            height: AppDimensions.widgetPadding.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPadding.w,
            ),
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: Get.width,
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPadding.w,
                  vertical: AppDimensions.verticalPadding.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.borderRadius.r),
                ),
                color: AppColors.primaryColor,
              ),
              child: Column(children: [
                Text(
                  "🚀 You can switch between the Basic and Premium packages at any time. Please select a suitable package from below",
                  style: AppTextStyles.header(
                    color: Colors.white,
                  ),
                  maxLines: 5,
                ),
                SizedBox(
                  height: AppDimensions.contentPadding.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.horizontalPadding.w,
                      vertical: 3.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: AppColors.warning),
                  child: Text(
                    "📢 Choose a package",
                    style: AppTextStyles.header(
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              ]),
            ),
          ),

          SizedBox(
            height: AppDimensions.sectionPadding.h,
          ),
          // Package Cards List
          Stack(
            children: [
              CarouselSlider.builder(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: 430.h,
                  viewportFraction: 0.85,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  autoPlay: false,
                  onPageChanged: (index, reason) {
                    _currentIndex.value = index;
                  },
                ),
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  var package = controller.packages.value.data![index];
                  Color cardColor = cardColors[index % cardColors.length];

                  return SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.white
                            : AppColors.primaryColor,
                        borderRadius:
                            BorderRadius.circular(AppDimensions.borderRadius.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.horizontalPadding.w,
                        vertical: AppDimensions.verticalPadding.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: "${package.name} ",
                                    style: AppTextStyles.title(
                                      color: index % 2 == 0
                                          ? AppColors.headerText
                                          : Colors.white,
                                      fontSize: 22,
                                    ),
                                    children: [
                                      if (package.metaItem != null)
                                        TextSpan(
                                          text: "(${package.metaItem})",
                                          style: AppTextStyles.title(
                                            color: (index % 2 == 0
                                                ? AppColors.headerText
                                                    .withOpacity(0.8)
                                                : Colors.white
                                                    .withOpacity(0.8)),
                                            fontSize: 18,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  final metaText = package.metaItem != null &&
                                          package.metaItem!.isNotEmpty
                                      ? " (${package.metaItem})"
                                      : "";

                                  showCustomBottomSheet(
                                    title:
                                        "Details about ${package.name}$metaText plan",
                                    content: Html(
                                      data: package.pkgDetails ??
                                          "<p>No details available.</p>",
                                    ),
                                    headerColor: AppColors.primaryColor,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index % 2 == 0
                                        ? AppColors.primaryColor
                                            .withOpacity(0.1)
                                        : Colors.white.withOpacity(0.08),
                                  ),
                                  child: Icon(
                                    Icons.info_outline,
                                    size: 22,
                                    color: AppColors.info,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppDimensions.widgetPadding.h),
                          Text(
                            index == 0
                                ? "Start Your Journey with the ${package.name} plan"
                                : "You're on a journey of success!",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.header(
                              fontWeight: FontWeight.bold,
                              color: index % 2 == 0
                                  ? AppColors.primaryColor
                                  : Colors.white,
                            ),
                          ),
                          SizedBox(height: AppDimensions.contentPadding.h),
                          Text(
                            index == 0
                                ? "The ${package.name ?? "Basic"} plan is perfect for getting started and handling your cases with ease."
                                : "With the ${package.name ?? "Premium"} package, you unlock the power to manage your cases more efficiently.",
                            textAlign: TextAlign.start,
                            style: AppTextStyles.body(
                              color: index % 2 == 0
                                  ? AppColors.bodyText
                                  : Colors.white,
                            ),
                          ),
                          SizedBox(height: AppDimensions.widgetPadding.h),
                          Text(
                            "📍 Case Limit: ${package.caseLimit} Cases",
                            style: AppTextStyles.body(
                              fontWeight: FontWeight.bold,
                              color: index % 2 == 0
                                  ? AppColors.primaryColor
                                  : Colors.white,
                            ),
                          ),
                          SizedBox(height: AppDimensions.widgetPadding.h),
                          Row(
                            children: [
                              Text(
                                "Tk= ${package.price} ",
                                style: AppTextStyles.title(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w600,
                                  color: index % 2 == 0
                                      ? AppColors.headerText
                                      : Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "/ Month",
                                  style: AppTextStyles.header(
                                    fontWeight: FontWeight.w400,
                                    color: index % 2 == 0
                                        ? AppColors.bodyText
                                        : Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: AppDimensions.widgetPadding.h),
                          AppButton(
                            borderColor: index % 2 == 0
                                ? AppColors.primaryColor
                                : Colors.white,
                            bgColor: Colors.transparent,
                            //textTransform: TextTransform.none,
                            onTap: () {
                              if ((controller
                                          .packageInfo
                                          .value
                                          .data
                                          ?.newSubscriber
                                          ?.newSubscriberStatus ??
                                      0) ==
                                  0) {
                                final amount = controller
                                    .packageInfo
                                    .value
                                    .data
                                    ?.newSubscriber
                                    ?.newSubscriberAmount ?? 0;

                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => CustomDialog(
                                    icon: const Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.red,
                                      size: 48,
                                    ),
                                    title: "Subscription Required",
                                    titleColor: Colors.red,
                                    subtitle: "Active subscription is mandatory to continue.",
                                    description:
                                    "You are not subscribed to the Update Plan.\n\n"
                                        "To access this feature, you must first activate your subscription "
                                        "by paying ৳$amount.\n\n"
                                        "Without subscription, this content will remain locked.",
                                    confirmButtonText: "Subscribe Now (৳$amount)",
                                    cancelButtonText: "Cancel",
                                    confirmButtonColor: Colors.red,   // 🔥 Confirm button red
                                    cancelButtonColor: Colors.grey.shade400,
                                    onConfirmButtonPressed: () {
                                      Get.back();
                                      controller.newSubscribe(amount: "$amount");
                                    },
                                    onCancelButtonPressed: () {
                                      Get.back();
                                    },
                                  ),
                                );
                              } else {
                                controller.upgradePackage(
                                    id: package.id ?? 0,
                                    amount: package.price ?? "0.0");
                              }
                            },
                            text: index == 0 ? "Get Started Now" : "Upgrade",
                            textColor: index % 2 == 0
                                ? AppColors.primaryColor
                                : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: AppDimensions.contentPadding.h),
                          Text(
                            index == 0
                                ? "Upgrade when you're ready to scale up your case management and unlock even more features!"
                                : "Upgrade to boost your productivity and make your legal work more efficient!",
                            textAlign: TextAlign.start,
                            style: AppTextStyles.body(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: index % 2 == 0
                                  ? AppColors.bodyText
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // Left Arrow
              // Left Arrow
              // 🔥 Highlighted Carousel Arrows
              Obx(() {
                if (_currentIndex.value > 0) {
                  return Positioned(
                    top: 0,
                    bottom: 0,
                    left: 5.w,
                    child: Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.r),
                        onTap: () => _carouselController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        ),
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.primaryColor,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
              Obx(() {
                if (_currentIndex.value < itemCount - 1) {
                  return Positioned(
                    top: 0,
                    bottom: 0,
                    right: 5.w,
                    child: Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.r),
                        onTap: () => _carouselController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        ),
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryColor,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
          SizedBox(
            height: AppDimensions.sectionPadding.h,
          ),
        ],
      ),
    );
  }
}
