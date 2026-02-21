// To parse this JSON data, do
//
//     final eventsModel = eventsModelFromJson(jsonString);

import 'dart:convert';

EventsModel eventsModelFromJson(String str) => EventsModel.fromJson(json.decode(str));

String eventsModelToJson(EventsModel data) => json.encode(data.toJson());

class EventsModel {
  final String? msg;
  final bool? status;
  final List<EventData>? data;

  EventsModel({
    this.msg,
    this.status,
    this.data,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<EventData>.from(json["data"]!.map((x) => EventData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class EventData {
  final DateTime? date;
  final List<SingleEvent>? events;

  EventData({
    this.date,
    this.events,
  });

  factory EventData.fromJson(Map<String, dynamic> json) => EventData(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    events: json["events"] == null ? [] : List<SingleEvent>.from(json["events"]!.map((x) => SingleEvent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "events": events == null ? [] : List<dynamic>.from(events!.map((x) => x.toJson())),
  };
}

class SingleEvent {
  final int? id;
  final String? title;
  final String? details;

  SingleEvent({
    this.id,
    this.title,
    this.details,
  });

  factory SingleEvent.fromJson(Map<String, dynamic> json) => SingleEvent(
    id: json["id"],
    title: json["title"],
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "details": details,
  };
}
