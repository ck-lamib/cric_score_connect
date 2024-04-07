import 'package:cric_score_connect/common/common_app_bar.dart';
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
  final TeamVsTeamGameController c = Get.find<TeamVsTeamGameController>();

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

                          if (c.striker != null &&
                              !strikerDropddownItemList.any((item) =>
                                  item.value == c.striker!.username)) {
                            strikerDropddownItemList.insert(
                                0,
                                DropdownMenuItem(
                                  value: c.striker!.username,
                                  child: Text(
                                    "${c.striker!.name?.split(" ").first} (${c.striker!.username})",
                                    style: CustomTextStyles.f16W400(
                                      color: AppColors.backGroundColor,
                                    ),
                                  ),
                                ));
                          }
                          if (c.nonStriker != null &&
                              strikerDropddownItemList.any((item) =>
                                  item.value == c.nonStriker!.username)) {
                            strikerDropddownItemList.removeWhere((element) =>
                                element.value == c.nonStriker!.username);
                          }

                          return CustomDropdownTextField(
                            key: UniqueKey(),
                            hint: "Striker",
                            labelText: "Striker",
                            itemValue: c.striker?.username,
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
                          if (c.nonStriker != null &&
                              !nonStrikerDropdownItemList.any((item) =>
                                  item.value == c.nonStriker!.username)) {
                            nonStrikerDropdownItemList.insert(
                                0,
                                DropdownMenuItem(
                                  value: c.nonStriker!.username,
                                  child: Text(
                                    "${c.nonStriker!.name?.split(" ").first} (${c.nonStriker!.username})",
                                    style: CustomTextStyles.f16W400(
                                      color: AppColors.backGroundColor,
                                    ),
                                  ),
                                ));
                          }
                          if (c.striker != null &&
                              nonStrikerDropdownItemList.any((item) =>
                                  item.value == c.striker!.username)) {
                            nonStrikerDropdownItemList.removeWhere((element) =>
                                element.value == c.striker!.username);
                          }
                          return CustomDropdownTextField(
                            key: UniqueKey(),
                            hint: "Non-Striker",
                            labelText: "Non-Striker",
                            itemValue: c.nonStriker?.username,
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
                        itemValue: c.bowler?.username,
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
                          Get.toNamed(GamingScreen.routeName);
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
