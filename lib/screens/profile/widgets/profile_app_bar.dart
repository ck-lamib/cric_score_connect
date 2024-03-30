import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        CommonSilverAppBar(
          hasLeading: false,
          title: "Profile",
          hasNotification: false,
          scrolledUnderElevation: 0,
          floating: false,
          pinned: true,
        ),
      ],
    );
  }
}
