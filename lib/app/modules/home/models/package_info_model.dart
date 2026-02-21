// To parse this JSON data, do
//
//     final packageInfoModel = packageInfoModelFromJson(jsonString);

import 'dart:convert';

PackageInfoModel packageInfoModelFromJson(String str) => PackageInfoModel.fromJson(json.decode(str));

String packageInfoModelToJson(PackageInfoModel data) => json.encode(data.toJson());

class PackageInfoModel {
  final String? msg;
  final bool? status;
  final PackageInfoData? data;

  PackageInfoModel({
    this.msg,
    this.status,
    this.data,
  });

  factory PackageInfoModel.fromJson(Map<String, dynamic> json) => PackageInfoModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? null : PackageInfoData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}

class PackageInfoData {
  final CurrentPackage? currentPackage;
  final NewSubscriber? newSubscriber;
  final MonthlyPackage? monthlyPackage;
  final YearlySubscriber? yearlySubscriber;

  PackageInfoData({
    this.currentPackage,
    this.newSubscriber,
    this.monthlyPackage,
    this.yearlySubscriber,
  });

  factory PackageInfoData.fromJson(Map<String, dynamic> json) => PackageInfoData(
    currentPackage: json["current_package"] == null ? null : CurrentPackage.fromJson(json["current_package"]),
    newSubscriber: json["new_subscriber"] == null ? null : NewSubscriber.fromJson(json["new_subscriber"]),
    monthlyPackage: json["monthly_package"] == null ? null : MonthlyPackage.fromJson(json["monthly_package"]),
    yearlySubscriber: json["yearly_subscriber"] == null ? null : YearlySubscriber.fromJson(json["yearly_subscriber"]),
  );

  Map<String, dynamic> toJson() => {
    "current_package": currentPackage?.toJson(),
    "new_subscriber": newSubscriber?.toJson(),
    "monthly_package": monthlyPackage?.toJson(),
    "yearly_subscriber": yearlySubscriber?.toJson(),
  };
}

class CurrentPackage {
  final int? totalCase;
  final String? packageName;
  final dynamic packageLimit;
  final dynamic packageAmount;

  CurrentPackage({
    this.totalCase,
    this.packageName,
    this.packageLimit,
    this.packageAmount,
  });

  factory CurrentPackage.fromJson(Map<String, dynamic> json) => CurrentPackage(
    totalCase: json["total_case"],
    packageName: json["package_name"],
    packageLimit: json["package_limit"],
    packageAmount: json["package_amount"],
  );

  Map<String, dynamic> toJson() => {
    "total_case": totalCase,
    "package_name": packageName,
    "package_limit": packageLimit,
    "package_amount": packageAmount,
  };
}

class MonthlyPackage {
  final String? monthlyPackageName;
  final dynamic monthlyPackageAmount;
  final int? monthlyPaymentStatus;
  final int? bannerStatus;

  MonthlyPackage({
    this.monthlyPackageName,
    this.monthlyPackageAmount,
    this.monthlyPaymentStatus,
    this.bannerStatus
  });

  factory MonthlyPackage.fromJson(Map<String, dynamic> json) => MonthlyPackage(
    monthlyPackageName: json["monthly_package_name"],
    monthlyPackageAmount: json["monthly_package_amount"],
    monthlyPaymentStatus: json["monthly_payment_status"],
    bannerStatus: json["banner_status"],
  );

  Map<String, dynamic> toJson() => {
    "monthly_package_name": monthlyPackageName,
    "monthly_package_amount": monthlyPackageAmount,
    "monthly_payment_status": monthlyPaymentStatus,
    "banner_status": bannerStatus,
  };
}

class NewSubscriber {
  final dynamic newSubscriberAmount;
  final int? newSubscriberStatus;

  NewSubscriber({
    this.newSubscriberAmount,
    this.newSubscriberStatus,
  });

  factory NewSubscriber.fromJson(Map<String, dynamic> json) => NewSubscriber(
    newSubscriberAmount: json["new_subscriber_amount"],
    newSubscriberStatus: json["new_subscriber_status"],
  );

  Map<String, dynamic> toJson() => {
    "new_subscriber_amount": newSubscriberAmount,
    "new_subscriber_status": newSubscriberStatus,
  };
}

class YearlySubscriber {
  final dynamic yearlySubscriberAmount;
  final int? yearlyPaymentStatus;

  YearlySubscriber({
    this.yearlySubscriberAmount,
    this.yearlyPaymentStatus,
  });

  factory YearlySubscriber.fromJson(Map<String, dynamic> json) => YearlySubscriber(
    yearlySubscriberAmount: json["yearly_subscriber_amount"],
    yearlyPaymentStatus: json["yearly_payment_status"],
  );

  Map<String, dynamic> toJson() => {
    "yearly_subscriber_amount": yearlySubscriberAmount,
    "yearly_payment_status": yearlyPaymentStatus,
  };
}
