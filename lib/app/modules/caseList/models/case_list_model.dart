// To parse this JSON data, do
//
//     final caseListModel = caseListModelFromJson(jsonString);

import 'dart:convert';

import 'package:advdiary/models/single_case_model.dart';

import '../../../../models/pagination_model.dart';

CaseListModel caseListModelFromJson(String str) => CaseListModel.fromJson(json.decode(str));

String caseListModelToJson(CaseListModel data) => json.encode(data.toJson());

class CaseListModel {
  final String? msg;
  final bool? status;
  final List<SingleCaseModel>? data;
  final Pagination? pagination;
  final String? packageName;
  final dynamic packageLimit;
  final int? caseCount;
  final int? newSubscriberStatus;
  final int? currentUserPackageId;
  final int? monthlyPaymentStatus;
  final int? yearlyPaymentStatus;
  final int? nowDayCount;
  final String? pdfDownloadLink;
  final String? exelDownloadLink;

  CaseListModel({
    this.msg,
    this.status,
    this.data,
    this.pagination,
    this.packageName,
    this.packageLimit,
    this.caseCount,
    this.pdfDownloadLink,
    this.newSubscriberStatus,
    this.monthlyPaymentStatus,
    this.yearlyPaymentStatus,
    this.nowDayCount,
    this.exelDownloadLink,
    this.currentUserPackageId,
  });

  factory CaseListModel.fromJson(Map<String, dynamic> json) => CaseListModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleCaseModel>.from(json["data"]!.map((x) => SingleCaseModel.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    packageName: json["package_name"],
    packageLimit: json["package_limit"],
    caseCount: json["case_count"],
    newSubscriberStatus: json["new_subscriber_status"],
    currentUserPackageId: json["current_user_pkg_id"],
    monthlyPaymentStatus: json["monthly_payment_status"],
    yearlyPaymentStatus: json["yearly_payment_status"],
    nowDayCount: json["now_day_count"],
    pdfDownloadLink: json["pdf_download_link"],
    exelDownloadLink: json["excel_download_link"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
    "package_name": packageName,
    "package_limit": packageLimit,
    "case_count": caseCount,
    "new_subscriber_status": newSubscriberStatus,
    "current_user_pkg_id": currentUserPackageId,
    "monthly_payment_status": monthlyPaymentStatus,
    "yearly_payment_status": yearlyPaymentStatus,
    "now_day_count": nowDayCount,
    "pdf_download_link": pdfDownloadLink,
    "excel_download_link": exelDownloadLink,
  };
}

