// To parse this JSON data, do
//
//     final thanaListModel = thanaListModelFromJson(jsonString);

import 'dart:convert';

import '../../../../models/single_thana.dart';

ThanaListModel thanaListModelFromJson(String str) => ThanaListModel.fromJson(json.decode(str));

String thanaListModelToJson(ThanaListModel data) => json.encode(data.toJson());

class ThanaListModel {
  final String? msg;
  final bool? status;
  final List<SingleThana>? data;

  ThanaListModel({
    this.msg,
    this.status,
    this.data,
  });

  factory ThanaListModel.fromJson(Map<String, dynamic> json) => ThanaListModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleThana>.from(json["data"]!.map((x) => SingleThana.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}


