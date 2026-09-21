
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_bottom_sheet.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/custom_search_drop_down_field.dart';
import '../../../../common_widgets/custom_text_field.dart';
import '../../../../common_widgets/pagination_side_menu.dart';
import '../../../../constraints/dimensions.dart';
import '../../../../models/status_model.dart';
import '../../../../theme/app_colors.dart';
import '../../../../utils/utils.dart';
import '../../../routes/app_pages.dart';
import '../../app_bar/custom_app_bar.dart';
import '../../bottom_navigation_bar/custom_bottom_nav_bar.dart';
import '../../caseDetails/controllers/case_details_controller.dart';
import '../../caseList/views/single_case_card.dart';
import '../../fixedForSetting/models/fixed_for_list_model.dart';
import '../controllers/pending_next_date_controller.dart';

class PendingNextDateView extends GetView<PendingNextDateController> {
  PendingNextDateView({super.key});

  final GlobalKey<FormState> nextDateFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: 'Pending Next Date',
          scaffoldKey: _scaffoldKey,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: Obx(
                () => Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: AppDimensions.widgetPadding.h),
                    Expanded(child: bodyContent()),
                  ],
                ),
                if (controller.pendingList.value.data.isNotEmpty)
                  PaginationSideMenu(
                    isExpanded: controller.openPaginationSlider,
                  //  pagination: controller.pendingList.value.pagination,
                    pdfDownloadLink: controller.pendingList.value.pendingNextDateCaseListPdfDownloadLink??"",
                  //  exelDownloadLink: controller.caseListModel.value.exelDownloadLink??"",
                    totalCase:controller.pendingList.value.data.length,
                  ),
                if (controller.isLoading.value) const LoadingScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // BODY CONTENT
  bodyContent() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPadding.w,
              vertical: 10,
            ),
            child: Obx(() {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: TextField(
                  onChanged: controller.onSearchChanged,
                  decoration: InputDecoration(
                    hintText: "Search case...",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: controller.searchText.value.isNotEmpty
                        ? InkWell(
                      onTap: () {
                        controller.searchText.value = "";
                        controller.getPendingList(search: "");
                      },
                      child: Icon(Icons.close),
                    )
                        : null,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              );
            }),
          ),
        ),

        // LIST CONTENT
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: controller.pendingList.value.data.length ?? 0,
                (buildContext, index) {
              return SingleCaseCard(
                caseModel: controller.pendingList.value.data[index],
                isButtonEnable: controller.getButtonEnableStatue(),
                onNextDate: () {
                  showCustomBottomSheet(
                    title: "Add Case Next Date",
                    content: nextDateForm(
                      caseId: controller.pendingList.value.data[index].id
                          .toString(),
                      statusId:
                      controller.pendingList.value.data[index].status,
                    ),
                  );
                  controller.selectedStatus.value = controller
                      .statusListModel.value.data
                      ?.firstWhere(
                        (e) =>
                    e.id ==
                        controller.pendingList.value
                            .data[index].status,
                    orElse: () => SingleStatusModel(),
                  ) ??
                      SingleStatusModel();
                },
                onDetails: () {
                  Get.put(CaseDetailsController());
                  Get.find<CaseDetailsController>().getCaseDetails(
                      caseId:
                      (controller.pendingList.value.data![index].id).toString());
                  Get.toNamed(Routes.CASE_DETAILS);
                },
              );
            },
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  // NEXT DATE FORM
  Widget nextDateForm({required String caseId, int? statusId}) {
    return Form(
      key: nextDateFormKey,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding.w,
          vertical: AppDimensions.verticalPadding.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
          boxShadow: const [
            BoxShadow(color: AppColors.primaryColor, blurRadius: 10),
          ],
          color: AppColors.scaffoldBg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                controller.dateController.text = await selectDate() ?? "";
              },
              child: CustomTextField(
                levelText: "Next date",
                hintText: "dd-MM-yyyy",
                isRequired: true,
                isEnable: false,
                controller: controller.dateController,
                validatorText: "Required",
              ),
            ),
            const SizedBox(height: 10),

            /// STATUS
            CustomSearchableDropdown<SingleStatusModel>(
              title: "Status",
              isRequired: true,
              itemList: controller.statusListModel.value.data ?? [],
              value: statusId != null
                  ? controller.statusListModel.value.data?.firstWhere(
                    (e) => e.id == statusId,
                orElse: () => SingleStatusModel(),
              )
                  : null,
              onChange: (v) => controller.selectedStatus.value = v!,
              displayItem: (status) => status.name ?? "",
            ),
            SizedBox(height: 10),

            /// FIXED FOR
            CustomSearchableDropdown<SingleFixedForModel>(
              title: "Fixed for / Step",
              isRequired: true,
              itemList: controller.fixedForList,
              onChange: (v) => controller.selectedFixedFor.value = v!,
              displayItem: (v) => v.fixedFor ?? "",
            ),

            SizedBox(height: 10),
            CustomTextField(
              maxLine: 4,
              minLine: 2,
              levelText: "Remarks",
              controller: controller.remarksController,
            ),
            SizedBox(height: 10),
            CustomTextField(
              levelText: "Payment",
              hintText: "00",
              controller: controller.paymentController,
              textInputType: TextInputType.number,
            ),

            SizedBox(height: 15),
            AppButton(
              text: "Save",
              onTap: () {
                if (nextDateFormKey.currentState!.validate()) {
                  controller.saveNextDate(caseId: caseId);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
