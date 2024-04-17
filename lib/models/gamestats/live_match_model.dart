import 'dart:convert';

class LiveMatchStat {
  final String? matchId;
  final bool? isGameFinished;
  final String? finishedMessage;
  final bool? isGameCanceled;
  final String? userId;
  final String? target;
  final String? crr;
  final String? rrr;
  final String? homeTeamName;
  final String? awayTeamName;
  final bool? isFirstInning;
  final int? firstInningTotalRun;
  final double? firstInningTotalOver;
  final int? firstInningTotalWicket;
  final int? secondInningTotalRun;
  final double? secondInningTotalOver;
  final int? secondInningTotalWicket;
  final LiveExtras? extras;
  final List<LiveTeam>? homeTeam;
  final List<LiveTeam>? awayTeam;

  LiveMatchStat({
    this.matchId,
    this.isGameFinished,
    this.finishedMessage,
    this.isGameCanceled,
    this.userId,
    this.target,
    this.crr,
    this.rrr,
    this.homeTeamName,
    this.awayTeamName,
    this.isFirstInning,
    this.firstInningTotalRun,
    this.firstInningTotalOver,
    this.firstInningTotalWicket,
    this.secondInningTotalRun,
    this.secondInningTotalOver,
    this.secondInningTotalWicket,
    this.extras,
    this.homeTeam,
    this.awayTeam,
  });

  LiveMatchStat copyWith({
    String? matchId,
    bool? isGameFinished,
    String? finishedMessage,
    bool? isGameCanceled,
    String? userId,
    String? target,
    String? crr,
    String? rrr,
    String? homeTeamName,
    String? awayTeamName,
    bool? isFirstInning,
    int? firstInningTotalRun,
    double? firstInningTotalOver,
    int? firstInningTotalWicket,
    int? secondInningTotalRun,
    double? secondInningTotalOver,
    int? secondInningTotalWicket,
    LiveExtras? extras,
    List<LiveTeam>? homeTeam,
    List<LiveTeam>? awayTeam,
  }) =>
      LiveMatchStat(
        matchId: matchId ?? this.matchId,
        isGameFinished: isGameFinished ?? this.isGameFinished,
        finishedMessage: finishedMessage ?? this.finishedMessage,
        isGameCanceled: isGameCanceled ?? this.isGameCanceled,
        userId: userId ?? this.userId,
        target: target ?? this.target,
        crr: crr ?? this.crr,
        rrr: rrr ?? this.rrr,
        homeTeamName: homeTeamName ?? this.homeTeamName,
        awayTeamName: awayTeamName ?? this.awayTeamName,
        isFirstInning: isFirstInning ?? this.isFirstInning,
        firstInningTotalRun: firstInningTotalRun ?? this.firstInningTotalRun,
        firstInningTotalOver: firstInningTotalOver ?? this.firstInningTotalOver,
        firstInningTotalWicket:
            firstInningTotalWicket ?? this.firstInningTotalWicket,
        secondInningTotalRun: secondInningTotalRun ?? this.secondInningTotalRun,
        secondInningTotalOver:
            secondInningTotalOver ?? this.secondInningTotalOver,
        secondInningTotalWicket:
            secondInningTotalWicket ?? this.secondInningTotalWicket,
        extras: extras ?? this.extras,
        homeTeam: homeTeam ?? this.homeTeam,
        awayTeam: awayTeam ?? this.awayTeam,
      );

