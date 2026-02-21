// To parse this JSON data, do
//
//     final tokenDetailsModel = tokenDetailsModelFromJson(jsonString);

import 'dart:convert';

TokenDetailsModel tokenDetailsModelFromJson(String str) => TokenDetailsModel.fromJson(json.decode(str));

String tokenDetailsModelToJson(TokenDetailsModel data) => json.encode(data.toJson());

class TokenDetailsModel {
  final String? msg;
  final bool? status;
  final TokenDetailsData? data;

  TokenDetailsModel({
    this.msg,
    this.status,
    this.data,
  });

  factory TokenDetailsModel.fromJson(Map<String, dynamic> json) => TokenDetailsModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? null : TokenDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}

class TokenDetailsData {
  final TokenData? tokenData;
  final List<TokenComment>? tokenComment;

  TokenDetailsData({
    this.tokenData,
    this.tokenComment,
  });

  factory TokenDetailsData.fromJson(Map<String, dynamic> json) => TokenDetailsData(
    tokenData: json["tokenData"] == null ? null : TokenData.fromJson(json["tokenData"]),
    tokenComment: json["token_comment"] == null ? [] : List<TokenComment>.from(json["token_comment"]!.map((x) => TokenComment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokenData": tokenData?.toJson(),
    "token_comment": tokenComment == null ? [] : List<dynamic>.from(tokenComment!.map((x) => x.toJson())),
  };
}

class TokenComment {
  final int? id;
  final int? tokenId;
  final String? comment;
  final String? userType;
  final String? downloadUrl;
  final String? createdAt;

  TokenComment({
    this.id,
    this.tokenId,
    this.comment,
    this.userType,
    this.downloadUrl,
    this.createdAt,
  });

  factory TokenComment.fromJson(Map<String, dynamic> json) => TokenComment(
    id: json["id"],
    tokenId: json["token_id"],
    comment: json["comment"],
    userType: json["user_type"],
    downloadUrl: json["download_url"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token_id": tokenId,
    "comment": comment,
    "user_type": userType,
    "download_url": downloadUrl,
    "created_at": createdAt,
  };
}

class TokenData {
  final int? id;
  final String? token;
  final String? downloadUrl;

  TokenData({
    this.id,
    this.token,
    this.downloadUrl,
  });

  factory TokenData.fromJson(Map<String, dynamic> json) => TokenData(
    id: json["id"],
    token: json["token"],
    downloadUrl: json["download_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
    "download_url": downloadUrl,
  };
}
