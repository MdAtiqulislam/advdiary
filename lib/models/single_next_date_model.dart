class SingleNextDateModel {
  final int? id;
  final String? nextDate;
  final String? fixedFor;
  final dynamic remarks;
  final dynamic payment;
  final String? fileExtention;
  final String? downloadURL;
  final String? statusName;

  SingleNextDateModel({
    this.id,
    this.nextDate,
    this.fixedFor,
    this.remarks,
    this.payment,
    this.fileExtention,
    this.downloadURL,
    this.statusName,
  });

  factory SingleNextDateModel.fromJson(Map<String, dynamic> json) => SingleNextDateModel(
    id: json["id"],
    nextDate: json["next_date"],
    fixedFor: json["fixed_for"],
    remarks: json["remarks"],
    payment: json["payment"],
    fileExtention: json["file_extention"],
    downloadURL: json["download_url"],
    statusName: json["status_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "next_date": nextDate,
    "fixed_for": fixedFor,
    "remarks": remarks,
    "payment": payment,
    "file_extention": fileExtention,
    "download_url": downloadURL,
    "status_name": statusName,
  };
}