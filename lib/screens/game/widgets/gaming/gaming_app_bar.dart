import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:cric_score_connect/screens/game/controller/team_vs_team_game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GamingAppBar extends StatelessWidget {
  GamingAppBar({super.key});

  final TeamVsTeamGameController c = Get.find<TeamVsTeamGameController>();

  @override
  Widget build(BuildContext context) {
    return CommonSilverAppBar(
      hasLeading: true,
      title: "${c.homeTeamController.text} Vs ${c.awayTeamController.text}",
      hasNotification: false,
      scrolledUnderElevation: 0,
      floating: false,
      pinned: true,
    );
  }
}
