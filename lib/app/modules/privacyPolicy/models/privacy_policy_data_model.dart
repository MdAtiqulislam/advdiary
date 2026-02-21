// To parse this JSON data, do
//
//     final privacyPolicyDataModel = privacyPolicyDataModelFromJson(jsonString);

import 'dart:convert';

PrivacyPolicyDataModel privacyPolicyDataModelFromJson(String str) => PrivacyPolicyDataModel.fromJson(json.decode(str));

String privacyPolicyDataModelToJson(PrivacyPolicyDataModel data) => json.encode(data.toJson());

class PrivacyPolicyDataModel {
  final String? msg;
  final bool? status;
  final Data? data;

  PrivacyPolicyDataModel({
    this.msg,
    this.status,
    this.data,
  });

  factory PrivacyPolicyDataModel.fromJson(Map<String, dynamic> json) => PrivacyPolicyDataModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  final String? termsCondition;
  final String? faqSupport;
  final String? returnPolicy;

  Data({
    this.termsCondition,
    this.faqSupport,
    this.returnPolicy,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    termsCondition: json["terms_condition"],
    faqSupport: json["faq_support"],
    returnPolicy: json["return_policy"],
  );

  Map<String, dynamic> toJson() => {
    "terms_condition": termsCondition,
    "faq_support": faqSupport,
    "return_policy": returnPolicy,
  };
}
