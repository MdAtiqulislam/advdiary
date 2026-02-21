class SingleCourtModel {
  final int? id;
  final String? cortName;
  final int? status;

  SingleCourtModel({
    this.id,
    this.cortName,
    this.status,
  });

  factory SingleCourtModel.fromJson(Map<String, dynamic> json) => SingleCourtModel(
    id: json["id"],
    cortName: json["court_name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "court_name": cortName,
    "status": status,
  };
}
