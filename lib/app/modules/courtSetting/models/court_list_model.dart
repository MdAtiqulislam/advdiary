// To parse this JSON data, do
//
//     final courtListModel = courtListModelFromJson(jsonString);

import 'dart:convert';

import 'package:advdiary/models/single_court_model.dart';

CourtListModel courtListModelFromJson(String str) => CourtListModel.fromJson(json.decode(str));

String courtListModelToJson(CourtListModel data) => json.encode(data.toJson());



class CourtListModel {
  final String? msg;
  final bool? status;
  final List<SingleCourtModel>? data;

  CourtListModel({
    this.msg,
    this.status,
    this.data,
  });

  factory CourtListModel.fromJson(Map<String, dynamic> json) => CourtListModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleCourtModel>.from(json["data"]!.map((x) => SingleCourtModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}


