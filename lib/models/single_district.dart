class SingleDistrict {
  final int? id;
  final int? divisionId;
  final String? name;
  final String? bnName;
  final double? lat;
  final double? lon;
  final String? website;

  SingleDistrict({
    this.id,
    this.divisionId,
    this.name,
    this.bnName,
    this.lat,
    this.lon,
    this.website,
  });

  factory SingleDistrict.fromJson(Map<String, dynamic> json) => SingleDistrict(
    id: json["id"],
    divisionId: json["division_id"],
    name: json["name"],
    bnName: json["bn_name"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    website: json["website"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "division_id": divisionId,
    "name": name,
    "bn_name": bnName,
    "lat": lat,
    "lon": lon,
    "website": website,
  };
}