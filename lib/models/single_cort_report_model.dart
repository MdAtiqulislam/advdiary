class SingleCourtReportModel {
  final int? id;
  final String? cortName;
  final String? district;
  final String? thana;
  final String? category;
  final int? categoryId;
  final String? grCaseNo;
  final String? caseNumber;
  final String? caseDate;
  final String? clientName;
  final String? otherSide;
  final String? mobileNo;
  final String? nextDate;
  final String? status;
  final String? fixedFor;

  SingleCourtReportModel({
    this.id,
    this.cortName,
    this.district,
    this.thana,
    this.category,
    this.categoryId,
    this.grCaseNo,
    this.caseNumber,
    this.caseDate,
    this.clientName,
    this.otherSide,
    this.mobileNo,
    this.nextDate,
    this.status,
    this.fixedFor,
  });

  factory SingleCourtReportModel.fromJson(Map<String, dynamic> json) => SingleCourtReportModel(
    id: json["id"],
    cortName: json["cort_name"],
    district: json["district"],
    thana: json["thana"],
    category: json["category"],
    categoryId: json["category_id"],
    grCaseNo: json["gr_case_no"],
    caseNumber: json["case_number"],
    caseDate: json["case_date"],
    clientName: json["client_name"],
    otherSide: json["other_side"],
    mobileNo: json["mobile_no"],
    nextDate: json["next_date"],
    status: json["status"],
    fixedFor: json["fixed_for"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cort_name": cortName,
    "district": district,
    "thana": thana,
    "category": category,
    "category_id": categoryId,
    "gr_case_no": grCaseNo,
    "case_number": caseNumber,
    "case_date": caseDate,
    "client_name": clientName,
    "other_side": otherSide,
    "mobile_no": mobileNo,
    "next_date": nextDate,
    "status": status,
    "fixed_for": fixedFor,
  };
}