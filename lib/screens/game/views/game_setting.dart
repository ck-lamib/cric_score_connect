import 'package:cric_score_connect/screens/game/controller/team_vs_team_game_controller.dart';
import 'package:cric_score_connect/screens/game/views/team_vs_team_create_game_screen.dart';
import 'package:cric_score_connect/screens/game/widgets/gamesetting/game_setting_app_bar.dart';
import 'package:cric_score_connect/screens/game/widgets/team_vs_team_game_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GameSettingScreen extends StatelessWidget {
  static const String routeName = "/game-setting-screen";
  GameSettingScreen({super.key});
  final TeamVsTeamGameController c = Get.find<TeamVsTeamGameController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const GameSettingAppBar(),
          ],
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizeConfig.getSpace(height: 30),
                CustomTextField(
                  controller: c.homeTeamController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  labelText: "Player per Team",
                  hint: "6",
                  preIconPath: Icon(
                    Icons.group,
                  ),
                  validator: Validators.checkFieldEmpty,
                ),
                SizeConfig.getSpace(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "No Ball",
                        style: CustomTextStyles.f18W600(),
                      ),
                    ),
                    Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ],
                ),
                SizeConfig.getSpace(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.backGroundColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Re-Ball",
                              style: CustomTextStyles.f18W600(),
                            ),
                          ),
                          Switch(
                            value: true,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "No Ball Run",
                              style: CustomTextStyles.f18W600(),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                                left: 10,
                                right: 10,
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "1",
                                  hintStyle: CustomTextStyles.f16W400(
                                      color: AppColors.hintTextColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizeConfig.getSpace(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Wide Ball",
                        style: CustomTextStyles.f18W600(),
                      ),
                    ),
                    Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ],
                ),
                SizeConfig.getSpace(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.backGroundColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Re-Ball",
                              style: CustomTextStyles.f18W600(),
                            ),
                          ),
                          Switch(
                            value: true,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Wide Ball Run",
                              style: CustomTextStyles.f18W600(),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                                left: 10,
                                right: 10,
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "1",
                                  hintStyle: CustomTextStyles.f16W400(
                                      color: AppColors.hintTextColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizeConfig.getSpace(),
                CustomElevatedButton(
                  title: "Save Setting",
                  onTap: () {
                    // Get.toNamed(TeamVsTeamCreateGame.routeName);
                  },
                ),
                SizeConfig.getSpace(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
