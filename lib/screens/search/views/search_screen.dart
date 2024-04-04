import 'dart:io';

import 'package:cric_score_connect/screens/friend/widgets/friend_tile.dart';
import 'package:cric_score_connect/screens/search/controller/search_controller.dart';
import 'package:cric_score_connect/screens/search/widgets/search_screen_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = "/search-screen";
  SearchScreen({super.key});
  final SearchScreenController c = Get.find<SearchScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 0),
        child: Container(
          color: AppColors.backGroundColor,
        ),
      ),
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
                child: CustomTextField(
                  controller: c.searchTextController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.name,
                  preIconPath: const Icon(Icons.search_rounded),
                  labelText: "Search by username",
                  hint: "Search by username",
                  onValueChange: c.onSearchFriend,
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
