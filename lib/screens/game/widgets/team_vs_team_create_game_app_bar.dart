import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:flutter/material.dart';

class TeamVsTeamCreateGameAppBar extends StatelessWidget {
  const TeamVsTeamCreateGameAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonSilverAppBar(
      hasLeading: true,
      title: "Create Game",
      hasNotification: false,
      scrolledUnderElevation: 0,
      floating: false,
      pinned: true,
    );
  }
}
