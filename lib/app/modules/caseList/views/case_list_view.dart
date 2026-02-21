import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/caseDetails/controllers/case_details_controller.dart';
import 'package:advdiary/app/modules/caseList/views/case_list_filter.dart';
import 'package:advdiary/app/modules/caseList/views/single_case_card.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/app/modules/fixedForSetting/models/fixed_for_list_model.dart';
import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/common_widgets/app_button.dart';
import 'package:advdiary/common_widgets/custom_bottom_sheet.dart';
import 'package:advdiary/common_widgets/custom_dialog.dart';
import 'package:advdiary/common_widgets/custom_search_drop_down_field.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/custom_text_field.dart';
import 'package:advdiary/common_widgets/empty_screen.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/models/status_model.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:advdiary/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/pagination_side_menu.dart';
import '../../../../theme/app_colors.dart';
import '../../../../utils/download_controller.dart';
import '../../addOrUpdateCase/controllers/add_or_update_case_controller.dart';
import '../controllers/case_list_controller.dart';
import 'package:path/path.dart' as p;

class CaseListView extends GetView<CaseListController> {
  CaseListView({super.key});

  final GlobalKey<FormState> nextDateFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  var downloadController=Get.put(DownloadsController());

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      loadMoreData();
    });

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: "Case List",
          scaffoldKey: _scaffoldKey,
          showDrawerButton: controller.showDrawerButton.value,
        ),
        drawer: MyDrawer(),
        floatingActionButton: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle,color: AppColors.primaryColor),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.put(AddOrUpdateCaseController());
              Get.find<AddOrUpdateCaseController>().caseId = "";
              Get.find<AddOrUpdateCaseController>().type.value = "Add New";

              Get.find<AddOrUpdateCaseController>().getDistrictList();
              Get.find<AddOrUpdateCaseController>().getCourtList();
              Get.find<AddOrUpdateCaseController>().resetFormData();

              Get.toNamed(Routes.ADD_OR_UPDATE_CASE);
            },
            // This sets the plus icon
           // backgroundColor: AppColors.primaryColor,
            // You can change the color if you want
           // shape: const CircleBorder(),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              // size: 36,
            ), // Makes sure it's circular
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: Obx(
            () => Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: AppDimensions.widgetPadding.h,),
                    const CaseListFilter(),
                    SizedBox(height: AppDimensions.contentPadding.h,),
                    Expanded(
                      child: bodyContent(),
                    ),
                  ],
                ),
                Container(
                  height: Get.height,
                ),
                if (controller.caseList.isNotEmpty)
                  PaginationSideMenu(
                    isExpanded: controller.openPaginationSlider,
                    pagination: controller.caseListModel.value.pagination,
                    pdfDownloadLink: controller.caseListModel.value.pdfDownloadLink??"",
                    exelDownloadLink: controller.caseListModel.value.exelDownloadLink??"",
                  ),
                if (controller.isLoading.value) const LoadingScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget nextDateForm({required String caseId, int? statusId}) {
    if(statusId!=null){
      controller.selectedStatus.value=controller.statusListModel.value.data
      !.firstWhere(
            (e) => e.id == statusId,
        orElse: () => SingleStatusModel(),
      );
    }


    return Form(
      key: nextDateFormKey,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.horizontalPadding.w,
            vertical: AppDimensions.verticalPadding.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
            boxShadow: const [
              BoxShadow(color: AppColors.primaryColor, blurRadius: 10),
            ],
            color: AppColors.scaffoldBg),
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
            SizedBox(
              height: AppDimensions.widgetPadding.h,
            ),
            CustomSearchableDropdown<SingleStatusModel>(
              title: "Status",
              isRequired: true,
              itemList: controller.statusListModel.value.data ?? [],
              value: statusId != null
                  ? controller.statusListModel.value.data
                  ?.firstWhere(
                    (e) => e.id == statusId,
                orElse: () => SingleStatusModel(),
              )
                  : null,

              onChange: (SingleStatusModel? newValue) {
                controller.selectedStatus.value =
                    newValue ?? SingleStatusModel();
              },
              displayItem: (SingleStatusModel status) => status.name ?? "",
            ),
            SizedBox(
              height: AppDimensions.widgetPadding.h,
            ),
            CustomSearchableDropdown<SingleFixedForModel>(
              title: "Fixed for/ Step",
              isRequired: true,
              itemList: controller.fixedForList,
              //value:controller.statusListModel.value.data?.first??SingleStatusModel(),
              onChange: (SingleFixedForModel? newValue) {
                controller.selectedFixedFor.value =
                    newValue ?? SingleFixedForModel();
              },
              displayItem: (SingleFixedForModel value) => value.fixedFor ?? "",
            ),

            /*CustomTextField(
              maxLine: 10,
              minLine: 2,
              levelText: "Fixed for/ Step",
              isRequired: true,
              validatorText: "Required",
              controller: controller.fixedForController,
            ),*/
            SizedBox(
              height: AppDimensions.widgetPadding.h,
            ),
            CustomTextField(
              maxLine: 10,
              minLine: 2,
              levelText: "Remarks",
              controller: controller.remarksController,
            ),
            SizedBox(
              height: AppDimensions.widgetPadding.h,
            ),
            CustomTextField(
              levelText: "Payment",
              hintText: "00",
              controller: controller.paymentController,
              textInputType: TextInputType.number,
            ),
            SizedBox(
              height: AppDimensions.contentPadding.h,
            ),
            InkWell(
              onTap: () async {
                controller.file = await pickFile();
                if (controller.file != null) {
                  String fileName = p.basename(controller.file!.path);
                  controller.fileNameController.text = fileName;
                }
              },
              child: CustomTextField(
                title: "Order sheet/ Award",
                isEnable: false,
                maxLine: 2,
                preFix: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.horizontalPadding.w),
                  child: const Icon(
                    Icons.cloud_upload_outlined,
                    color: Colors.green,
                    size: 40,
                  ),
                ),
                levelText: "Choose file",
                controller: controller.fileNameController,
              ),
            ),
            SizedBox(
              height: AppDimensions.sectionPadding.h,
            ),
            AppButton(
              text: "Save",
              onTap: () {
                if (nextDateFormKey.currentState?.validate() ?? false) {
                  controller.saveNextDate(caseId: caseId);
                }
              },
              bgColor: AppColors.primaryColor,
            ),
            SizedBox(
              height: AppDimensions.sectionPadding.h,
            ),
          ],
        ),
      ),
    );
  }


  void loadMoreData() {
    // currentPosition.value=_scrollController.position.pixels;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (controller.caseListModel.value.pagination?.currentPage !=
              controller.caseListModel.value.pagination?.lastPage &&
          !controller.loadingMore.value) {
        controller.loadMore(
          url: controller.caseListModel.value.pagination?.nextPageUrl ?? "",
        );
      }
    }
  }

 Widget bodyContent() {
    return (controller.caseListModel.value.data ?? []).isEmpty
        ? Padding(
            padding: EdgeInsets.only(top: AppDimensions.sectionPadding.h),
            child: const EmptyScreen(title: "No data found!"),
          )
        : CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.horizontalPadding.w),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: controller.caseList.value.length,
                    (buildContext, index) {
                  return SingleCaseCard(
                    caseModel: controller.caseList.value[index],
                    isButtonEnable: controller.getButtonEnableStatue(),
                    onToggleSMS: (){
                      showDialog(
                        context: Get.context!,
                        builder: (BuildContext context) {
                          int currentStatus=controller.caseList.value[index].smsStatus??0;

                          return CustomDialog(
                            title: "Change SMS Status",
                            subtitle: currentStatus == 0
                                ? "Are you sure you want to disable SMS service?"
                                : "Are you sure you want to enable SMS service?",
                            description: currentStatus == 0
                                ? "If you disable, no SMS notifications will be sent for this case."
                                : "If you enable, SMS notifications will be sent for this case.",
                            icon: Icon(
                              Icons.warning_amber_outlined,
                              color: AppColors.danger,
                              size: 40.sp,
                            ),
                            confirmButtonText: "Confirm",
                            confirmButtonColor: AppColors.danger,
                            cancelButtonText: "Cancel",
                            cancelButtonColor: AppColors.success,
                            onConfirmButtonPressed: () {
                              Get.back();
                              controller.changeSmsStatus(
                                caseId: controller.caseList.value[index].id.toString(),
                                newStatus: currentStatus == 0 ? 1 : 0, // toggle status
                              );
                            },
                          );

                        },
                      );
                    },
                    onEdit: () {
                      controller.editCase(
                          caseId:
                              (controller.caseList.value[index].id).toString());
                    },
                    onDelete: () {
                      showDialog(
                        context: Get.context!,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            title: "Delete Case",
                            subtitle:
                                "Are you sure you want to delete this case?",
                            description:
                                "This action cannot be undone. Once deleted, all associated data with this case will be permanently removed.",
                            icon:  Icon(
                              Icons.warning_amber_outlined,
                              color: AppColors.danger,
                              size: 40.sp,
                            ),
                            confirmButtonText: "Confirm",
                            confirmButtonColor: AppColors.danger,
                            cancelButtonText: "Cancel",
                            cancelButtonColor: AppColors.success,
                            onConfirmButtonPressed: () {
                              Get.back();
                              controller.deleteCase(
                                  caseId: (controller.caseList.value[index].id)
                                      .toString());
                            },
                          );
                        },
                      );
                    },
                    onNextDate: () {
                      showCustomBottomSheet(
                        title: "Add Case Next Date",
                        content: nextDateForm(
                            caseId: (controller.caseList.value[index].id)
                                .toString(),
                            statusId: (controller.caseList.value[index].status)),
                      );
                    },
                    onDetails: () {
                      Get.put(CaseDetailsController());
                      Get.find<CaseDetailsController>().getCaseDetails(
                          caseId:
                              (controller.caseList.value[index].id).toString());
                      Get.toNamed(Routes.CASE_DETAILS);
                    },
                    onDownloads: () {
                      downloadController.downloadFile(
                          fileUrl: controller.caseList.value[index]
                                  .caseDetailsPdfDownloadLink ??
                              "");
                    },
                  );
                }),
              ),
              if (controller.loadingMore.value)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 100.h,
                ),
              )
            ],
          );
  }

  // ✅ Custom small action button
  Widget smallActionButton({
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        child: Row(
          mainAxisSize: MainAxisSize.min, // ✅ Overflow fix
          children: [
            Icon(icon,
                color: iconColor, size: AppDimensions.iconSizeLarge.sp),
            SizedBox(width: 4.w),
            Text(
              label,
              style: AppTextStyles.title(color: Colors.white),
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ],
        ),
      ),
    );
  }

}
