// To parse this JSON data, do
//
//     final upComingCaseDateModel = upComingCaseDateModelFromJson(jsonString);

import 'dart:convert';

import 'package:advdiary/models/single_next_case_data_model.dart';

UpComingCaseDateModel upComingCaseDateModelFromJson(String str) => UpComingCaseDateModel.fromJson(json.decode(str));

String upComingCaseDateModelToJson(UpComingCaseDateModel data) => json.encode(data.toJson());

class UpComingCaseDateModel {
  final String? msg;
  final bool? status;
  final List<SingleNextCaseTimelineModel>? data;

  UpComingCaseDateModel({
    this.msg,
    this.status,
    this.data,
  });

  factory UpComingCaseDateModel.fromJson(Map<String, dynamic> json) => UpComingCaseDateModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleNextCaseTimelineModel>.from(json["data"]!.map((x) => SingleNextCaseTimelineModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

