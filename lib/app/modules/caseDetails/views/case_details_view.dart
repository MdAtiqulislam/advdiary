import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/fixedForSetting/models/fixed_for_list_model.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:advdiary/utils/download_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_bottom_sheet.dart';
import '../../../../common_widgets/custom_search_drop_down_field.dart';
import '../../../../common_widgets/custom_text_field.dart';
import '../../../../common_widgets/info_row.dart';
import '../../../../models/status_model.dart';
import '../../../../theme/app_colors.dart';
import '../../../../utils/utils.dart';
import '../../bottom_navigation_bar/custom_bottom_nav_bar.dart';
import '../controllers/case_details_controller.dart';
import 'package:path/path.dart' as p;

class CaseDetailsView extends GetView<CaseDetailsController> {
  final GlobalKey<FormState> nextDateFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  var downloadController = Get.put(DownloadsController());

  CaseDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      loadMoreData();
    });

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: "Case Details",
          scaffoldKey: _scaffoldKey,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: CustomBody(
          child: Obx(
            () => Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppDimensions.sectionPadding.h,
                      ),
                      infoSection(),
                      // const SizedBox(height: AppDimensions.sectionPadding,),
                      nextCaseList()
                    ],
                  ),
                ),
                if (controller.isLoading.value) const LoadingScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoSection() {
    final data = controller.caseDetailsModel.value.data;

    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(
        horizontal: AppDimensions.horizontalPadding.w,
        vertical: AppDimensions.contentPadding.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Top Header (Court Name + Case No.)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.contentPadding.w,
                vertical: AppDimensions.contentPadding.h),
            decoration: BoxDecoration(
              color: AppColors.titleBg,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppDimensions.borderRadius.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.account_balance,
                      size: AppDimensions.iconSizeMedium.sp,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: AppDimensions.contentPadding.w,
                    ),
                    Text(
                      "Court Name:",
                      style: AppTextStyles.title(
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                  ],
                ),
                Text(
                  data?.cortName ?? '--',
                  style: AppTextStyles.title(
                      fontWeight: FontWeight.w500, fontSize: 18),
                  maxLines: 3,
                ),
                SizedBox(height: 4.h),
                Text(
                  "Case No: ${data?.caseNumber ?? '--'}",
                  style: AppTextStyles.header(
                      context: Get.context,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
          ),

          /// 🔹 Info Section
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPadding.w,
              vertical: AppDimensions.verticalPadding.h,
            ),
            child: Column(
              children: [
                InfoRow(
                  icon: Icons.category,
                  label: 'Category',
                  value: data?.category ?? "--",
                ),
                if ((data?.district ?? "").isNotEmpty)
                  InfoRow(
                    icon: Icons.location_city,
                    label: 'District',
                    value: data?.district ?? "--",
                  ),
                if ((data?.thana ?? "").isNotEmpty)
                  InfoRow(
                    icon: Icons.home_work_outlined,
                    label: 'Thana',
                    value: data?.thana ?? "--",
                  ),
                if ((data?.grCaseNo ?? "").isNotEmpty)
                  InfoRow(
                    icon: Icons.balance,
                    label: 'G.R. Case No.',
                    value: data?.grCaseNo ?? "--",
                  ),
                InfoRow(
                  icon: Icons.date_range,
                  label: 'Filing Date',
                  value: data?.caseDate ?? "--",
                ),
                InfoRow(
                  icon: Icons.person,
                  label: 'Client',
                  value: data?.clientName ?? "--",
                ),
                InfoRow(
                  icon: Icons.phone,
                  label: 'Mobile No.',
                  value: data?.mobileNo ?? "--",
                ),
                InfoRow(
                  icon: Icons.people,
                  label: 'Other Side',
                  value: data?.otherSide ?? "--",
                ),
                InfoRow(
                  icon: Icons.calendar_today,
                  label: 'Next Date',
                  value: data?.nextDate ?? "--",
                ),
                InfoRow(
                  icon: Icons.fact_check_outlined,
                  label: 'Fixed For/ Step',
                  value: data?.fixedFor ?? "--",
                ),
                InfoRow(
                  icon: Icons.info,
                  label: 'Status',
                  value: data?.statusName ?? "--",
                ),
                InfoRow(
                  icon: Icons.payment,
                  label: 'Payment',
                  value: (data?.payment ?? "--").toString(),
                ),
                if((data?.remarks??"").isNotEmpty)InfoRow(
                  icon: Icons.note_alt,
                  label: 'Notes',
                  value: (data?.remarks ?? "--").toString(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget nextCaseList() {
    return Obx(
      () => Container(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding.w,
          vertical: AppDimensions.contentPadding.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.scaffoldBg,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              color: AppColors.titleBg,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.horizontalPadding.w,
                    vertical: AppDimensions.contentPadding.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Next Date List:",
                        style:
                            AppTextStyles.header(fontWeight: FontWeight.w600),
                      ),
                    ),
                    (controller.caseDetailsModel.value.data?.pagination
                                    ?.total ??
                                0) >
                            1
                        ? Text(
                            "Total ${controller.caseDetailsModel.value.data?.pagination?.total ?? "0"} dates",
                            style: AppTextStyles.body(),
                          )
                        : Text(
                            "Total ${controller.caseDetailsModel.value.data?.pagination?.total ?? "0"} date",
                            style: AppTextStyles.body(),
                          )
                  ],
                ),
              ),
            ),
            if ((controller.caseDetailsModel.value.data?.nextDates ?? [])
                .isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.horizontalPadding.w,
                    vertical: AppDimensions.verticalPadding.h),
                child: Text(
                  "No data found!",
                  style: AppTextStyles.header(),
                ),
              ),
            if ((controller.caseDetailsModel.value.data?.nextDates ?? [])
                .isNotEmpty)
              ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.horizontalPadding.w,
                      vertical: AppDimensions.verticalPadding.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (buildContext, index) {
                    var data = controller
                        .caseDetailsModel.value.data?.nextDates?[index];
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.horizontalPadding.w,
                          vertical: AppDimensions.verticalPadding.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data?.nextDate ?? "",
                                style: AppTextStyles.header(
                                    context: Get.context,
                                    fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                onTap: () async {
                                  await controller.getStatus();
                                  controller.loadData(data: data);
                                  showCustomBottomSheet(
                                    title: "Update Case Next Date",
                                    content: nextDateForm(
                                        nextDateId: (data?.id).toString(),
                                        caseId: (controller.caseDetailsModel
                                                .value.data?.id)
                                            .toString()),
                                  );
                                },
                                child: const Icon(Icons.edit),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Status: ",
                                style: AppTextStyles.header(),
                              ),
                              Expanded(
                                child: Text(
                                  data?.statusName ?? "",
                                  style: AppTextStyles.header(
                                      color: AppColors.bodyText),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              Text(
                                "Fixed For/ Step: ",
                                style: AppTextStyles.header(),
                              ),
                              Expanded(
                                  child: Text(
                                data?.fixedFor ?? "",
                                style: AppTextStyles.header(
                                    color: AppColors.bodyText),
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Remark: ",
                                style: AppTextStyles.header(),
                              ),
                              Expanded(
                                child: Text(
                                  data?.remarks ?? "",
                                  style: AppTextStyles.header(
                                      color: AppColors.bodyText),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Payment: ",
                                style: AppTextStyles.header(),
                              ),
                              Expanded(
                                child: Text(
                                  (data?.payment ?? 0).toString(),
                                  style: AppTextStyles.header(
                                      color: AppColors.bodyText),
                                ),
                              ),
                            ],
                          ),
                          if (data?.downloadURL != null &&
                              data?.downloadURL != "")
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Download Document",
                                    style: AppTextStyles.header(),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    downloadController.downloadFile(
                                      fileUrl: controller
                                              .caseDetailsModel
                                              .value
                                              .data
                                              ?.nextDates?[index]
                                              .downloadURL ??
                                          "",
                                      /* fileExtension: controller
                                            .caseDetailsModel
                                            .value
                                            .data
                                            ?.nextDates?[index]
                                            .fileExtention*/
                                    );
                                  },
                                  child: const Icon(Icons.download),
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (buildContext, index) {
                    return const Divider(
                      thickness: 2,
                      color: AppColors.primaryColor,
                    );
                  },
                  itemCount: controller
                          .caseDetailsModel.value.data?.nextDates?.length ??
                      0),
            if (controller.loadingMore.value)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPadding.w,
                  vertical: AppDimensions.verticalPadding.h),
              child: Text(
                "Total Paid Amount: ${controller.caseDetailsModel.value.data?.totalPayment ?? ""}",
                style: AppTextStyles.header(color: AppColors.primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget nextDateForm({required String nextDateId, required String caseId}) {
    return Form(
      key: nextDateFormKey,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.horizontalPadding.w,
            vertical: AppDimensions.verticalPadding.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
            boxShadow: const [
              BoxShadow(color: AppColors.shadow, blurRadius: 5),
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
              value: controller.selectedStatus.value.id == null
                  ? null
                  : controller.selectedStatus.value,
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
              value: controller.selectedFixedFor.value.id == null
                  ? null
                  : controller.selectedFixedFor.value,
              onChange: (SingleFixedForModel? newValue) {
                controller.selectedFixedFor.value =
                    newValue ?? SingleFixedForModel();
              },
              displayItem: (SingleFixedForModel value) => value.fixedFor ?? "",
            ),
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
              width: AppDimensions.widgetPadding.h,
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
                  controller.updateNextDate(nextId: nextDateId, caseId: caseId);
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
      if (controller.caseDetailsModel.value.data?.pagination?.currentPage !=
              controller.caseDetailsModel.value.data?.pagination?.lastPage &&
          !controller.loadingMore.value) {
        controller.loadMore(
          url:
              controller.caseDetailsModel.value.data?.pagination?.nextPageUrl ??
                  "",
        );
      }
    }
  }
}
