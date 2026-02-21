/*

import 'dart:convert';

import 'package:advdiary/models/single_case_model.dart';

PendingCaseListModel pendingCaseListModelFromJson(String str) => PendingCaseListModel.fromJson(json.decode(str));

String pendingCaseListModelToJson(PendingCaseListModel data) => json.encode(data.toJson());

class PendingCaseListModel {
  final String? msg;
  final bool? status;
  final int? totalPending;
  final List<SingleCaseModel>? data;
  final String? pendingNextDateCaseListPdfDownloadLink;

  PendingCaseListModel({
    this.msg,
    this.status,
    this.totalPending,
    this.data,
    this.pendingNextDateCaseListPdfDownloadLink,
  });

  factory PendingCaseListModel.fromJson(Map<String, dynamic> json) => PendingCaseListModel(
    msg: json["msg"],
    status: json["status"],
    totalPending: json["total_pending"],
    data: json["data"] == null ? [] : List<SingleCaseModel>.from(json["data"]!.map((x) => SingleCaseModel.fromJson(x))),
    pendingNextDateCaseListPdfDownloadLink: json["pending_next_date_case_list_pdf_download_link"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "total_pending": totalPending,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pending_next_date_case_list_pdf_download_link": pendingNextDateCaseListPdfDownloadLink,
  };
}


*/

/*

import 'dart:convert';
import 'package:advdiary/models/single_case_model.dart';

PendingCaseListModel pendingCaseListModelFromJson(String str) =>
    PendingCaseListModel.fromJson(json.decode(str));

String pendingCaseListModelToJson(PendingCaseListModel data) =>
    json.encode(data.toJson());

class PendingCaseListModel {
  final String? msg;
  final bool? status;
  final int? totalPending;
  final List<SingleCaseModel>? data;
  final String? pendingNextDateCaseListPdfDownloadLink;

  // 🔥 Newly added fields
  final String? packageName;
  final dynamic packageLimit;
  final int? caseCount;
  final int? newSubscriberStatus;
  final int? monthlyPaymentStatus;
  final int? yearlyPaymentStatus;
  final int? currentUserPkgId;
  final int? nowDayCount;

  PendingCaseListModel({
    this.msg,
    this.status,
    this.totalPending,
    this.data,
    this.pendingNextDateCaseListPdfDownloadLink,
    this.packageName,
    this.packageLimit,
    this.caseCount,
    this.newSubscriberStatus,
    this.monthlyPaymentStatus,
    this.yearlyPaymentStatus,
    this.currentUserPkgId,
    this.nowDayCount,
  });

  factory PendingCaseListModel.fromJson(Map<String, dynamic> json) =>
      PendingCaseListModel(
        msg: json["msg"],
        status: json["status"],
        totalPending: json["total_pending"],
        data: json["data"] == null
            ? []
            : List<SingleCaseModel>.from(
            json["data"].map((x) => SingleCaseModel.fromJson(x))),
        pendingNextDateCaseListPdfDownloadLink:
        json["pending_next_date_case_list_pdf_download_link"],

        // 🔥 Add new fields
        packageName: json["package_name"],
        packageLimit: json["package_limit"],
        caseCount: json["case_count"],
        newSubscriberStatus: json["new_subscriber_status"],
        monthlyPaymentStatus: json["monthly_payment_status"],
        yearlyPaymentStatus: json["yearly_payment_status"],
        currentUserPkgId: json["current_user_pkg_id"],
        nowDayCount: json["now_day_count"],
      );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "total_pending": totalPending,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pending_next_date_case_list_pdf_download_link":
    pendingNextDateCaseListPdfDownloadLink,

    // 🔥 Added new fields
    "package_name": packageName,
    "package_limit": packageLimit,
    "case_count": caseCount,
    "new_subscriber_status": newSubscriberStatus,
    "monthly_payment_status": monthlyPaymentStatus,
    "yearly_payment_status": yearlyPaymentStatus,
    "current_user_pkg_id": currentUserPkgId,
    "now_day_count": nowDayCount,
  };
}
*/


import 'dart:convert';
import 'package:advdiary/models/single_case_model.dart';

PendingCaseListModel pendingCaseListModelFromJson(String str) =>
    PendingCaseListModel.fromJson(json.decode(str));

String pendingCaseListModelToJson(PendingCaseListModel data) =>
    json.encode(data.toJson());

class PendingCaseListModel {
  final String msg;
  final bool status;
  final int totalPending;
  final List<SingleCaseModel> data;
  final String pendingNextDateCaseListPdfDownloadLink;

  // 🔥 NEW FIELDS (null-safe with defaults)
  final String packageName;
  final int packageLimit;
  final int caseCount;
  final int newSubscriberStatus;
  final int monthlyPaymentStatus;
  final int yearlyPaymentStatus;
  final int currentUserPkgId;
  final int nowDayCount;

  PendingCaseListModel({
    this.msg = "",
    this.status = false,
    this.totalPending = 0,
    this.data = const [],
    this.pendingNextDateCaseListPdfDownloadLink = "",
    this.packageName = "",
    this.packageLimit = 0,
    this.caseCount = 0,
    this.newSubscriberStatus = 0,
    this.monthlyPaymentStatus = 0,
    this.yearlyPaymentStatus = 0,
    this.currentUserPkgId = 0,
    this.nowDayCount = 0,
  });

  factory PendingCaseListModel.fromJson(Map<String, dynamic> json) =>
      PendingCaseListModel(
        msg: json["msg"] ?? "",
        status: json["status"] ?? false,
        totalPending: json["total_pending"] ?? 0,
        data: json["data"] == null
            ? []
            : List<SingleCaseModel>.from(
            json["data"].map((x) => SingleCaseModel.fromJson(x))),
        pendingNextDateCaseListPdfDownloadLink:
        json["pending_next_date_case_list_pdf_download_link"] ?? "",

        // 🔥 Safe parsing with default values
        packageName: json["package_name"] ?? "",
        packageLimit: json["package_limit"] ?? 0,
        caseCount: json["case_count"] ?? 0,
        newSubscriberStatus: json["new_subscriber_status"] ?? 0,
        monthlyPaymentStatus: json["monthly_payment_status"] ?? 0,
        yearlyPaymentStatus: json["yearly_payment_status"] ?? 0,
        currentUserPkgId: json["current_user_pkg_id"] ?? 0,
        nowDayCount: json["now_day_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "total_pending": totalPending,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "pending_next_date_case_list_pdf_download_link":
    pendingNextDateCaseListPdfDownloadLink,

    // NEW FIELDS
    "package_name": packageName,
    "package_limit": packageLimit,
    "case_count": caseCount,
    "new_subscriber_status": newSubscriberStatus,
    "monthly_payment_status": monthlyPaymentStatus,
    "yearly_payment_status": yearlyPaymentStatus,
    "current_user_pkg_id": currentUserPkgId,
    "now_day_count": nowDayCount,
  };
}
