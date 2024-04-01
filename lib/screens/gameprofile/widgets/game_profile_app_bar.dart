import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:cric_score_connect/screens/gameprofile/controller/game_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameProfileAppBar extends StatelessWidget {
  GameProfileAppBar({
    super.key,
  });

  final GameProfileController c = Get.find<GameProfileController>();

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        CommonSilverAppBar(
          hasLeading: true,
          title: "Game Profile",
          hasNotification: false,
          scrolledUnderElevation: 0,
          floating: false,
          pinned: true,
        ),
      ],
    );
  }
}
