import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:flutter/material.dart';

class FallOfWicketAppBar extends StatelessWidget {
  const FallOfWicketAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonSilverAppBar(
      hasLeading: true,
      title: "Fall of Wicket",
      hasNotification: false,
      scrolledUnderElevation: 0,
      floating: false,
      pinned: true,
    );
  }
}
