import 'package:cric_score_connect/screens/friend/widgets/friend_tile.dart';
import 'package:cric_score_connect/screens/search/widgets/search_screen_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = "/search-screen";
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const SearchAppBar(),
            SliverAppBar(
              pinned: true,
              scrolledUnderElevation: 0,
              collapsedHeight: kToolbarHeight * 1.5,
              expandedHeight: kToolbarHeight * 1.5,
              flexibleSpace: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: const CustomTextField(
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.name,
                  preIconPath: Icon(Icons.search_rounded),
                  labelText: "Search by username",
                  hint: "Search by username",
                ),
              ),
            ),
          ],
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: ListView(
              shrinkWrap: true,
              children: [
                FriendTile(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
