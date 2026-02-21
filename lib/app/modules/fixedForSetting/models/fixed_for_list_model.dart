// To parse this JSON data, do
//
//     final fixedForListModel = fixedForListModelFromJson(jsonString);

import 'dart:convert';

FixedForListModel fixedForListModelFromJson(String str) => FixedForListModel.fromJson(json.decode(str));

String fixedForListModelToJson(FixedForListModel data) => json.encode(data.toJson());

class FixedForListModel {
  final String? msg;
  final bool? status;
  final List<SingleFixedForModel>? data;
  final Pagination? pagination;

  FixedForListModel({
    this.msg,
    this.status,
    this.data,
    this.pagination,
  });

  factory FixedForListModel.fromJson(Map<String, dynamic> json) => FixedForListModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleFixedForModel>.from(json["data"]!.map((x) => SingleFixedForModel.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class SingleFixedForModel {
  final int? id;
  final String? fixedFor;
  final int? status;

  SingleFixedForModel({
    this.id,
    this.fixedFor,
    this.status,
  });

  factory SingleFixedForModel.fromJson(Map<String, dynamic> json) => SingleFixedForModel(
    id: json["id"],
    fixedFor: json["fixed_for"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fixed_for": fixedFor,
    "status": status,
  };
}

class Pagination {
  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;
  final dynamic nextPageUrl;
  final dynamic prevPageUrl;

  Pagination({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    nextPageUrl: json["next_page_url"],
    prevPageUrl: json["prev_page_url"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "per_page": perPage,
    "current_page": currentPage,
    "last_page": lastPage,
    "next_page_url": nextPageUrl,
    "prev_page_url": prevPageUrl,
  };
}
