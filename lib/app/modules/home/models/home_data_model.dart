// To parse this JSON data, do
//
//     final homeDataModel = homeDataModelFromJson(jsonString);

import 'dart:convert';

HomeDataModel homeDataModelFromJson(String str) => HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  final String? msg;
  final bool? status;
  final HomeData? data;

  HomeDataModel({
    this.msg,
    this.status,
    this.data,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? null : HomeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}

class HomeData {
  final int? totalCase;
  final int? totalPendingCase;
  final int? totalStay;
  final int? totalInjunction;
  final int? totalStatusQuo;
  final int? totalDismissed;
  final int? totalCompromise;
  final int? totalJudgment;
  final int? totalArchiveCase;
  final int? totalActiveCase;

  HomeData({
    this.totalCase,
    this.totalPendingCase,
    this.totalStay,
    this.totalInjunction,
    this.totalStatusQuo,
    this.totalDismissed,
    this.totalCompromise,
    this.totalJudgment,
    this.totalArchiveCase,
    this.totalActiveCase
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
    totalCase: json["total_case"],
    totalPendingCase: json["total_pending_case"],
    totalStay: json["total_stay"],
    totalInjunction: json["total_injunction"],
    totalStatusQuo: json["total_status_quo"],
    totalDismissed: json["total_dismissed"],
    totalCompromise: json["total_compromise"],
    totalJudgment: json["total_judgment"],
    totalArchiveCase: json["total_archive_case"],
    totalActiveCase: json["total_active_case"],
  );

  Map<String, dynamic> toJson() => {
    "total_case": totalCase,
    "total_pending_case": totalPendingCase,
    "total_stay": totalStay,
    "total_injunction": totalInjunction,
    "total_status_quo": totalStatusQuo,
    "total_dismissed": totalDismissed,
    "total_compromise": totalCompromise,
    "total_judgment": totalJudgment,
    "total_active_case": totalActiveCase,
    "total_archive_case": totalArchiveCase,
  };
}
