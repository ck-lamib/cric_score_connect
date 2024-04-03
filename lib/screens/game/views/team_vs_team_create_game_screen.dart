import 'package:cric_score_connect/screens/game/controller/team_vs_team_game_controller.dart';
import 'package:cric_score_connect/screens/game/views/game_setting.dart';
import 'package:cric_score_connect/screens/game/views/gaming/gaming_screen.dart';
import 'package:cric_score_connect/screens/game/widgets/team_vs_team_create_game_app_bar.dart';
import 'package:cric_score_connect/screens/game/widgets/team_vs_team_game_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_date_picker.dart';
import 'package:cric_score_connect/widgets/custom/custom_dropdown_textfield.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_outline_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TeamVsTeamCreateGame extends StatelessWidget {
  static const String routeName = "/teamvsteam-create-game-";
  TeamVsTeamCreateGame({super.key});
  final TeamVsTeamGameController c = Get.find<TeamVsTeamGameController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const TeamVsTeamCreateGameAppBar(),
          ],
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizeConfig.getSpace(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Home Team",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f24W600(),
                          ),
                          SizeConfig.getSpace(),
                          CustomOutlineButton(
                            title: "Add Player",
                            padding: EdgeInsets.zero,
                            height: 40,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Vs",
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.f24W600(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Away Team",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.f24W600(),
                          ),
                          SizeConfig.getSpace(),
                          CustomOutlineButton(
                            title: "Add Player",
                            padding: EdgeInsets.zero,
                            height: 40,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizeConfig.getSpace(),
                CustomTextField(
                  labelText: "Select Date",
                  hint: "2024-07-07",
                  suffixIconPath: const Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.hintTextColor,
                  ),
                  validator: Validators.checkFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.datetime,
                  readOnly: true,
                  onTap: () async {
                    DateTime? result = await CustomDatePicker().pickDate(
                      context: context,
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                    if (result != null) {}
                  },
                ),
                SizeConfig.getSpace(),
                CustomTextField(
                  labelText: "Select Time",
                  hint: "11:11",
                  suffixIconPath: const Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.hintTextColor,
                  ),
                  validator: Validators.checkFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.datetime,
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? result = await CustomDatePicker().pickTime(
                      context: context,
                    );
                    if (result != null) {
                      // print(result);
                    }
                  },
                ),
                SizeConfig.getSpace(),
                CustomTextField(
                  controller: c.awayTeamController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  labelText: "Venue",
                  hint: "Pokhara Stadium",
                  suffixIconPath: const Icon(
                    Icons.pin_drop_outlined,
                    color: AppColors.hintTextColor,
                  ),
                  validator: Validators.checkFieldEmpty,
                ),
                SizeConfig.getSpace(),
                // Row(
                //   children: [
                //     Text(
                //       "Number of Overs:",
                //       style: CustomTextStyles.f16W600(),
                //     ),
                //     ,
                //   ],
                // ),
                const CustomDropdownTextField(
                  hint: "Number of overs",
                  labelText: "Number of overs",
                  dropDownItemLists: [
                    DropdownMenuItem(
                      value: "5",
                      child: Text("5"),
                    ),
                    DropdownMenuItem(
                      value: "10",
                      child: Text("10"),
                    ),
                    DropdownMenuItem(
                      value: "15",
                      child: Text("15"),
                    ),
                  ],
                ),
                SizeConfig.getSpace(),
                const CustomDropdownTextField(
                  hint: "Toss Winner",
                  labelText: "Toss Winner",
                  dropDownItemLists: [
                    DropdownMenuItem(
                      value: "Home Team",
                      child: Text("Home Team"),
                    ),
                    DropdownMenuItem(
                      value: "Away Team",
                      child: Text("Away Team"),
                    )
                  ],
                ),
                SizeConfig.getSpace(),
                const CustomDropdownTextField(
                  hint: "Opted To?",
                  labelText: "Opted To?",
                  dropDownItemLists: [
                    DropdownMenuItem(
                      value: "Bat",
                      child: Text("Bat"),
                    ),
                    DropdownMenuItem(
                      value: "Bowl",
                      child: Text("Bowl"),
                    )
                  ],
                ),
                SizeConfig.getSpace(),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(GameSettingScreen.routeName);
                        },
                        child: Text(
                          "Advance Setting",
                          style: CustomTextStyles.f16W400(
                            color: AppColors.backGroundColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: CustomElevatedButton(
                        title: "Next",
                        onTap: () {
                          Get.toNamed(GamingScreen.routeName);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
