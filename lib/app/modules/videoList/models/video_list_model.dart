// To parse this JSON data, do
//
//     final videoListModel = videoListModelFromJson(jsonString);

import 'dart:convert';

import '../../../../models/pagination_model.dart';
import '../../../../models/single_video_model.dart';

VideoListModel videoListModelFromJson(String str) => VideoListModel.fromJson(json.decode(str));

String videoListModelToJson(VideoListModel data) => json.encode(data.toJson());

class VideoListModel {
  final String? msg;
  final bool? status;
  final List<SingleVideo>? data;
  final Pagination? pagination;

  VideoListModel({
    this.msg,
    this.status,
    this.data,
    this.pagination,
  });

  factory VideoListModel.fromJson(Map<String, dynamic> json) => VideoListModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleVideo>.from(json["data"]!.map((x) => SingleVideo.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}





