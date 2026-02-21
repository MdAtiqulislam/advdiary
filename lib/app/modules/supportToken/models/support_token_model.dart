// To parse this JSON data:
//
//     final supportTokenModel = supportTokenModelFromJson(jsonString);

import 'dart:convert';

import '../../../../models/pagination_model.dart';

SupportTokenModel supportTokenModelFromJson(String str) =>
    SupportTokenModel.fromJson(json.decode(str));

String supportTokenModelToJson(SupportTokenModel data) =>
    json.encode(data.toJson());

class SupportTokenModel {
  final String? msg;
  final bool? status;
  final List<SupportToken>? data;
  final Pagination? pagination;

  SupportTokenModel({
    this.msg,
    this.status,
    this.data,
    this.pagination,
  });

  factory SupportTokenModel.fromJson(Map<String, dynamic> json) =>
      SupportTokenModel(
        msg: json["msg"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<SupportToken>.from(
            json["data"].map((x) => SupportToken.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class SupportToken {
  final int? id;
  final String? date;
  final String? tokenNo;
  final String? token;
  final String? downloadUrl;
  final dynamic totalComment;

  SupportToken({
    this.id,
    this.date,
    this.tokenNo,
    this.token,
    this.downloadUrl,
    this.totalComment,
  });

  factory SupportToken.fromJson(Map<String, dynamic> json) => SupportToken(
    id: json["id"],
    date: json["date"],
    tokenNo: json["token_no"],
    token: json["token"],
    downloadUrl: json["download_url"],
    totalComment: json["total_comment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "token_no": tokenNo,
    "token": token,
    "download_url": downloadUrl,
    "total_comment": totalComment,
  };
}
