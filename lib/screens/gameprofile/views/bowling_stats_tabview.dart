import 'package:cric_score_connect/models/gamestats/bowling_stats.dart';
import 'package:cric_score_connect/screens/gameprofile/views/user_game_stat_tile.dart';
import 'package:flutter/material.dart';

class BowlingStatsTabView extends StatelessWidget {
  const BowlingStatsTabView({
    super.key,
    required this.bowlingStats,
  });

  final BowlingStats bowlingStats;

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
          data: bowlingStats.matches,
        ),
        UserGameStatsTile(
          title: "INNINGS",
          data: bowlingStats.innings,
        ),
        UserGameStatsTile(
          title: "RUN CONCEDED",
          data: bowlingStats.runs,
        ),
        UserGameStatsTile(
          title: "OVERS",
          data: bowlingStats.overs,
        ),
        UserGameStatsTile(
          title: "STRIKE RATE",
          data: bowlingStats.strikeRate,
        ),
        UserGameStatsTile(
          title: "MAIDENS",
          data: bowlingStats.maidens,
        ),
        UserGameStatsTile(
          title: "WICKETS",
          data: bowlingStats.wickets,
        ),
        UserGameStatsTile(
          title: "Best BOWLING",
          data: bowlingStats.bBowling,
        ),
        UserGameStatsTile(
          title: "ECO. RATE",
          data: bowlingStats.ecoRate,
        ),
      ],
    );
  }
}
