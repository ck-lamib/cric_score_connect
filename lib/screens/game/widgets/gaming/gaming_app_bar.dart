import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:flutter/material.dart';

class GamingAppBar extends StatelessWidget {
  const GamingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonSilverAppBar(
      hasLeading: true,
      title: "Home Team Vs Away Team",
      hasNotification: false,
      scrolledUnderElevation: 0,
      floating: false,
      pinned: true,
    );
  }
}
