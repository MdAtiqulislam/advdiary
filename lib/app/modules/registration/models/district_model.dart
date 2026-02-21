// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

import '../../../../models/single_district.dart';

DistrictModel districtModelFromJson(String str) => DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
  final String? msg;
  final bool? status;
  final List<SingleDistrict>? data;

  DistrictModel({
    this.msg,
    this.status,
    this.data,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleDistrict>.from(json["data"]!.map((x) => SingleDistrict.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}


