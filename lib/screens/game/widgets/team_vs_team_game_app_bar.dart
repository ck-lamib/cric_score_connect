import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:flutter/material.dart';

class TeamVsTeamGameAppBar extends StatelessWidget {
  const TeamVsTeamGameAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonSilverAppBar(
      hasLeading: true,
      title: "Team Vs Team",
      hasNotification: false,
      scrolledUnderElevation: 0,
      floating: false,
      pinned: true,
    );
  }
}
