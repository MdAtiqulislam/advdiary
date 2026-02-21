// To parse this JSON data, do
//
//     final updateCaseModel = updateCaseModelFromJson(jsonString);

import 'dart:convert';

import 'package:advdiary/models/single_case_model.dart';

UpdateCaseModel updateCaseModelFromJson(String str) => UpdateCaseModel.fromJson(json.decode(str));

String updateCaseModelToJson(UpdateCaseModel data) => json.encode(data.toJson());

class UpdateCaseModel {
  final String? msg;
  final bool? status;
  final SingleCaseModel? data;

  UpdateCaseModel({
    this.msg,
    this.status,
    this.data,
  });

  factory UpdateCaseModel.fromJson(Map<String, dynamic> json) => UpdateCaseModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? null : SingleCaseModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}


