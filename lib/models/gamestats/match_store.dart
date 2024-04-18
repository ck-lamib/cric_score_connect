import 'dart:convert';

class MatchStore {
  final String? date;
  final String? time;
  final String? venue;
  final int? overs;
  final int? playersPerTeam;
  final int? team1Id;
  final int? team2Id;
  final int? tossWinnerId;
  final int? userId;
  final MatchStoreExtras? extras;
  final String? updatedAt;
  final String? createdAt;
  final int? id;
  final String? key;

  MatchStore({
    this.date,
    this.time,
    this.venue,
    this.overs,
    this.playersPerTeam,
    this.team1Id,
    this.team2Id,
    this.tossWinnerId,
    this.userId,
    this.extras,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.key,
  });

  MatchStore copyWith({
    String? date,
    String? time,
    String? venue,
    int? overs,
    int? playersPerTeam,
    int? team1Id,
    int? team2Id,
    int? tossWinnerId,
    int? userId,
    MatchStoreExtras? extras,
    String? updatedAt,
    String? createdAt,
    int? id,
    String? key,
  }) =>
      MatchStore(
        date: date ?? this.date,
        time: time ?? this.time,
        venue: venue ?? this.venue,
        overs: overs ?? this.overs,
        playersPerTeam: playersPerTeam ?? this.playersPerTeam,
        team1Id: team1Id ?? this.team1Id,
        team2Id: team2Id ?? this.team2Id,
        tossWinnerId: tossWinnerId ?? this.tossWinnerId,
        userId: userId ?? this.userId,
        extras: extras ?? this.extras,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        key: key ?? this.key,
      );

  factory MatchStore.fromRawJson(String str) =>
      MatchStore.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MatchStore.fromJson(Map<String, dynamic> json) => MatchStore(
        date: json["date"],
        time: json["time"],
        venue: json["venue"],
        overs: json["overs"],
        playersPerTeam: json["players_per_team"],
        team1Id: json["team1_id"],
        team2Id: json["team2_id"],
        tossWinnerId: json["toss_winner_id"],
        userId: json["user_id"],
        extras: json["extras"] == null
            ? null
            : MatchStoreExtras.fromJson(json["extras"]),
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        id: json["id"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "time": time,
        "venue": venue,
        "overs": overs,
        "players_per_team": playersPerTeam,
        "team1_id": team1Id,
        "team2_id": team2Id,
        "toss_winner_id": tossWinnerId,
        "user_id": userId,
        "extras": extras?.toJson(),
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
        "key": key,
      };
}

class MatchStoreExtras {
  final int? byes;
  final int? legByes;
  final int? wide;
  final int? noBall;
  final int? penalty;

  MatchStoreExtras({
    this.byes,
    this.legByes,
    this.wide,
    this.noBall,
    this.penalty,
  });

  MatchStoreExtras copyWith({
    int? byes,
    int? legByes,
    int? wide,
    int? noBall,
    int? penalty,
  }) =>
      MatchStoreExtras(
        byes: byes ?? this.byes,
        legByes: legByes ?? this.legByes,
        wide: wide ?? this.wide,
        noBall: noBall ?? this.noBall,
        penalty: penalty ?? this.penalty,
      );

  factory MatchStoreExtras.fromRawJson(String str) =>
      MatchStoreExtras.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MatchStoreExtras.fromJson(Map<String, dynamic> json) =>
      MatchStoreExtras(
        byes: json["byes"],
        legByes: json["legByes"],
        wide: json["wide"],
        noBall: json["noBall"],
        penalty: json["penalty"],
      );

  Map<String, dynamic> toJson() => {
        "byes": byes,
        "legByes": legByes,
        "wide": wide,
        "noBall": noBall,
        "penalty": penalty,
      };
}
