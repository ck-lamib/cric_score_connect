import 'dart:convert';

import 'package:cric_score_connect/screens/match/batting_stats.dart';
import 'package:cric_score_connect/screens/match/bowling_stats.dart';

List<User> userFromJson(List<dynamic> userJsons) =>
    userJsons.map((userJson) => User.fromJson(userJson)).toList();

class User {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final String? dob;
  final String? phone;
  final String? address;
  final String? profilePhotoPath;
  final String? playerType;
  final MatchBowlingStats? matchBowlingStats;
  final MatchBattingStats? matchBattingStats;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.dob,
    this.phone,
    this.address,
    this.profilePhotoPath,
    this.playerType,
    this.matchBattingStats,
    this.matchBowlingStats,
  });

  User copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    String? dob,
    String? phone,
    String? address,
    String? profilePhotoPath,
    String? playerType,
    MatchBowlingStats? matchBowlingStats,
    MatchBattingStats? matchBattingStats,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        dob: dob ?? this.dob,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
        playerType: playerType ?? this.playerType,
        matchBattingStats: matchBattingStats ?? this.matchBattingStats,
        matchBowlingStats: matchBowlingStats ?? this.matchBowlingStats,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        dob: json["dob"],
        phone: json["phone"],
        address: json["address"],
        profilePhotoPath: json["profile_photo_url"],
        playerType: json["playerType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "dob": dob,
        "phone": phone,
        "address": address,
        "profile_photo_url": profilePhotoPath,
        "playerType": playerType,
      };
}
