import 'package:cric_score_connect/common/common_app_bar.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/screens/game/controller/pickplayer/select_opening_player_controller.dart';
import 'package:cric_score_connect/screens/game/controller/team_vs_team_game_controller.dart';
import 'package:cric_score_connect/screens/game/views/gaming/gaming_screen.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_dropdown_textfield.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectOpeningPlayerScreen extends StatelessWidget {
  static const String routeName = "/select-opening-player-screen";
  SelectOpeningPlayerScreen({super.key});
  final SelectOpeningPlayerController c =
      Get.find<SelectOpeningPlayerController>();
  final TeamVsTeamGameController teamVsTeamGameController =
      Get.find<TeamVsTeamGameController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(
          color: AppColors.backGroundColor,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            const CommonSilverAppBar(
              hasLeading: true,
              title: "Select opening player",
              hasNotification: false,
              scrolledUnderElevation: 0,
              floating: false,
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Form(
                  key: c.selectOpeningPlayerFormKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizeConfig.getSpace(height: 30),
                      Obx(
                        () {
                          var strikerDropddownItemList =
                              c.availableBattingTeam.isEmpty
                                  ? (c.battingTeam
                                      .map((element) => DropdownMenuItem(
                                          value: element.username,
                                          child: Text(
                                            "${element.name?.split(" ").first} (${element.username})",
                                            style: CustomTextStyles.f16W400(
                                              color: AppColors.backGroundColor,
                                            ),
                                          )))
                                      .toList())
                                  : (c.availableBattingTeam
                                      .map((element) => DropdownMenuItem(
                                          value: element.username,
                                          child: Text(
                                            "${element.name?.split(" ").first} (${element.username})",
                                            style: CustomTextStyles.f16W400(
                                              color: AppColors.backGroundColor,
                                            ),
                                          )))
                                      .toList());

                          if (c.openingStriker.value != null &&
                              !strikerDropddownItemList.any((item) =>
                                  item.value ==
                                  c.openingStriker.value?.username)) {
                            strikerDropddownItemList.insert(
                                0,
                                DropdownMenuItem(
                                  value: c.openingStriker.value?.username,
                                  child: Text(
                                    "${c.openingStriker.value?.name?.split(" ").first} (${c.openingStriker.value?.username})",
                                    style: CustomTextStyles.f16W400(
                                      color: AppColors.backGroundColor,
                                    ),
                                  ),
                                ));
                          }
                          if (c.openingNonStriker.value != null &&
                              strikerDropddownItemList.any((item) =>
                                  item.value ==
                                  c.openingNonStriker.value?.username)) {
                            strikerDropddownItemList.removeWhere((element) =>
                                element.value ==
                                c.openingNonStriker.value?.username);
                          }

                          return CustomDropdownTextField(
                            key: UniqueKey(),
                            hint: "Striker",
                            labelText: "Striker",
                            itemValue: c.openingStriker.value?.username,
                            onValueChange: c.onChangeStrikerBatter,
                            dropDownItemLists: strikerDropddownItemList,
                          );
                        },
                      ),
                      SizeConfig.getSpace(),
                      Obx(
                        () {
                          var nonStrikerDropdownItemList =
                              c.availableBattingTeam.isEmpty
                                  ? (c.battingTeam
                                      .map((element) => DropdownMenuItem(
                                          value: element.username,
                                          child: Text(
                                            "${element.name?.split(" ").first} (${element.username})",
                                            style: CustomTextStyles.f16W400(
                                              color: AppColors.backGroundColor,
                                            ),
                                          )))
                                      .toList())
                                  : (c.availableBattingTeam
                                      .map((element) => DropdownMenuItem(
                                          value: element.username,
                                          child: Text(
                                            "${element.name?.split(" ").first} (${element.username})",
                                            style: CustomTextStyles.f16W400(
                                              color: AppColors.backGroundColor,
                                            ),
                                          )))
                                      .toList());
                          if (c.openingNonStriker.value != null &&
                              !nonStrikerDropdownItemList.any((item) =>
                                  item.value ==
                                  c.openingNonStriker.value?.username)) {
                            nonStrikerDropdownItemList.insert(
                                0,
                                DropdownMenuItem(
                                  value: c.openingNonStriker.value?.username,
                                  child: Text(
                                    "${c.openingNonStriker.value?.name?.split(" ").first} (${c.openingNonStriker.value?.username})",
                                    style: CustomTextStyles.f16W400(
                                      color: AppColors.backGroundColor,
                                    ),
                                  ),
                                ));
                          }
                          if (c.openingStriker.value != null &&
                              nonStrikerDropdownItemList.any((item) =>
                                  item.value ==
                                  c.openingStriker.value?.username)) {
                            nonStrikerDropdownItemList.removeWhere((element) =>
                                element.value ==
                                c.openingStriker.value?.username);
                          }
                          return CustomDropdownTextField(
                            key: UniqueKey(),
                            hint: "Non-Striker",
                            labelText: "Non-Striker",
                            itemValue: c.openingNonStriker.value?.username,
                            onValueChange: c.onChangeNonStrikerBatter,
                            dropDownItemLists: nonStrikerDropdownItemList,
                          );
                        },
                      ),
                      SizeConfig.getSpace(),
                      CustomDropdownTextField(
                        hint: "Opening Bowler",
                        labelText: "Opening Bowler",
                        onValueChange: c.onChangeOpeningBolwer,
                        itemValue: c.openingBowler.value?.username,
                        dropDownItemLists: c.bowlingTeam
                            .map((element) => DropdownMenuItem(
                                value: element.username,
                                child: Text(
                                  "${element.name?.split(" ").first} (${element.username})",
                                  style: CustomTextStyles.f16W400(
                                    color: AppColors.backGroundColor,
                                  ),
                                )))
                            .toList(),
                      ),
                      SizeConfig.getSpace(),
                      CustomElevatedButton(
                        title: "Next",
                        onTap: () {
                          teamVsTeamGameController.bowler = c.openingBowler;
                          teamVsTeamGameController.striker = c.openingStriker;
                          teamVsTeamGameController.nonStriker =
                              c.openingNonStriker;
                          Get.offAndToNamed(GamingScreen.routeName);
                        },
                      ),
                      SizeConfig.getSpace(height: 10),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectOpeningPlayerArgument {
  final List<User> battingTeam;
  final List<User> bowlingTeam;

  SelectOpeningPlayerArgument({
    required this.battingTeam,
    required this.bowlingTeam,
  });
}
