import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:flutter/material.dart';

class GameSettingAppBar extends StatelessWidget {
  const GameSettingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonSilverAppBar(
      hasLeading: true,
      title: "Match Setting",
      hasNotification: false,
      scrolledUnderElevation: 0,
      floating: false,
      pinned: true,
    );
  }
}
