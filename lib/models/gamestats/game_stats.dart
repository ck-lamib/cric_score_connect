import 'dart:convert';

import 'package:cric_score_connect/models/gamestats/batting_stats.dart';
import 'package:cric_score_connect/models/gamestats/bowling_stats.dart';

class GameStats {
  final BattingBowlingStat? teamVsteam;
  final BattingBowlingStat? individual;

  GameStats({
    this.teamVsteam,
    this.individual,
  });

  GameStats copyWith({
    BattingBowlingStat? teamVsteam,
    BattingBowlingStat? individual,
  }) =>
      GameStats(
        teamVsteam: teamVsteam ?? this.teamVsteam,
        individual: individual ?? this.individual,
      );

  factory GameStats.fromRawJson(String str) =>
      GameStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GameStats.fromJson(Map<String, dynamic> json) => GameStats(
        teamVsteam: json["teamVsteam"] == null
            ? null
            : BattingBowlingStat.fromJson(json["teamVsteam"]),
        individual: json["individual"] == null
            ? null
            : BattingBowlingStat.fromJson(json["individual"]),
      );

  Map<String, dynamic> toJson() => {
        "teamVsteam": teamVsteam?.toJson(),
        "individual": individual?.toJson(),
      };
}

class BattingBowlingStat {
  final BattingStats? batting;
  final BowlingStats? bowling;

  BattingBowlingStat({
    this.batting,
    this.bowling,
  });

  BattingBowlingStat copyWith({
    BattingStats? batting,
    BowlingStats? bowling,
  }) =>
      BattingBowlingStat(
        batting: batting ?? this.batting,
        bowling: bowling ?? this.bowling,
      );

  factory BattingBowlingStat.fromRawJson(String str) =>
      BattingBowlingStat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BattingBowlingStat.fromJson(Map<String, dynamic> json) =>
      BattingBowlingStat(
        batting: json["batting"] == null
            ? null
            : BattingStats.fromJson(json["batting"]),
        bowling: json["bowling"] == null
            ? null
            : BowlingStats.fromJson(json["bowling"]),
      );

  Map<String, dynamic> toJson() => {
        "batting": batting?.toJson(),
        "bowling": bowling?.toJson(),
      };
}
