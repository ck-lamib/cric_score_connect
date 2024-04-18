import 'dart:convert';

List<MatchHistoryModel> matchHistoryModelListFromJson(List<dynamic> jsons) =>
    jsons.map((e) => MatchHistoryModel.fromJson(e)).toList();

class MatchHistoryModel {
  final int? matchId;
  final String? matchKey;
  final String? team1Name;
  final String? team2Name;

  MatchHistoryModel({
    this.matchId,
    this.matchKey,
    this.team1Name,
    this.team2Name,
  });

  MatchHistoryModel copyWith({
    int? matchId,
    String? matchKey,
    String? team1Name,
    String? team2Name,
  }) =>
      MatchHistoryModel(
        matchId: matchId ?? this.matchId,
        matchKey: matchKey ?? this.matchKey,
        team1Name: team1Name ?? this.team1Name,
        team2Name: team2Name ?? this.team2Name,
      );

  factory MatchHistoryModel.fromRawJson(String str) =>
      MatchHistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MatchHistoryModel.fromJson(Map<String, dynamic> json) =>
      MatchHistoryModel(
        matchId: json["match_id"],
        matchKey: json["match_key"],
        team1Name: json["team1Name"],
        team2Name: json["team2Name"],
      );

  Map<String, dynamic> toJson() => {
        "match_id": matchId,
        "match_key": matchKey,
        "team1Name": team1Name,
        "team2Name": team2Name,
      };
}