  factory LiveMatchStat.fromRawJson(String str) =>
      LiveMatchStat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LiveMatchStat.fromJson(Map<String, dynamic> json) => LiveMatchStat(
        matchId: json["match_id"],
        isGameFinished: json["isGameFinished"],
        finishedMessage: json["finishedMessage"],
        isGameCanceled: json["isGameCanceled"],
        userId: json["user_id"],
        target: json["target"],
        crr: json["CRR"],
        rrr: json["RRR"],
        homeTeamName: json["homeTeamName"],
        awayTeamName: json["awayTeamName"],
        isFirstInning: json["isFirstInning"],
        firstInningTotalRun: json["firstInningTotalRun"],
        firstInningTotalOver: json["firstInningTotalOver"],
        firstInningTotalWicket: json["firstInningTotalWicket"],
        secondInningTotalRun: json["secondInningTotalRun"],
        secondInningTotalOver: json["secondInningTotalOver"],
        secondInningTotalWicket: json["secondInningTotalWicket"],
        extras:
            json["extras"] == null ? null : LiveExtras.fromJson(json["extras"]),
        homeTeam: json["homeTeam"] == null
            ? []
            : List<LiveTeam>.from(
                json["homeTeam"]!.map((x) => LiveTeam.fromJson(x))),
        awayTeam: json["awayTeam"] == null
            ? []
            : List<LiveTeam>.from(
                json["awayTeam"]!.map((x) => LiveTeam.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "match_id": matchId,
        "isGameFinished": isGameFinished,
        "finishedMessage": finishedMessage,
        "isGameCanceled": isGameCanceled,
        "user_id": userId,
        "target": target,
        "CRR": crr,
        "RRR": rrr,
        "homeTeamName": homeTeamName,
        "awayTeamName": awayTeamName,
        "isFirstInning": isFirstInning,
        "firstInningTotalRun": firstInningTotalRun,
        "firstInningTotalOver": firstInningTotalOver,
        "firstInningTotalWicket": firstInningTotalWicket,
        "secondInningTotalRun": secondInningTotalRun,
        "secondInningTotalOver": secondInningTotalOver,
        "secondInningTotalWicket": secondInningTotalWicket,
        "extras": extras?.toJson(),
        "homeTeam": homeTeam == null
            ? []
            : List<dynamic>.from(homeTeam!.map((x) => x.toJson())),
        "awayTeam": awayTeam == null
            ? []
            : List<dynamic>.from(awayTeam!.map((x) => x.toJson())),
      };
}

class LiveTeam {
  final int? id;
  final String? name;
  final String? username;
  final bool? striker;
  final bool? nonStriker;
  final bool? bowler;
  final String? out;
  final LiveMatchBattingStat? matchBattingStat;
  final LiveMatchBowlingStat? matchBowlingStat;

  LiveTeam({
    this.id,
    this.name,
    this.username,
    this.striker,
    this.nonStriker,
    this.bowler,
    this.out,
    this.matchBattingStat,
    this.matchBowlingStat,
  });

  LiveTeam copyWith({
    int? id,
    String? name,
    String? username,
    bool? striker,
    bool? nonStriker,
    bool? bowler,
    String? out,
    LiveMatchBattingStat? matchBattingStat,
    LiveMatchBowlingStat? matchBowlingStat,
  }) =>
      LiveTeam(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        striker: striker ?? this.striker,
        nonStriker: nonStriker ?? this.nonStriker,
        bowler: bowler ?? this.bowler,
        out: out ?? this.out,
        matchBattingStat: matchBattingStat ?? this.matchBattingStat,
        matchBowlingStat: matchBowlingStat ?? this.matchBowlingStat,
      );

  factory LiveTeam.fromRawJson(String str) =>
      LiveTeam.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LiveTeam.fromJson(Map<String, dynamic> json) => LiveTeam(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        striker: json["striker"],
        nonStriker: json["nonStriker"],
        bowler: json["bowler"],
        out: json["out"],
        matchBattingStat: json["matchBattingStat"] == null
            ? null
            : LiveMatchBattingStat.fromJson(json["matchBattingStat"]),
        matchBowlingStat: json["matchBowlingStat"] == null
            ? null
            : LiveMatchBowlingStat.fromJson(json["matchBowlingStat"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "striker": striker,
        "nonStriker": nonStriker,
        "bowler": bowler,
        "out": out,
        "matchBattingStat": matchBattingStat?.toJson(),
        "matchBowlingStat": matchBowlingStat?.toJson(),
      };
}

class LiveMatchBattingStat {
  final int? runs;
  final int? balls;
  final int? fours;
  final int? sixes;

  LiveMatchBattingStat({
    this.runs,
    this.balls,
    this.fours,
    this.sixes,
  });

  LiveMatchBattingStat copyWith({
    int? runs,
    int? balls,
    int? fours,
    int? sixes,
  }) =>
      LiveMatchBattingStat(
        runs: runs ?? this.runs,
        balls: balls ?? this.balls,
        fours: fours ?? this.fours,
        sixes: sixes ?? this.sixes,
      );

  factory LiveMatchBattingStat.fromRawJson(String str) =>
      LiveMatchBattingStat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LiveMatchBattingStat.fromJson(Map<String, dynamic> json) =>
      LiveMatchBattingStat(
        runs: json["runs"],
        balls: json["balls"],
        fours: json["fours"],
        sixes: json["sixes"],
      );

  Map<String, dynamic> toJson() => {
        "runs": runs,
        "balls": balls,
        "fours": fours,
        "sixes": sixes,
      };
}

class LiveMatchBowlingStat {
  final int? runs;
  final int? balls;
  final int? fours;
  final int? sixes;
  final int? wides;
  final int? noBalls;
  final int? maidens;
  final int? wickets;
  final double? overs;

  LiveMatchBowlingStat({
    this.runs,
    this.balls,
    this.fours,
    this.sixes,
    this.wides,
    this.noBalls,
    this.maidens,
    this.wickets,
    this.overs,
  });

  LiveMatchBowlingStat copyWith({
    int? runs,
    int? balls,
    int? fours,
    int? sixes,
    int? wides,
    int? noBalls,
    int? maidens,
    int? wickets,
    double? overs,
  }) =>
      LiveMatchBowlingStat(
        runs: runs ?? this.runs,
        balls: balls ?? this.balls,
        fours: fours ?? this.fours,
        sixes: sixes ?? this.sixes,
        wides: wides ?? this.wides,
        noBalls: noBalls ?? this.noBalls,
        maidens: maidens ?? this.maidens,
        wickets: wickets ?? this.wickets,
        overs: overs ?? this.overs,
      );

  factory LiveMatchBowlingStat.fromRawJson(String str) =>
      LiveMatchBowlingStat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LiveMatchBowlingStat.fromJson(Map<String, dynamic> json) =>
      LiveMatchBowlingStat(
        runs: json["runs"],
        balls: json["balls"],
        fours: json["fours"],
        sixes: json["sixes"],
        wides: json["wides"],
        noBalls: json["noBalls"],
        maidens: json["maidens"],
        wickets: json["wickets"],
        overs: json["overs"],
      );

  Map<String, dynamic> toJson() => {
        "runs": runs,
        "balls": balls,
        "fours": fours,
        "sixes": sixes,
        "wides": wides,
        "noBalls": noBalls,
        "maidens": maidens,
        "wickets": wickets,
        "overs": overs,
      };
}

class LiveExtras {
  final int? byes;
  final int? legByes;
  final int? wide;
  final int? noBall;
  final int? penalty;

  LiveExtras({
    this.byes,
    this.legByes,
    this.wide,
    this.noBall,
    this.penalty,
  });

  LiveExtras copyWith({
    int? byes,
    int? legByes,
    int? wide,
    int? noBall,
    int? penalty,
  }) =>
      LiveExtras(
        byes: byes ?? this.byes,
        legByes: legByes ?? this.legByes,
        wide: wide ?? this.wide,
        noBall: noBall ?? this.noBall,
        penalty: penalty ?? this.penalty,
      );

  factory LiveExtras.fromRawJson(String str) =>
      LiveExtras.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LiveExtras.fromJson(Map<String, dynamic> json) => LiveExtras(
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
