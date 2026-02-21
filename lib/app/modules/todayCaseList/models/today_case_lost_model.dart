// To parse this JSON data, do
//
//     final todayCaseListModel = todayCaseListModelFromJson(jsonString);

import 'dart:convert';

import 'package:advdiary/models/single_case_model.dart';

TodayCaseListModel todayCaseListModelFromJson(String str) => TodayCaseListModel.fromJson(json.decode(str));

String todayCaseListModelToJson(TodayCaseListModel data) => json.encode(data.toJson());

class TodayCaseListModel {
  final String? msg;
  final bool? status;
  final List<SingleCaseModel>? data;
  final String? todayCaseListDownloadLink;

  TodayCaseListModel({
    this.msg,
    this.status,
    this.data,
    this.todayCaseListDownloadLink,
  });

  factory TodayCaseListModel.fromJson(Map<String, dynamic> json) => TodayCaseListModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleCaseModel>.from(json["data"]!.map((x) => SingleCaseModel.fromJson(x))),
    todayCaseListDownloadLink: json["today_case_list_download_link"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "today_case_list_download_link": todayCaseListDownloadLink,
  };
}


