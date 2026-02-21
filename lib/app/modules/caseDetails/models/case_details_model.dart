// To parse this JSON data, do
//
//     final caseDetailsModel = caseDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:advdiary/models/pagination_model.dart';
import '../../../../models/single_next_date_model.dart';

CaseDetailsModel caseDetailsModelFromJson(String str) =>
    CaseDetailsModel.fromJson(json.decode(str));

String caseDetailsModelToJson(CaseDetailsModel data) =>
    json.encode(data.toJson());

class CaseDetailsModel {
  final String? msg;
  final bool? status;
  final CaseDetailsData? data;

  CaseDetailsModel({
    this.msg,
    this.status,
    this.data,
  });

  factory CaseDetailsModel.fromJson(Map<String, dynamic> json) =>
      CaseDetailsModel(
        msg: json["msg"],
        status: json["status"],
        data: json["data"] == null
            ? null
            : CaseDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}

class CaseDetailsData {
  final int? id;
  final String? caseNumber;
  final String? caseDate;
  final String? clientName;
  final String? otherSide;
  final String? cortName;
  final String? mobileNo;
  final String? category;
  final String? statusName;
  final String? nextDate;
  final String? fixedFor;
  final String? grCaseNo;
  final String? caseRejon;
  final String? remarks;
  final int? payment;
  final List<SingleNextDateModel>? nextDates;
  final int? totalPayment;
  final Pagination? pagination;

  // ✅ Newly Added Fields
  final String? district;
  final String? thana;
  final int? districtId;
  final int? thanaId;

  CaseDetailsData({
    this.id,
    this.caseNumber,
    this.caseDate,
    this.clientName,
    this.otherSide,
    this.cortName,
    this.mobileNo,
    this.nextDate,
    this.payment,
    this.nextDates,
    this.totalPayment,
    this.pagination,
    this.category,
    this.statusName,
    this.caseRejon,
    this.grCaseNo,
    this.fixedFor,
    this.district,
    this.thana,
    this.districtId,
    this.thanaId,
    this.remarks
  });

  factory CaseDetailsData.fromJson(Map<String, dynamic> json) =>
      CaseDetailsData(
        id: json["id"],
        caseNumber: json["case_number"],
        caseDate: json["case_date"],
        clientName: json["client_name"],
        category: json["category"],
        statusName: json["status_name"],
        otherSide: json["other_side"],
        cortName: json["cort_name"],
        mobileNo: json["mobile_no"],
        nextDate: json["next_date"],
        payment: json["payment"],
        caseRejon: json["case_rejon"],
        grCaseNo: json["gr_case_no"],
        fixedFor: json["fixed_for"],
        district: json["district"],
        thana: json["thana"],
        districtId: json["district_id"],
        thanaId: json["thana_id"],
        remarks: json["remarks"],
        nextDates: json["next_dates"] == null
            ? []
            : List<SingleNextDateModel>.from(
            json["next_dates"]!.map((x) => SingleNextDateModel.fromJson(x))),
        totalPayment: json["total_payment"],
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "case_number": caseNumber,
    "case_date": caseDate,
    "client_name": clientName,
    "category": category,
    "status_name": statusName,
    "other_side": otherSide,
    "cort_name": cortName,
    "mobile_no": mobileNo,
    "next_date": nextDate,
    "payment": payment,
    "case_rejon": caseRejon,
    "gr_case_no": grCaseNo,
    "fixed_for": fixedFor,
    "district": district,
    "thana": thana,
    "district_id": districtId,
    "thana_id": thanaId,
    "remarks": remarks,
    "next_dates": nextDates == null
        ? []
        : List<dynamic>.from(nextDates!.map((x) => x.toJson())),
    "total_payment": totalPayment,
    "pagination": pagination?.toJson(),
  };
}

