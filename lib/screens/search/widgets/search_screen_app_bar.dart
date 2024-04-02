import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CommonSilverAppBar(
      hasLeading: false,
      title: "Search Players",
      hasNotification: false,
      scrolledUnderElevation: 0,
      floating: false,
      pinned: true,
    );
  }
}
