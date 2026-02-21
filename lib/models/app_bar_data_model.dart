// To parse this JSON data, do
//
//     final appBaraDataModel = appBaraDataModelFromJson(jsonString);

import 'dart:convert';

AppBaraDataModel appBaraDataModelFromJson(String str) => AppBaraDataModel.fromJson(json.decode(str));

String appBaraDataModelToJson(AppBaraDataModel data) => json.encode(data.toJson());

class AppBaraDataModel {
  final String? msg;
  final bool? status;
  final AppbarData? data;

  AppBaraDataModel({
    this.msg,
    this.status,
    this.data,
  });

  factory AppBaraDataModel.fromJson(Map<String, dynamic> json) => AppBaraDataModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? null : AppbarData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}

class AppbarData {
  final int? totalCases;
  final dynamic packageLimit;
  final String? packageName;
  final String? pkgDetails;
  final int? todayCase;
  final int? notUpdatedPendingNextDate;
  final int? totalUpcomingNextDate;
  final int? clientTokenCommentCount;
  final int? supportTokenCount;

  AppbarData({
    this.totalCases,
    this.packageLimit,
    this.packageName,
    this.todayCase,
    this.notUpdatedPendingNextDate,
    this.totalUpcomingNextDate,
    this.clientTokenCommentCount,
    this.supportTokenCount,
    this.pkgDetails
  });

  factory AppbarData.fromJson(Map<String, dynamic> json) => AppbarData(
    totalCases: json["total_cases"],
    packageLimit: json["package_limit"],
    packageName: json["package_name"],
    pkgDetails: json["pkg_details"],
    todayCase: json["today_case"],
    notUpdatedPendingNextDate: json["not_updated_pending_next_date"],
    totalUpcomingNextDate: json["total_upcoming_next_date"],
    clientTokenCommentCount: json["client_token_comment_count"],
    supportTokenCount: json["support_token_count"],
  );

  Map<String, dynamic> toJson() => {
    "total_cases": totalCases,
    "package_limit": packageLimit,
    "package_name": packageName,
    "pkg_details": pkgDetails,
    "today_case": todayCase,
    "not_updated_pending_next_date": notUpdatedPendingNextDate,
    "total_upcoming_next_date": totalUpcomingNextDate,
    "client_token_comment_count": clientTokenCommentCount,
    "support_token_count": supportTokenCount,
  };
}
