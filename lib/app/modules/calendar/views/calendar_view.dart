import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/app/modules/bottom_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../routes/app_pages.dart';
import '../../caseDetails/controllers/case_details_controller.dart';
import '../controllers/calendar_controller.dart';

class CalendarView extends GetView<CalendarController> {
  CalendarView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: "Calendar",
          scaffoldKey: _scaffoldKey,
        ),
         bottomNavigationBar: CustomBottomNavigationBar(),
        drawer: MyDrawer(),
        body: Obx(()=>Stack(
          children: [
            CustomBody(
              child: Obx(() => ListView(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding.w),
                children: [
                  TableCalendar(
                    firstDay: DateTime.now(),//DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: controller.focusedDay.value,
                    calendarFormat: controller.calendarFormat.value,
                    selectedDayPredicate: (day) {
                      return controller.selectedDay.value != null &&
                          isSameDay(controller.selectedDay.value, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      controller.onDaySelected(selectedDay, focusedDay);
                    },
                    onFormatChanged: (format) {
                      controller.calendarFormat.value = format;
                    },
                    onPageChanged: (focusedDay) {
                      controller.focusedDay.value = focusedDay;
                    },
                    eventLoader: (day) {
                      return controller.getEventsForDay(day);
                    },
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor.withAlpha(50),
                      ),
                      todayTextStyle:
                      const TextStyle(color: AppColors.headerText),
                      markerDecoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        final hasEvent =
                            controller.getEventsForDay(day).isNotEmpty;
                        if (hasEvent) {
                          return Container(
                            margin: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...controller.selectedEvents.map((event) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          /*Get.bottomSheet(
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.title ?? "",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(event.details ?? ""),
                                    ],
                                  ),
                                ),
                              );*/
                          Get.put(CaseDetailsController());
                          Get.find<CaseDetailsController>().getCaseDetails(
                              caseId:
                              (event.id).toString());
                          Get.toNamed(Routes.CASE_DETAILS);

                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.title ?? "",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              event.details ?? "",
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              )),
            ),
            if(controller.isLoading.value)const LoadingScreen()

          ],
        )),
      ),
    );
  }
}
