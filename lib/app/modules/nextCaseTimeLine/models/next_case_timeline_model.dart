// To parse this JSON data, do
//
//     final nextCaseTimeLineModel = nextCaseTimeLineModelFromJson(jsonString);

import 'dart:convert';

import '../../../../models/single_next_case_data_model.dart';

NextCaseTimeLineModel nextCaseTimeLineModelFromJson(String str) => NextCaseTimeLineModel.fromJson(json.decode(str));

String nextCaseTimeLineModelToJson(NextCaseTimeLineModel data) => json.encode(data.toJson());

class NextCaseTimeLineModel {
  final String? msg;
  final bool? status;
  final List<SingleNextCaseTimelineModel>? data;
  final String? pdfDownloadLink;

  NextCaseTimeLineModel({
    this.msg,
    this.status,
    this.data,
    this.pdfDownloadLink
  });

  factory NextCaseTimeLineModel.fromJson(Map<String, dynamic> json) => NextCaseTimeLineModel(
    msg: json["msg"],
    status: json["status"],
    pdfDownloadLink: json["upcoming_case_pdf_download_link"],
    data: json["data"] == null ? [] : List<SingleNextCaseTimelineModel>.from(json["data"]!.map((x) => SingleNextCaseTimelineModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "upcoming_case_pdf_download_link": pdfDownloadLink,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}


