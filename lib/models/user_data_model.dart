class UserDataModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? userImage;
  final String? address;
  final int? status;
  final String? title;
  final dynamic districtId;
  final String? licenceNo;

  UserDataModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.userImage,
    this.address,
    this.status,
    this.title,
    this.districtId,
    this.licenceNo,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    userImage: json["user_image"],
    address: json["address"],
    status: json["status"],
    title: json["title"],
    districtId: json["district_id"],
    licenceNo: json["licence_no"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "user_image": userImage,
    "address": address,
    "status": status,
    "title": title,
    "district_id": districtId,
    "licence_no": licenceNo,
  };
}
