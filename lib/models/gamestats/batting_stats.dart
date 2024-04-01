import 'dart:convert';

class BattingStats {
  final String? matches;
  final String? innings;
  final String? runs;
  final String? average;
  final String? highest;
  final String? strikeRate;
  final String? fours;
  final String? sixes;
  final String? fifties;
  final String? hundreds;

  BattingStats({
    this.matches,
    this.innings,
    this.runs,
    this.average,
    this.highest,
    this.strikeRate,
    this.fours,
    this.sixes,
    this.fifties,
    this.hundreds,
  });

  BattingStats copyWith({
    String? matches,
    String? innings,
    String? runs,
    String? average,
    String? highest,
    String? strikeRate,
    String? fours,
    String? sixes,
    String? fifties,
    String? hundreds,
  }) =>
      BattingStats(
        matches: matches ?? this.matches,
        innings: innings ?? this.innings,
        runs: runs ?? this.runs,
        average: average ?? this.average,
        highest: highest ?? this.highest,
        strikeRate: strikeRate ?? this.strikeRate,
        fours: fours ?? this.fours,
        sixes: sixes ?? this.sixes,
        fifties: fifties ?? this.fifties,
        hundreds: hundreds ?? this.hundreds,
      );

  factory BattingStats.fromRawJson(String str) =>
      BattingStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BattingStats.fromJson(Map<String, dynamic> json) => BattingStats(
        matches: json["matches"],
        innings: json["innings"],
        runs: json["runs"],
        average: json["average"],
        highest: json["highest"],
        strikeRate: json["strikeRate"],
        fours: json["fours"],
        sixes: json["sixes"],
        fifties: json["fifties"],
        hundreds: json["hundreds"],
      );

  Map<String, dynamic> toJson() => {
        "matches": matches,
        "innings": innings,
        "runs": runs,
        "average": average,
        "highest": highest,
        "strikeRate": strikeRate,
        "fours": fours,
        "sixes": sixes,
        "fifties": fifties,
        "hundreds": hundreds,
      };
}
