// To parse this JSON data, do
//
//     final faqAndSupportModel = faqAndSupportModelFromJson(jsonString);

import 'dart:convert';

FaqAndSupportModel faqAndSupportModelFromJson(String str) => FaqAndSupportModel.fromJson(json.decode(str));

String faqAndSupportModelToJson(FaqAndSupportModel data) => json.encode(data.toJson());

class FaqAndSupportModel {
  final String? msg;
  final bool? status;
  final FAQData? data;

  FaqAndSupportModel({
    this.msg,
    this.status,
    this.data,
  });

  factory FaqAndSupportModel.fromJson(Map<String, dynamic> json) => FaqAndSupportModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? null : FAQData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}

class FAQData {
  final String? faqFile;

  FAQData({
    this.faqFile,
  });

  factory FAQData.fromJson(Map<String, dynamic> json) => FAQData(
    faqFile: json["faq_file"],
  );

  Map<String, dynamic> toJson() => {
    "faq_file": faqFile,
  };
}
