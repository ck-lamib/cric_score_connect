import 'package:cric_score_connect/models/gamestats/batting_stats.dart';
import 'package:cric_score_connect/screens/gameprofile/views/user_game_stat_tile.dart';
import 'package:flutter/material.dart';

class BattingStatsTabView extends StatelessWidget {
  const BattingStatsTabView({
    super.key,
    required this.battingStats,
  });

  final BattingStats battingStats;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 5.0,
      // childAspectRatio: 3 / 2.5,
      crossAxisCount: 4,
      shrinkWrap: true,
      children: [
        UserGameStatsTile(
          title: "MATCHES",
          data: battingStats.matches,
        ),
        UserGameStatsTile(
          title: "INNINGS",
          data: battingStats.innings,
        ),
        UserGameStatsTile(
          title: "RUNS",
          data: battingStats.runs,
        ),
        UserGameStatsTile(
          title: "AVERAGE",
          data: battingStats.average,
        ),
        UserGameStatsTile(
          title: "HIGHEST",
          data: battingStats.highest,
        ),
        UserGameStatsTile(
          title: "STRIKE RATE",
          data: battingStats.strikeRate,
        ),
        UserGameStatsTile(
          title: "FOURS",
          data: battingStats.fours,
        ),
        UserGameStatsTile(
          title: "SIXES",
          data: battingStats.sixes,
        ),
        UserGameStatsTile(
          title: "50s",
          data: battingStats.fifties,
        ),
        UserGameStatsTile(
          title: "100s",
          data: battingStats.hundreds,
        ),
      ],
    );
  }
}
