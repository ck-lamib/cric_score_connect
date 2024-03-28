import 'dart:convert';

class User {
  final String? playerName;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? dob;
  final String? address;
  final String? playerType;
  final String? avatar;

  User({
    this.playerName,
    this.fullName,
    this.email,
    this.phone,
    this.dob,
    this.address,
    this.playerType,
    this.avatar,
  });

  User copyWith({
    String? playerName,
    String? fullName,
    String? email,
    String? phone,
    String? dob,
    String? address,
    String? playerType,
    String? avatar,
  }) =>
      User(
        playerName: playerName ?? this.playerName,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        dob: dob ?? this.dob,
        address: address ?? this.address,
        playerType: playerType ?? this.playerType,
        avatar: playerType ?? this.avatar,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        playerName: json["playerName"],
        fullName: json["fullName"],
        email: json["email"],
        phone: json["phone"],
        dob: json["dob"],
        address: json["address"],
        playerType: json["playerType"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "playerName": playerName,
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "dob": dob,
        "address": address,
        "playerType": playerType,
        "avatar": avatar,
      };
}


// {
//     "playerName":"",
//     "fullName":"",
//     "email":"",
//     "phone":"",
//     "dob":"",
//     "address":"",
//     "playerType":""
// }
