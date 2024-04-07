import 'dart:io';

import 'package:cric_score_connect/screens/game/controller/team_vs_team_game_controller.dart';
import 'package:cric_score_connect/screens/game/views/gaming/fall_of_wicket.dart';
import 'package:cric_score_connect/screens/game/views/gaming/next_over.dart';
import 'package:cric_score_connect/screens/game/views/team_vs_team_create_game_screen.dart';
import 'package:cric_score_connect/screens/game/widgets/gaming/gaming_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GamingScreen extends StatelessWidget {
  static const String routeName = "/game-screen";
  GamingScreen({super.key});
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
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            GamingAppBar(),
          ],
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: ListView(
              shrinkWrap: true,
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  color: Colors.green,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    child: Text(
                      "Away Team needs 89 runs from 48 balls.",
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.f14W500(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizeConfig.getSpace(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => RichText(
                        text: TextSpan(
                          text:
                              "${c.totalRunTillNow.value}-${c.totalWicketTillNow.value}",
                          style: CustomTextStyles.f32W600(
                            color: AppColors.backGroundColor,
                          ),
                          children: [
                            TextSpan(
                              text: "(2.0)",
                              style: CustomTextStyles.f18W600(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Match Code: ",
                          style: CustomTextStyles.f14W500(
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        Text(
                          "#321F",
                          style: CustomTextStyles.f14W500(
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const InkWell(
                          splashFactory: InkRipple.splashFactory,
                          child: Icon(
                            Icons.copy_rounded,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizeConfig.getSpace(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 5,
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GamingRatingStat(
                        title: "Target",
                      ),
                      GamingRatingStat(
                        title: "C.R.R",
                      ),
                      GamingRatingStat(
                        title: "R.R.R",
                      ),
                    ],
                  ),
                ),
                SizeConfig.getSpace(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 5,
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
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Batsman",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Runs",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Ball",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "4s",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "6s",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "SR",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Striker*",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "6",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "6",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "1",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "0",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "100",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizeConfig.getSpace(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Striker*",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "6",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "6",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "1",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "0",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "100",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizeConfig.getSpace(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 5,
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
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Bowler",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Overs",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Run",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "W",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "M",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "ER",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Bowler Name",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "6",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "6",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "1",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "0",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "100",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizeConfig.getSpace(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
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
                  child: Row(
                    children: [
                      Text(
                        "This Over:",
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.f14W500(),
                      ),
                      ...List.filled(
                        6,
                        Container(
                          height: 15,
                          width: 15,
                          margin: const EdgeInsets.only(
                            left: 15,
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
                        ),
                      ),
                    ],
                  ),
                ),
                SizeConfig.getSpace(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  alignment: Alignment.center,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Checkbox(
                                    value: true,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Wide",
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyles.f12W600(),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 0,
                                  width: 0,
                                  child: Checkbox(
                                    value: true,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "No Ball",
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyles.f12W600(),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 0,
                                  width: 0,
                                  child: Checkbox(
                                    value: true,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Byes",
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyles.f12W600(),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 0,
                                  width: 0,
                                  child: Checkbox(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    value: true,
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Leg Byes",
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyles.f12W600(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CustomElevatedButton(
                              title: "Wicket",
                              onTap: () {
                                Get.toNamed(FallOfWicketScreen.routeName);
                              },
                              height: 30,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              textStyle: CustomTextStyles.f12W600(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: CustomElevatedButton(
                              title: "Retire",
                              onTap: () {
                                Get.toNamed(NextOverScreen.routeName);
                              },
                              height: 30,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              textStyle: CustomTextStyles.f12W600(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: CustomElevatedButton(
                              title: "Swap Batsman",
                              onTap: () {},
                              height: 30,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              textStyle: CustomTextStyles.f12W600(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizeConfig.getSpace(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  alignment: Alignment.center,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.backGroundColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "0",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f24W600(
                                color: AppColors.backGroundColor,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.backGroundColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "1",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f24W600(
                                color: AppColors.backGroundColor,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.backGroundColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "2",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f24W600(
                                color: AppColors.backGroundColor,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.backGroundColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "3",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f24W600(
                                color: AppColors.backGroundColor,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.backGroundColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "4",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f24W600(
                                color: AppColors.backGroundColor,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.backGroundColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "5",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f24W600(
                                color: AppColors.backGroundColor,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.backGroundColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "6",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f24W600(
                                color: AppColors.backGroundColor,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.backGroundColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "...",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f24W600(
                                color: AppColors.backGroundColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CustomElevatedButton(
                              title: "Undo",
                              onTap: () {},
                              height: 30,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              textStyle: CustomTextStyles.f12W600(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(
                              width: 5,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: CustomElevatedButton(
                              title: "Cancel Match",
                              onTap: () {},
                              height: 30,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              textStyle: CustomTextStyles.f12W600(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GamingRatingStat extends StatelessWidget {
  final String title;
  final String? stat;
  const GamingRatingStat({
    super.key,
    required this.title,
    this.stat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          stat ?? "--:--",
          style: CustomTextStyles.f18W400(
            color: AppColors.backGroundColor,
          ),
        ),
        Text(
          title,
          style: CustomTextStyles.f14W400(
            color: AppColors.backGroundColor,
          ),
        )
      ],
    );
  }
}
