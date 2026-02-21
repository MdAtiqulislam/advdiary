// To parse this JSON data, do
//
//     final editCaseModel = editCaseModelFromJson(jsonString);

import 'dart:convert';

import 'package:advdiary/app/modules/addOrUpdateCase/models/category_list_model.dart';

EditCaseModel editCaseModelFromJson(String str) =>
    EditCaseModel.fromJson(json.decode(str));

String editCaseModelToJson(EditCaseModel data) => json.encode(data.toJson());

class EditCaseModel {
  final String? msg;
  final bool? status;
  final EditCaseData? data;

  EditCaseModel({
    this.msg,
    this.status,
    this.data,
  });

  factory EditCaseModel.fromJson(Map<String, dynamic> json) => EditCaseModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null
        ? null
        : EditCaseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}

class EditCaseData {
  final int? id;
  final int? userId;
  final int? districtId;
  final int? thanaId;
  final int? courtId;
  final String? caseNumber;
  final int? categoryId;
  final String? grCaseNo;
  final String? clientName;
  final String? otherSide;
  final String? cortName;
  final int? payment;
  final String? mobileNo;
  final String? remarks;
  final String? caseDate; // API থেকে "13-07-2025" string আকারে আসছে
  final dynamic nextDate; // null or future string/date
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SingleCategoryModel? category;


  EditCaseData({
    this.id,
    this.userId,
    this.districtId,
    this.thanaId,
    this.courtId,
    this.caseNumber,
    this.categoryId,
    this.grCaseNo,
    this.clientName,
    this.otherSide,
    this.cortName,
    this.payment,
    this.mobileNo,
    this.caseDate,
    this.nextDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.remarks,
  });

  factory EditCaseData.fromJson(Map<String, dynamic> json) => EditCaseData(
    id: json["id"],
    userId: json["user_id"],
    districtId: json["district_id"],
    thanaId: json["thana_id"],
    courtId: json["court_id"],
    caseNumber: json["case_number"],
    remarks: json["remarks"],
    categoryId: json["category_id"],
    grCaseNo: json["gr_case_no"],
    clientName: json["client_name"],
    otherSide: json["other_side"],
    cortName: json["cort_name"],
    payment: json["payment"],
    mobileNo: json["mobile_no"],
    caseDate: json["case_date"],
    nextDate: json["next_date"],
    status: json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    category: json["category"] == null
        ? null
        : SingleCategoryModel.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "district_id": districtId,
    "thana_id": thanaId,
    "court_id": courtId,
    "case_number": caseNumber,
    "remarks": remarks,
    "category_id": categoryId,
    "gr_case_no": grCaseNo,
    "client_name": clientName,
    "other_side": otherSide,
    "cort_name": cortName,
    "payment": payment,
    "mobile_no": mobileNo,
    "case_date": caseDate,
    "next_date": nextDate,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "category": category?.toJson(),
  };
}

// Category model আগের মতোই থাকছে—প্রয়োজনে এখানেও districtId ইত্যাদি ফিল্ড অ্যাড করতে পারিস।
class Category {
  final int? id;
  final String? caseCategory;
  final dynamic userId;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category({
    this.id,
    this.caseCategory,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    caseCategory: json["case_category"],
    userId: json["user_id"],
    status: json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "case_category": caseCategory,
    "user_id": userId,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
