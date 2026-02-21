// To parse this JSON data, do
//
//     final statusListModel = statusListModelFromJson(jsonString);

import 'dart:convert';

StatusListModel statusListModelFromJson(String str) => StatusListModel.fromJson(json.decode(str));

String statusListModelToJson(StatusListModel data) => json.encode(data.toJson());

class StatusListModel {
  final String? msg;
  final bool? status;
  final List<SingleStatusModel>? data;

  StatusListModel({
    this.msg,
    this.status,
    this.data,
  });

  factory StatusListModel.fromJson(Map<String, dynamic> json) => StatusListModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleStatusModel>.from(json["data"]!.map((x) => SingleStatusModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleStatusModel {
  final int? id;
  final String? name;

  SingleStatusModel({
    this.id,
    this.name,
  });

  factory SingleStatusModel.fromJson(Map<String, dynamic> json) => SingleStatusModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
