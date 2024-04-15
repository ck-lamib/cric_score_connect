import 'dart:io';

import 'package:cric_score_connect/datasource/search/search_friend_repo.dart';
import 'package:cric_score_connect/screens/friend/widgets/accepted_friend_tile.dart';
import 'package:cric_score_connect/screens/search/controller/search_controller.dart';
import 'package:cric_score_connect/screens/search/widgets/search_friend_tile.dart';
import 'package:cric_score_connect/screens/search/widgets/search_screen_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/routes/image_path.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = "/search-screen";
  SearchScreen({super.key});
  final SearchScreenController c = Get.find<SearchScreenController>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
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
            child: Obx(
              () => c.isSearching.value
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: SvgPicture.asset(
                              ImagePath.searchingImagePath,
                              alignment: Alignment.center,
                              height: height * 0.15,
                            ),
                          ),
                          SizeConfig.getSpace(),
                          Text(
                            "Please! wait. \nWe are searching for your queries",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f16W600(),
                          ),
                        ],
                      ),
                    )
                  : c.searchedUser.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: SvgPicture.asset(
                                  ImagePath.notFoundImagePath,
                                  alignment: Alignment.center,
                                  height: height * 0.15,
                                ),
                              ),
                              SizeConfig.getSpace(),
                              Text(
                                "Search user by Username, Email\n and Full name.",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f16W600(),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: c.searchedUser.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemBuilder: (context, index) {
                            return SearchFriendTile(
                              user: c.searchedUser[index],
                            );
                          },
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
