import 'dart:convert';

import '../../../../models/pagination_model.dart';
import '../../../../models/single_cort_report_model.dart';

CourtReportListModel courtReportListModelFromJson(String str) => CourtReportListModel.fromJson(json.decode(str));

String courtReportListModelToJson(CourtReportListModel data) => json.encode(data.toJson());

class CourtReportListModel {
  final String? msg;
  final bool? status;
  final List<SingleCourtReportModel>? data;
  final Pagination? pagination;
  final String? pdfDownloadLink;

  CourtReportListModel({
    this.msg,
    this.status,
    this.data,
    this.pagination,
    this.pdfDownloadLink,
  });

  factory CourtReportListModel.fromJson(Map<String, dynamic> json) => CourtReportListModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null
        ? []
        : List<SingleCourtReportModel>.from(json["data"]!.map((x) => SingleCourtReportModel.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    pdfDownloadLink: json["pdf_download_link"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
    "pdf_download_link": pdfDownloadLink,
  };
}


