
import 'dart:convert';

PackagesModel packagesModelFromJson(String str) => PackagesModel.fromJson(json.decode(str));

String packagesModelToJson(PackagesModel data) => json.encode(data.toJson());

class PackagesModel {
  final String? msg;
  final bool? status;
  final List<SinglePackage>? data;

  PackagesModel({
    this.msg,
    this.status,
    this.data,
  });

  factory PackagesModel.fromJson(Map<String, dynamic> json) => PackagesModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SinglePackage>.from(json["data"]!.map((x) => SinglePackage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SinglePackage {
  final int? id;
  final String? name;
  final dynamic caseLimit;
  final String? price;
  final String? metaItem;
  final String? pkgDetails;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  SinglePackage({
    this.id,
    this.name,
    this.caseLimit,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.metaItem,
    this.pkgDetails,
  });

  factory SinglePackage.fromJson(Map<String, dynamic> json) => SinglePackage(
    id: json["id"],
    name: json["name"],
    caseLimit: json["case_limit"],
    price: json["price"],
    status: json["status"],
    metaItem: json["meta_item"],
    pkgDetails: json["pkg_details"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "case_limit": caseLimit,
    "price": price,
    "status": status,
    "meta_item": metaItem,
    "pkg_details": pkgDetails,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
