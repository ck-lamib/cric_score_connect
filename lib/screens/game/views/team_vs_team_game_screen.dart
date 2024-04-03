import 'package:cric_score_connect/screens/game/controller/team_vs_team_game_controller.dart';
import 'package:cric_score_connect/screens/game/views/team_vs_team_create_game_screen.dart';
import 'package:cric_score_connect/screens/game/widgets/team_vs_team_game_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamVsTeamGameScreen extends StatelessWidget {
  static const String routeName = "/teamvsteam-game-screen";
  TeamVsTeamGameScreen({super.key});
  final TeamVsTeamGameController c = Get.find<TeamVsTeamGameController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const TeamVsTeamGameAppBar(),
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
                  labelText: "Home Team",
                  hint: "Home Team",
                  preIconPath: Icon(
                    Icons.diversity_2_rounded,
                  ),
                  validator: Validators.checkFieldEmpty,
                ),
                SizeConfig.getSpace(),
                CustomTextField(
                  controller: c.awayTeamController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  labelText: "Away Team",
                  hint: "Away Team",
                  preIconPath: Icon(
                    Icons.diversity_2_rounded,
                  ),
                  validator: Validators.checkFieldEmpty,
                ),
                SizeConfig.getSpace(),
                CustomElevatedButton(
                  title: "Next",
                  onTap: () {
                    Get.toNamed(TeamVsTeamCreateGame.routeName);
                  },
                ),
                SizeConfig.getSpace(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "You have ",
                      style: CustomTextStyles.f14W400(
                        color: AppColors.hintTextColor,
                      ),
                      children: [
                        TextSpan(
                          text: "3*",
                          style: CustomTextStyles.f14W400(
                            color: AppColors.backGroundColor,
                          ),
                        ),
                        const TextSpan(
                          text: "  remaining Team vs Team Match Credits.",
                        ),
                      ],
                    ),
                  ),
                ),
                SizeConfig.getSpace(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: CustomTextStyles.f14W400(
                        color: AppColors.hintTextColor,
                      ),
                      children: [
                        TextSpan(
                            text: "Click Here",
                            style: CustomTextStyles.f14W400(
                              color: AppColors.backGroundColor,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                        const TextSpan(
                          text: "  to pay via Khalti.",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
