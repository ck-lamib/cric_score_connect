import 'dart:io';

import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/screens/game/controller/team_vs_team_game_controller.dart';
import 'package:cric_score_connect/screens/game/views/gaming/fall_of_wicket.dart';
import 'package:cric_score_connect/screens/game/views/gaming/next_over.dart';
import 'package:cric_score_connect/screens/game/views/team_vs_team_create_game_screen.dart';
import 'package:cric_score_connect/screens/game/widgets/gaming/gaming_app_bar.dart';
import 'package:cric_score_connect/screens/match/delivery.dart';
import 'package:cric_score_connect/screens/match/enums/extra.dart';
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
    var width = MediaQuery.sizeOf(context).width;
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
                    child: Obx(
                      () => Text(
                        // "Away Team needs 89 runs from 48 balls.",
                        "${c.isOverInProgress.value}",
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.f14W500(
                          color: AppColors.primaryColor,
                        ),
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
                              text: "(${c.overs()})",
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(
                        () => GamingRatingStat(
                          title: "Target",
                          stat: c.target.value.toString(),
                        ),
                      ),
                      Obx(
                        () => GamingRatingStat(
                          title: "C.R.R",
                          stat: c.crr.value.toString(),
                        ),
                      ),
                      Obx(
                        () => GamingRatingStat(
                          title: "R.R.R",
                          stat: c.target.value.toString(),
                        ),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Obx(
                              () => Text(
                                "* ${c.striker.value?.username}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            // child:
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(
                                "${c.striker.value?.matchBattingStats?.runs.value ?? 0}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(
                                "${c.striker.value?.matchBattingStats?.balls.value ?? 0}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(
                                "${c.striker.value?.matchBattingStats?.fours.value ?? 0}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(
                                "${c.striker.value?.matchBattingStats?.sixes.value ?? 0}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
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
                            child: Obx(
                              () => Text(
                                "${c.nonStriker.value?.username}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(
                                "${c.nonStriker.value?.matchBattingStats?.runs ?? 0}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(
                                "${c.nonStriker.value?.matchBattingStats?.balls ?? 0}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(
                                "${c.nonStriker.value?.matchBattingStats?.fours ?? 0}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(
                                "${c.nonStriker.value?.matchBattingStats?.sixes ?? 0}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
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
                            child: Obx(
                              () => Text(
                                "${c.bowler.value?.username}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(
                                "${c.bowler.value?.matchBowlingStats?.oversBowled ?? 0}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(
                                "${c.bowler.value?.matchBowlingStats?.runs.value ?? 0}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(
                                "${c.bowler.value?.matchBowlingStats?.wickets.value ?? 0}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(
                                "${c.bowler.value?.matchBowlingStats?.maidens.value ?? 0}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
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
                  padding: EdgeInsets.zero,
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
                  child: Wrap(
                    spacing: 1,
                    runSpacing: 1,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      Obx(
                        () => CheckBoxTile(
                          checkBoxTitle: "Wide",
                          checkBoxValue: c.isWideSelected.value,
                          onToggleCheckBox: c.toggleIsWideSelected,
                        ),
                      ),
                      Obx(
                        () => CheckBoxTile(
                          checkBoxTitle: "No Ball",
                          checkBoxValue: c.isNoBallSelected.value,
                          onToggleCheckBox: c.toggleIsNoBallSelected,
                        ),
                      ),
                      Obx(
                        () => CheckBoxTile(
                          checkBoxTitle: "Byes",
                          checkBoxValue: c.isByesSelected.value,
                          onToggleCheckBox: c.toggleIsByesSelected,
                        ),
                      ),
                      Obx(
                        () => CheckBoxTile(
                          checkBoxTitle: "Leg Byes",
                          checkBoxValue: c.isLegByesSelected.value,
                          onToggleCheckBox: c.toggleIsLegByesSelected,
                        ),
                      ),
                      Obx(
                        () => CheckBoxTile(
                          checkBoxTitle: "Wicket",
                          checkBoxValue: c.isWicketsSelected.value,
                          onToggleCheckBox: c.toggleIsWicketsSelected,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
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
                        ),
                      )
                    ],
                  ),

                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Expanded(
                  //           flex: 1,
                  //           child: Row(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               SizedBox(
                  //                 height: 20,
                  //                 width: 20,
                  //                 child: Obx(
                  //                   () => Checkbox(
                  //                     value: c.isWideSelected.value,
                  //                     materialTapTargetSize:
                  //                         MaterialTapTargetSize.shrinkWrap,
                  //                     onChanged: c.toggleIsWideSelected,
                  //                   ),
                  //                 ),
                  //               ),
                  //               const SizedBox(
                  //                 width: 5,
                  //               ),
                  //               Text(
                  //                 "Wide",
                  //                 maxLines: 1,
                  //                 textAlign: TextAlign.center,
                  //                 style: CustomTextStyles.f12W600(),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         Expanded(
                  //           flex: 1,
                  //           child: Row(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               SizedBox(
                  //                 height: 10,
                  //                 width: 10,
                  //                 child: Obx(
                  //                   () => Checkbox(
                  //                     value: c.isNoBallSelected.value,
                  //                     // materialTapTargetSize:
                  //                     //     MaterialTapTargetSize.shrinkWrap,
                  //                     onChanged: c.toggleIsNoBallSelected,
                  //                   ),
                  //                 ),
                  //               ),
                  //               const SizedBox(
                  //                 width: 15,
                  //               ),
                  //               Text(
                  //                 "No Ball",
                  //                 textAlign: TextAlign.center,
                  //                 style: CustomTextStyles.f12W600(),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         Expanded(
                  //           flex: 1,
                  //           child: Row(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               SizedBox(
                  //                 height: 10,
                  //                 width: 10,
                  //                 child: Obx(
                  //                   () => Checkbox(
                  //                     value: c.isByesSelected.value,
                  //                     materialTapTargetSize:
                  //                         MaterialTapTargetSize.shrinkWrap,
                  //                     onChanged: c.toggleIsByesSelected,
                  //                   ),
                  //                 ),
                  //               ),
                  //               const SizedBox(
                  //                 width: 15,
                  //               ),
                  //               Text(
                  //                 "Byes",
                  //                 textAlign: TextAlign.center,
                  //                 style: CustomTextStyles.f12W600(),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         Expanded(
                  //           flex: 1,
                  //           child: Row(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               SizedBox(
                  //                 height: 10,
                  //                 width: 10,
                  //                 child: Obx(
                  //                   () => Checkbox(
                  //                     materialTapTargetSize:
                  //                         MaterialTapTargetSize.shrinkWrap,
                  //                     value: c.isLegByesSelected.value,
                  //                     onChanged: c.toggleIsLegByesSelected,
                  //                   ),
                  //                 ),
                  //               ),
                  //               const SizedBox(
                  //                 width: 15,
                  //               ),
                  //               Text(
                  //                 "Leg Byes",
                  //                 textAlign: TextAlign.center,
                  //                 style: CustomTextStyles.f12W600(),
                  //               ),
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //     const SizedBox(
                  //       height: 5,
                  //     ),
                  //     Row(
                  //       children: [
                  //         Expanded(
                  //           flex: 2,
                  //           child: CustomElevatedButton(
                  //             title: "Wicket",
                  //             onTap: () {
                  //               Get.toNamed(FallOfWicketScreen.routeName);
                  //             },
                  //             height: 30,
                  //             padding:
                  //                 const EdgeInsets.symmetric(horizontal: 0),
                  //             textStyle: CustomTextStyles.f12W600(
                  //               color: AppColors.primaryColor,
                  //             ),
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           width: 5,
                  //         ),
                  //         Expanded(
                  //           flex: 2,
                  //           child: CustomElevatedButton(
                  //             title: "Retire",
                  //             onTap: () {
                  //               Get.toNamed(NextOverScreen.routeName);
                  //             },
                  //             height: 30,
                  //             padding:
                  //                 const EdgeInsets.symmetric(horizontal: 0),
                  //             textStyle: CustomTextStyles.f12W600(
                  //               color: AppColors.primaryColor,
                  //             ),
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           width: 5,
                  //         ),
                  //         Expanded(
                  //           flex: 2,
                  //           child: CustomElevatedButton(
                  //             title: "Swap Batsman",
                  //             onTap: () {},
                  //             height: 30,
                  //             padding:
                  //                 const EdgeInsets.symmetric(horizontal: 0),
                  //             textStyle: CustomTextStyles.f12W600(
                  //               color: AppColors.primaryColor,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     )
                  //   ],
                  // ),
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
                          AddRunTile(
                            run: 0,
                            onTap: () {
                              Delivery delivery = Delivery()..addRuns(0);
                              if (c.isWideSelected.value) {
                                delivery.addExtra(Extra.wide);
                              }
                              if (c.isNoBallSelected.value) {
                                delivery.addExtra(Extra.noBall);
                              }
                              if (c.isByesSelected.value) {
                                delivery.addExtra(Extra.bye);
                              }
                              if (c.isLegByesSelected.value) {
                                delivery.addExtra(Extra.legBye);
                              }
                              print(delivery);
                              c.recordDelivery(delivery);
                            },
                          ),
                          AddRunTile(
                            run: 1,
                            onTap: () {
                              Delivery delivery = Delivery()..addRuns(1);
                              if (c.isWideSelected.value) {
                                delivery.addExtra(Extra.wide);
                              }
                              if (c.isNoBallSelected.value) {
                                delivery.addExtra(Extra.noBall);
                              }
                              if (c.isByesSelected.value) {
                                delivery.addExtra(Extra.bye);
                              }
                              if (c.isLegByesSelected.value) {
                                delivery.addExtra(Extra.legBye);
                              }

                              print(delivery);

                              c.recordDelivery(delivery);
                            },
                          ),
                          AddRunTile(
                            run: 2,
                            onTap: () {
                              Delivery delivery = Delivery()..addRuns(2);
                              if (c.isWideSelected.value) {
                                delivery.addExtra(Extra.wide);
                              }
                              if (c.isNoBallSelected.value) {
                                delivery.addExtra(Extra.noBall);
                              }
                              if (c.isByesSelected.value) {
                                delivery.addExtra(Extra.bye);
                              }
                              if (c.isLegByesSelected.value) {
                                delivery.addExtra(Extra.legBye);
                              }

                              print(delivery);

                              c.recordDelivery(delivery);
                            },
                          ),
                          AddRunTile(
                            run: 3,
                            onTap: () {
                              Delivery delivery = Delivery()..addRuns(3);
                              if (c.isWideSelected.value) {
                                delivery.addExtra(Extra.wide);
                              }
                              if (c.isNoBallSelected.value) {
                                delivery.addExtra(Extra.noBall);
                              }
                              if (c.isByesSelected.value) {
                                delivery.addExtra(Extra.bye);
                              }
                              if (c.isLegByesSelected.value) {
                                delivery.addExtra(Extra.legBye);
                              }

                              print(delivery);

                              c.recordDelivery(delivery);
                            },
                          ),
                          AddRunTile(
                            run: 4,
                            onTap: () {
                              Delivery delivery = Delivery()..addRuns(4);
                              if (c.isWideSelected.value) {
                                delivery.addExtra(Extra.wide);
                              }
                              if (c.isNoBallSelected.value) {
                                delivery.addExtra(Extra.noBall);
                              }
                              if (c.isByesSelected.value) {
                                delivery.addExtra(Extra.bye);
                              }
                              if (c.isLegByesSelected.value) {
                                delivery.addExtra(Extra.legBye);
                              }

                              print(delivery);

                              c.recordDelivery(delivery);
                            },
                          ),
                          AddRunTile(
                            run: 5,
                            onTap: () {
                              Delivery delivery = Delivery()..addRuns(5);
                              if (c.isWideSelected.value) {
                                delivery.addExtra(Extra.wide);
                              }
                              if (c.isNoBallSelected.value) {
                                delivery.addExtra(Extra.noBall);
                              }
                              if (c.isByesSelected.value) {
                                delivery.addExtra(Extra.bye);
                              }
                              if (c.isLegByesSelected.value) {
                                delivery.addExtra(Extra.legBye);
                              }

                              print(delivery);

                              c.recordDelivery(delivery);
                            },
                          ),
                          AddRunTile(
                            run: 6,
                            onTap: () {
                              Delivery delivery = Delivery()..addRuns(6);
                              if (c.isWideSelected.value) {
                                delivery.addExtra(Extra.wide);
                              }
                              if (c.isNoBallSelected.value) {
                                delivery.addExtra(Extra.noBall);
                              }
                              if (c.isByesSelected.value) {
                                delivery.addExtra(Extra.bye);
                              }
                              if (c.isLegByesSelected.value) {
                                delivery.addExtra(Extra.legBye);
                              }

                              print(delivery);

                              c.recordDelivery(delivery);
                            },
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

class AddRunTile extends StatelessWidget {
  const AddRunTile({
    super.key,
    required this.run,
    this.onTap,
  });

  final int run;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          "$run",
          textAlign: TextAlign.center,
          style: CustomTextStyles.f24W600(
            color: AppColors.backGroundColor,
          ),
        ),
      ),
    );
  }
}

class CheckBoxTile extends StatelessWidget {
  final String checkBoxTitle;
  final bool checkBoxValue;
  final Function(bool?) onToggleCheckBox;
  const CheckBoxTile({
    super.key,
    required this.checkBoxTitle,
    required this.checkBoxValue,
    required this.onToggleCheckBox,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Container(
      height: 30,
      width: width * 0.25,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: AppColors.backGroundColor,
        //   width: 1,
        // ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            value: checkBoxValue,
            onChanged: onToggleCheckBox,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            checkBoxTitle,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: CustomTextStyles.f12W600(),
          ),
        ],
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

class BattingPlayerStat {
  final User user;
  final int runs;
  final int ballReceived;
  final int fours;
  final int sixes;
  BattingPlayerStat({
    required this.user,
    required this.runs,
    required this.ballReceived,
    required this.fours,
    required this.sixes,
  });
}

class BowlingPlayerStat {
  final User user;
  final int overs;
  final int runs;
  final int wicket;
  final int m;
  BowlingPlayerStat({
    required this.user,
    required this.overs,
    required this.runs,
    required this.wicket,
    required this.m,
  });
}
