
import 'dart:convert';
import 'package:advdiary/models/single_case_model.dart';
import '../../../../models/pagination_model.dart';

ArchiveModel archiveModelFromJson(String str) => ArchiveModel.fromJson(json.decode(str));
String archiveModelToJson(ArchiveModel data) => json.encode(data.toJson());

class ArchiveModel {
  final String? msg;
  final bool? status;
  final List<SingleCaseModel>? data;
  final Pagination? pagination;
  final int? caseCount;
  final String? pdfDownloadLink;
  final String? excelDownloadLink;

  ArchiveModel({
    this.msg,
    this.status,
    this.data,
    this.pagination,
    this.caseCount,
    this.pdfDownloadLink,
    this.excelDownloadLink,
  });

  factory ArchiveModel.fromJson(Map<String, dynamic> json) => ArchiveModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleCaseModel>.from(json["data"]!.map((x) => SingleCaseModel.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    caseCount: json["case_count"],
    pdfDownloadLink: json["pdf_download_link"],
    excelDownloadLink: json["excel_download_link"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<SingleCaseModel>.from(data!.map((x) => x)),
    "pagination": pagination?.toJson(),
    "case_count": caseCount,
    "pdf_download_link": pdfDownloadLink,
    "excel_download_link": excelDownloadLink,
  };

}
