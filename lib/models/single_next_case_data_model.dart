class SingleNextCaseTimelineModel {
  final int? id;
  final String? caseNumber;
  final String? clientName;
  final String? nextDate;
  final String? courtName;
  final String? statusName;
  final String? fixedFor;
  final String? mobileNo;
  final String? grCaseNumber;

  SingleNextCaseTimelineModel({
    this.id,
    this.caseNumber,
    this.nextDate,
    this.courtName,
    this.statusName,
    this.fixedFor,
    this.mobileNo,
    this.clientName,
    this.grCaseNumber,
  });

  factory SingleNextCaseTimelineModel.fromJson(Map<String, dynamic> json) => SingleNextCaseTimelineModel(
    id: json["id"],
    caseNumber: json["case_number"],
    grCaseNumber: json["gr_case_no"],
    nextDate: json["next_date"],
    courtName: json["court_name"],
    statusName: json["status_name"],
    fixedFor: json["fixed_for"],
    mobileNo: json["mobile_no"],
    clientName: json["client_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "case_number": caseNumber,
    "next_date": nextDate,
    "court_name": courtName,
    "status_name": statusName,
    "fixed_for": fixedFor,
    "mobile_no": mobileNo,
    "client_name": clientName,
    "gr_case_no": grCaseNumber,
  };
}