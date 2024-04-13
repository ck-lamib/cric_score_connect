import 'dart:convert';

class BowlingStats {
  final String? matches;
  final String? innings;
  final String? runs;
  final String? overs;
  final String? strikeRate;
  final String? maidens;
  final String? wickets;
  final String? bBowling;
  final String? ecoRate;

  BowlingStats({
    this.matches,
    this.innings,
    this.runs,
    this.overs,
    this.strikeRate,
    this.maidens,
    this.wickets,
    this.bBowling,
    this.ecoRate,
  });

  BowlingStats copyWith({
    String? matches,
    String? innings,
    String? runs,
    String? overs,
    String? strikeRate,
    String? maidens,
    String? wickets,
    String? bBowling,
    String? ecoRate,
  }) =>
      BowlingStats(
        matches: matches ?? this.matches,
        innings: innings ?? this.innings,
        runs: runs ?? this.runs,
        overs: overs ?? this.overs,
        strikeRate: strikeRate ?? this.strikeRate,
        maidens: maidens ?? this.maidens,
        wickets: wickets ?? this.wickets,
        bBowling: bBowling ?? this.bBowling,
        ecoRate: ecoRate ?? this.ecoRate,
      );

  factory BowlingStats.fromRawJson(String str) =>
      BowlingStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BowlingStats.fromJson(Map<String, dynamic> json) => BowlingStats(
        matches: json["matches"],
        innings: json["innings"],
        runs: json["runs"],
        overs: json["overs"],
        strikeRate: json["strikeRate"],
        maidens: json["maidens"],
        wickets: json["wickets"],
        bBowling: json["bBowling"],
        ecoRate: json["ecoRate"],
      );

  Map<String, dynamic> toJson() => {
        "matches": matches,
        "innings": innings,
        "runs": runs,
        "overs": overs,
        "strikeRate": strikeRate,
        "maidens": maidens,
        "wickets": wickets,
        "bBowling": bBowling,
        "ecoRate": ecoRate,
      };
}
