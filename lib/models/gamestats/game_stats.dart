import 'dart:convert';

import 'package:cric_score_connect/models/gamestats/batting_stats.dart';
import 'package:cric_score_connect/models/gamestats/bowling_stats.dart';
import 'package:cric_score_connect/models/user.dart';

// class BattingBowlingStat {
//   final BattingStats? batting;
//   final BowlingStats? bowling;

//   BattingBowlingStat({
//     this.batting,
//     this.bowling,
//   });

//   BattingBowlingStat copyWith({
//     BattingStats? batting,
//     BowlingStats? bowling,
//   }) =>
//       BattingBowlingStat(
//         batting: batting ?? this.batting,
//         bowling: bowling ?? this.bowling,
//       );

//   factory BattingBowlingStat.fromRawJson(String str) =>
//       BattingBowlingStat.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory BattingBowlingStat.fromJson(Map<String, dynamic> json) =>
//       BattingBowlingStat(
//         batting: json["batting"] == null
//             ? null
//             : BattingStats.fromJson(json["batting"]),
//         bowling: json["bowling"] == null
//             ? null
//             : BowlingStats.fromJson(json["bowling"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "batting": batting?.toJson(),
//         "bowling": bowling?.toJson(),
//       };
// }

class GameStats {
  final User? user;
  final BattingStats? batting;
  final BowlingStats? bowling;

  GameStats({
    this.user,
    this.batting,
    this.bowling,
  });

  GameStats copyWith({
    User? user,
    BattingStats? batting,
    BowlingStats? bowling,
  }) =>
      GameStats(
        user: user ?? this.user,
        batting: batting ?? this.batting,
        bowling: bowling ?? this.bowling,
      );

  factory GameStats.fromRawJson(String str) =>
      GameStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GameStats.fromJson(Map<String, dynamic> json) => GameStats(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        batting: json["batting"] == null
            ? null
            : BattingStats.fromJson(json["batting"]),
        bowling: json["bowling"] == null
            ? null
            : BowlingStats.fromJson(json["bowling"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "batting": batting?.toJson(),
        "bowling": bowling?.toJson(),
      };
}
