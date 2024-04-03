import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:flutter/material.dart';

class NextOverAppBar extends StatelessWidget {
  const NextOverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonSilverAppBar(
      hasLeading: true,
      title: "Next Over",
      hasNotification: false,
      scrolledUnderElevation: 0,
      floating: false,
      pinned: true,
    );
  }
}
