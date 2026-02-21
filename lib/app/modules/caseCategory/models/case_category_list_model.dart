// To parse this JSON data, do
//
//     final caseCategoryListModel = caseCategoryListModelFromJson(jsonString);

import 'dart:convert';

CaseCategoryListModel caseCategoryListModelFromJson(String str) => CaseCategoryListModel.fromJson(json.decode(str));

String caseCategoryListModelToJson(CaseCategoryListModel data) => json.encode(data.toJson());

class CaseCategoryListModel {
  final String? msg;
  final bool? status;
  final List<SingleCaseCategoryModel>? data;

  CaseCategoryListModel({
    this.msg,
    this.status,
    this.data,
  });

  factory CaseCategoryListModel.fromJson(Map<String, dynamic> json) => CaseCategoryListModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleCaseCategoryModel>.from(json["data"]!.map((x) => SingleCaseCategoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleCaseCategoryModel {
  final int? id;
  final String? caseCategory;
  final int? userId;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SingleCaseCategoryModel({
    this.id,
    this.caseCategory,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory SingleCaseCategoryModel.fromJson(Map<String, dynamic> json) => SingleCaseCategoryModel(
    id: json["id"],
    caseCategory: json["case_category"],
    userId: json["user_id"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "case_category": caseCategory,
    "user_id": userId,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
