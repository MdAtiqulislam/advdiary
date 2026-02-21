// To parse this JSON data, do
//
//     final categoryListModel = categoryListModelFromJson(jsonString);

import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) => CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) => json.encode(data.toJson());

class CategoryListModel {
  final String? msg;
  final bool? status;
  final List<SingleCategoryModel>? data;

  CategoryListModel({
    this.msg,
    this.status,
    this.data,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleCategoryModel>.from(json["data"]!.map((x) => SingleCategoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleCategoryModel {
  final int? id;
  final String? caseCategory;

  SingleCategoryModel({
    this.id,
    this.caseCategory,
  });

  factory SingleCategoryModel.fromJson(Map<String, dynamic> json) => SingleCategoryModel(
    id: json["id"],
    caseCategory: json["case_category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "case_category": caseCategory,
  };
}
