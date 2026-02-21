class SingleCaseModel {
  final dynamic id;
  final String? district;
  final String? thana;
  final String? category;
  final int? categoryId;
  final String? grCaseNo;
  final String? caseNumber;
  final String? caseDate;
  final String? clientName;
  final String? otherSide;
  final dynamic courtId;
  final String? cortName;
  final String? mobileNo;
  final String? nextDate;
  final String? statusName;
  final String? fixedFor;
  final String? remarks;
  final String? caseDetailsPdfDownloadLink;
  final dynamic status;
  final int? smsStatus;

  SingleCaseModel({
    this.id,
    this.district,
    this.thana,
    this.category,
    this.categoryId,
    this.grCaseNo,
    this.caseNumber,
    this.caseDate,
    this.clientName,
    this.otherSide,
    this.courtId,
    this.cortName,
    this.mobileNo,
    this.nextDate,
    this.statusName,
    this.fixedFor,
    this.status,
    this.caseDetailsPdfDownloadLink,
    this.smsStatus,
    this.remarks
  });

  factory SingleCaseModel.fromJson(Map<String, dynamic> json) => SingleCaseModel(
    id: json["id"],
    district: json["district"],
    thana: json["thana"],
    category: json["category"],
    categoryId: json["category_id"],
    grCaseNo: json["gr_case_no"],
    caseNumber: json["case_number"],
    caseDate: json["case_date"],
    clientName: json["client_name"],
    otherSide: json["other_side"],
    courtId: json["court_id"],
    cortName: json["court_name"],
    mobileNo: json["mobile_no"],
    remarks: json["remarks"],
    nextDate: json["next_date"],
    statusName: json["status_name"],
    fixedFor: json["fixed_for"],
    caseDetailsPdfDownloadLink: json["case_details_pdf_dowload_link"],
    status: json["status"],
    smsStatus: json["sms_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "district": district,
    "thana": thana,
    "category": category,
    "category_id": categoryId,
    "gr_case_no": grCaseNo,
    "case_number": caseNumber,
    "case_date": caseDate,
    "client_name": clientName,
    "remarks": remarks,
    "other_side": otherSide,
    "court_id": courtId,
    "court_name": cortName,
    "mobile_no": mobileNo,
    "next_date": nextDate,
    "status_name": statusName,
    "fixed_for": fixedFor,
    "case_details_pdf_dowload_link": caseDetailsPdfDownloadLink,
    "status": status,
    "sms_status": smsStatus,
  };

  /// ✅ copyWith method
  SingleCaseModel copyWith({
    int? id,
    String? district,
    String? thana,
    String? category,
    int? categoryId,
    String? grCaseNo,
    String? caseNumber,
    String? caseDate,
    String? clientName,
    String? otherSide,
    int? courtId,
    String? cortName,
    String? mobileNo,
    String? nextDate,
    String? statusName,
    String? fixedFor,
    String? caseDetailsPdfDownloadLink,
    int? status,
    int? smsStatus,
  }) {
    return SingleCaseModel(
      id: id ?? this.id,
      district: district ?? this.district,
      thana: thana ?? this.thana,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      grCaseNo: grCaseNo ?? this.grCaseNo,
      caseNumber: caseNumber ?? this.caseNumber,
      caseDate: caseDate ?? this.caseDate,
      clientName: clientName ?? this.clientName,
      otherSide: otherSide ?? this.otherSide,
      courtId: courtId ?? this.courtId,
      cortName: cortName ?? this.cortName,
      mobileNo: mobileNo ?? this.mobileNo,
      nextDate: nextDate ?? this.nextDate,
      statusName: statusName ?? this.statusName,
      fixedFor: fixedFor ?? this.fixedFor,
      caseDetailsPdfDownloadLink:
      caseDetailsPdfDownloadLink ?? this.caseDetailsPdfDownloadLink,
      status: status ?? this.status,
      smsStatus: smsStatus ?? this.smsStatus,
    );
  }
}
