import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:flutter/material.dart';

class FriendAppBar extends StatelessWidget {
  const FriendAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CommonSilverAppBar(
      hasLeading: false,
      title: "Friends",
      hasNotification: false,
      scrolledUnderElevation: 0,
      floating: false,
      pinned: true,
    );
  }
}
