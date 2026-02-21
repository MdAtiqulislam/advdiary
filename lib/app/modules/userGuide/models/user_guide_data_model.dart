// To parse this JSON data, do
//
//     final userGuideDataModel = userGuideDataModelFromJson(jsonString);

import 'dart:convert';

UserGuideDataModel userGuideDataModelFromJson(String str) => UserGuideDataModel.fromJson(json.decode(str));

String userGuideDataModelToJson(UserGuideDataModel data) => json.encode(data.toJson());

class UserGuideDataModel {
  final String? msg;
  final bool? status;
  final Data? data;

  UserGuideDataModel({
    this.msg,
    this.status,
    this.data,
  });

  factory UserGuideDataModel.fromJson(Map<String, dynamic> json) => UserGuideDataModel(
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
  final String? uploadedFile;

  Data({
    this.uploadedFile,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    uploadedFile: json["uploaded_file"],
  );

  Map<String, dynamic> toJson() => {
    "uploaded_file": uploadedFile,
  };
}
