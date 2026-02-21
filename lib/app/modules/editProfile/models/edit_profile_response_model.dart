// To parse this JSON data, do
//
//     final editProfileResponseModel = editProfileResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:advdiary/models/user_data_model.dart';

EditProfileResponseModel editProfileResponseModelFromJson(String str) => EditProfileResponseModel.fromJson(json.decode(str));

String editProfileResponseModelToJson(EditProfileResponseModel data) => json.encode(data.toJson());

class EditProfileResponseModel {
  final String? msg;
  final bool? status;
  final UserDataModel? data;

  EditProfileResponseModel({
    this.msg,
    this.status,
    this.data,
  });

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) => EditProfileResponseModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? null : UserDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}

