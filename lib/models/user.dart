import 'dart:convert';

class User {
  final String name;
  final String username;
  final String email;
  final String? dob;
  final String? phone;
  final String? address;
  final dynamic profilePhotoPath;
  final String? playerType;

  User({
    required this.name,
    required this.username,
    required this.email,
    this.dob,
    this.phone,
    this.address,
    this.profilePhotoPath,
    this.playerType,
  });

  User copyWith({
    String? name,
    String? username,
    String? email,
    String? dob,
    String? phone,
    String? address,
    dynamic profilePhotoPath,
    String? playerType,
  }) =>
      User(
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        dob: dob ?? this.dob,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
        playerType: playerType ?? this.playerType,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        username: json["username"],
        email: json["email"],
        dob: json["dob"],
        phone: json["phone"],
        address: json["address"],
        profilePhotoPath: json["profile_photo_path"],
        playerType: json["playerType"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "dob": dob,
        "phone": phone,
        "address": address,
        "profile_photo_path": profilePhotoPath,
        "playerType": playerType,
      };
}
