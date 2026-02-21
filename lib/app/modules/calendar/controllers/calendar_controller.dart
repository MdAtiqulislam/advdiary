import 'package:advdiary/app/modules/calendar/models/events_model.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  var isLoading = false.obs;

  var focusedDay = DateTime.now().obs;
  var selectedDay = Rxn<DateTime>();
  var calendarFormat = CalendarFormat.month.obs;

  var eventsModel = EventsModel().obs;

  /// এখানে আমরা API থেকে পাওয়া events রাখব
  var events = <DateTime, List<SingleEvent>>{}.obs;

  List<SingleEvent> get selectedEvents =>
      selectedDay.value == null ? [] : getEventsForDay(selectedDay.value!);

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }

  List<SingleEvent> getEventsForDay(DateTime day) {
    final key = DateTime.utc(day.year, day.month, day.day);
    return events[key] ?? [];
  }

  Future<void> getEvents() async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getEvents;
    try {
      var res = await RemoteServices.getRequest(endPoint: endPoint);
      if (res != null) {
        eventsModel.value = EventsModel.fromJson(res);

        /// EventsModel → Map<DateTime, List<SingleEvent>> তে convert
        final Map<DateTime, List<SingleEvent>> eventMap = {};
        for (var eventData in eventsModel.value.data ?? []) {
          if (eventData.date != null && eventData.events != null) {
            final key = DateTime.utc(
              eventData.date!.year,
              eventData.date!.month,
              eventData.date!.day,
            );
            eventMap[key] = eventData.events!;
          }
        }
        events.value = eventMap;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
