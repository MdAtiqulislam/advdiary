class SingleThana {
  final int? id;
  final int? districtId;
  final String? name;
  final String? bnName;

  SingleThana({
    this.id,
    this.districtId,
    this.name,
    this.bnName,
  });

  factory SingleThana.fromJson(Map<String, dynamic> json) => SingleThana(
    id: json["id"],
    districtId: json["district_id"],
    name: json["name"],
    bnName: json["bn_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "district_id": districtId,
    "name": name,
    "bn_name": bnName,
  };
}