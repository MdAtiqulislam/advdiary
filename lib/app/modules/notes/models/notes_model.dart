// To parse this JSON data, do
//
//     final notesModel = notesModelFromJson(jsonString);

import 'dart:convert';

import '../../../../models/pagination_model.dart';



NotesModel notesModelFromJson(String str) => NotesModel.fromJson(json.decode(str));

String notesModelToJson(NotesModel data) => json.encode(data.toJson());

class NotesModel {
  final String? msg;
  final bool? status;
  final List<SingleNote>? data;
  final Pagination? pagination;

  NotesModel({
    this.msg,
    this.status,
    this.data,
    this.pagination,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleNote>.from(json["data"]!.map((x) => SingleNote.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class SingleNote {
  final int? id;
  final String? date;
  final String? title;
  final String? description;

  SingleNote({
    this.id,
    this.date,
    this.title,
    this.description,
  });

  factory SingleNote.fromJson(Map<String, dynamic> json) => SingleNote(
    id: json["id"],
    date: json["date"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "title": title,
    "description": description,
  };
}


