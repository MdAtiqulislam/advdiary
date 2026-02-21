import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/empty_screen.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/common_widgets/app_button.dart';
import 'package:advdiary/common_widgets/custom_bottom_sheet.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/custom_text_field.dart';
import 'package:advdiary/constraints/dimensions.dart';
import '../../../../theme/app_colors.dart';
import '../controllers/fixed_for_setting_controller.dart';
import 'fixed_for_tiles.dart';


class FixedForSettingView extends GetView<FixedForSettingController> {
  FixedForSettingView({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      loadMoreData();
    });

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar:   CustomAppBar(title: "Fixed For Settings",scaffoldKey: _scaffoldKey,),
        bottomNavigationBar:  CustomBottomNavigationBar(),
        drawer: MyDrawer(),
        body: CustomBody(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
          
            return Stack(
              children: [
                controller.fixedForList.isEmpty
                    ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.horizontalPadding.w,
                    vertical: AppDimensions.verticalPadding.h,
                  ),
                  child: const EmptyScreen(title: "No data found"),
                )
                    : bodyContent(),
                if (controller.isUpdating.value) const LoadingScreen(),
              ],
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.nameController.clear();
            showCustomBottomSheet(
              title: "Add Fixed For",
              content: _formWidget(type: "New"),
            );
          },
          backgroundColor: AppColors.primaryColor,
          child:  Icon(Icons.add, color: Colors.white, size: AppDimensions.iconSizeMedium.sp),
        ),
      ),
    );
  }

  Widget _formWidget({required String type}) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: AppDimensions.sectionPadding.h),
          CustomTextField(
            levelText: "Name",
            hintText: "Enter name",
            validatorText: "Required",
            controller: controller.nameController,
            isRequired: true,
          ),
          SizedBox(height: AppDimensions.sectionPadding.h),
          AppButton(
            text: type == "New" ? "Save" : "Update",
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                type == "New"
                    ? controller.addFixedFor()
                    : controller.editFixedFor(controller.selectedFixedFor.value);
              }
            },
            bgColor: AppColors.primaryColor,
          ),
          SizedBox(height: AppDimensions.sectionPadding.h),
        ],
      ),
    );
  }

 Widget bodyContent() {
   return CustomScrollView(
     controller: _scrollController, // optional if pagination
     slivers: [
       SliverPadding(
         padding: EdgeInsets.symmetric(
           horizontal: AppDimensions.horizontalPadding.w,
           vertical: AppDimensions.verticalPadding.h,
         ),
         sliver: SliverList(
           delegate: SliverChildBuilderDelegate(
                 (context, index) {
               final fixed = controller.fixedForList[index];
               return Column(
                 children: [
                   FixedForTile(
                     fixed: fixed,
                     onEdit: () {
                       controller.selectedFixedFor.value = fixed;
                       controller.nameController.text = fixed.fixedFor ?? "";
                       showCustomBottomSheet(
                         title: "Update Fixed For",
                         content: _formWidget(type: "Update"),
                       );
                     },
                     onDelete: () => controller.deleteFixedFor(fixed),
                   ),
                   SizedBox(height: AppDimensions.contentPadding.h), // separator
                 ],
               );
             },
             childCount: controller.fixedForList.length,
           ),
         ),
       ),

       // Optional: Add loading indicator at bottom if loading more
       if (controller.loadingMore.value)
         const SliverToBoxAdapter(
           child: Center(
             child: Padding(
               padding: EdgeInsets.all(8.0),
               child: CircularProgressIndicator(),
             ),
           ),
         ),

       // Optional: Add extra bottom space for FAB
       SliverToBoxAdapter(child: SizedBox(height: 100.h)),
     ],
   );

 }

  void loadMoreData() {
    // currentPosition.value=_scrollController.position.pixels;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (controller.pagination.value.currentPage !=
          controller.pagination.value.lastPage &&
          !controller.loadingMore.value) {
        controller.loadMore(
          url: controller.pagination.value.nextPageUrl ?? "",
        );
      }
    }
  }
}
