import 'dart:io';

import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/screens/dashboard/views/dashboard_screen.dart';
import 'package:cric_score_connect/screens/game/controller/team_vs_team_game_controller.dart';
import 'package:cric_score_connect/screens/game/views/gaming/fall_of_wicket.dart';
import 'package:cric_score_connect/screens/game/views/gaming/next_over.dart';
import 'package:cric_score_connect/screens/game/views/team_vs_team_create_game_screen.dart';
import 'package:cric_score_connect/screens/game/widgets/gaming/gaming_app_bar.dart';
import 'package:cric_score_connect/screens/match/delivery.dart';
import 'package:cric_score_connect/screens/match/enums/extra.dart';
import 'package:cric_score_connect/screens/match/enums/out.dart';
import 'package:cric_score_connect/screens/match/overs.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class GamingScreen extends StatelessWidget {
  static const String routeName = "/game-screen";
  GamingScreen({super.key});
  final TeamVsTeamGameController c = Get.find<TeamVsTeamGameController>();
  final MatchController matchController = Get.find<MatchController>();

  @override
  Widget build(BuildContext context) {
    String battingTeam = "";
    String bowlingTeam = "";

    if (matchController.optedTo == "Bat") {
      battingTeam = matchController.tossWinner == c.homeTeamController.text
          ? c.homeTeamController.text
          : c.awayTeamController.text;
      bowlingTeam = matchController.tossWinner == c.homeTeamController.text
          ? c.awayTeamController.text
          : c.homeTeamController.text;
    } else if (matchController.optedTo == "Bowl") {
      battingTeam = matchController.tossWinner == c.homeTeamController.text
          ? c.awayTeamController.text
          : c.homeTeamController.text;
      bowlingTeam = matchController.tossWinner == c.homeTeamController.text
          ? c.homeTeamController.text
          : c.awayTeamController.text;
    }

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
                    child: Obx(() {
                      var noOfOvers =
                          (int.tryParse(c.numberOfOversController.text) ?? 6);
                      var totalNoOfBalls = noOfOvers * 6;

                      var noOfBalls = totalNoOfBalls -
                          matchController.getInningDetail.totalRunTillNow.value;
                      return (matchController.isFirstInnings == false &&
                                  matchController.isSecondInnings == true)
                              .obs
                              .value
                          ? Text(
                              "$bowlingTeam needs ${c.target.value - matchController.getInningDetail.totalRunTillNow.value.toDouble()} runs from ${noOfBalls} balls.",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.primaryColor,
                              ),
                            )
                          : Text(
                              "$battingTeam is Batting against $bowlingTeam",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f14W500(
                                color: AppColors.primaryColor,
                              ),
                            );
                    }),
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
                              "${matchController.getInningDetail.totalRunTillNow.value}-${matchController.getInningDetail.totalWicketTillNow.value}",
                          style: CustomTextStyles.f32W600(
                            color: AppColors.backGroundColor,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  "(${matchController.getInningDetail.overs()})",
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
                        () {
                          var target = c.target.value;
                          return GamingRatingStat(
                            title: "Target",
                            stat:
                                matchController.getInningDetail.isFirstInning ==
                                        true
                                    ? "--:--"
                                    : target.toString(),
                          );
                        },
                      ),
                      Obx(
                        () => GamingRatingStat(
                            title: "C.R.R",
                            stat: (matchController.getInningDetail
                                        .totalRunTillNow.value ==
                                    0
                                ? "0.00"
                                : (matchController.getInningDetail
                                            .totalRunTillNow.value /
                                        (matchController.getInningDetail
                                                .currentBalls.value /
                                            6))
                                    .toStringAsFixed(2))),
                      ),
                      Obx(
                        () {
                          // Calculate the runs required to win
                          int runsRequired = c.target.value.toInt() -
                              matchController
                                  .getInningDetail.totalRunTillNow.value;

                          double noOfOvers = (double.tryParse(
                                  c.numberOfOversController.text) ??
                              6);
                          double currentOver = double.parse(
                              matchController.getInningDetail.overs());
                          var oversRemaining = noOfOvers - currentOver;

                          // If overs remaining is 0, return a default value
                          if (oversRemaining == 0.0) {
                            return GamingRatingStat(
                              title: "R.R.R",
                              stat: matchController
                                          .getInningDetail.isFirstInning ==
                                      true
                                  ? "--:--"
                                  : "0",
                            );
                          }

                          // Calculate the required run rate
                          double requiredRunRate = ((runsRequired.toDouble() /
                                      oversRemaining.toDouble()) *
                                  6) /
                              6;

                          return GamingRatingStat(
                            title: "R.R.R",
                            stat:
                                matchController.getInningDetail.isFirstInning ==
                                        true
                                    ? "--:--"
                                    : requiredRunRate.toStringAsFixed(2),
                          );
                        },
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
                                "* ${matchController.getInningDetail.striker.value?.username}",
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
                                "${matchController.getInningDetail.striker.value?.matchBattingStats?.runs.value ?? 0}",
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
                                "${matchController.getInningDetail.striker.value?.matchBattingStats?.balls.value ?? 0}",
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
                                "${matchController.getInningDetail.striker.value?.matchBattingStats?.fours.value ?? 0}",
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
                                "${matchController.getInningDetail.striker.value?.matchBattingStats?.sixes.value ?? 0}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Obx(() {
                                int? strikerRuns = matchController
                                        .getInningDetail
                                        .striker
                                        .value
                                        ?.matchBattingStats
                                        ?.runs
                                        .value ??
                                    0;
                                int strikerBalls = matchController
                                        .getInningDetail
                                        .striker
                                        .value
                                        ?.matchBattingStats
                                        ?.balls
                                        .value ??
                                    0;

                                return Text(
                                  strikerBalls == 0 && strikerRuns == 0
                                      ? "0.0"
                                      : ((strikerRuns / strikerBalls) * 100)
                                          .toStringAsFixed(0),
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyles.f14W500(
                                    color: AppColors.hintTextColor,
                                  ),
                                );
                              })),
                        ],
                      ),
                      SizeConfig.getSpace(height: 5),
                      Obx(
                        () => matchController
                                    .getInningDetail.striker.value?.username ==
                                matchController
                                    .getInningDetail.nonStriker.value?.username
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Obx(
                                      () => Text(
                                        "${matchController.getInningDetail.nonStriker.value?.username}",
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
                                        "${matchController.getInningDetail.nonStriker.value?.matchBattingStats?.runs ?? 0}",
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
                                        "${matchController.getInningDetail.nonStriker.value?.matchBattingStats?.balls ?? 0}",
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
                                        "${matchController.getInningDetail.nonStriker.value?.matchBattingStats?.fours ?? 0}",
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
                                        "${matchController.getInningDetail.nonStriker.value?.matchBattingStats?.sixes ?? 0}",
                                        textAlign: TextAlign.center,
                                        style: CustomTextStyles.f14W500(
                                          color: AppColors.hintTextColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Obx(() {
                                      int? nonStrikerRuns = matchController
                                              .getInningDetail
                                              .nonStriker
                                              .value
                                              ?.matchBattingStats
                                              ?.runs
                                              .value ??
                                          0;
                                      int nonStrikerBalls = matchController
                                              .getInningDetail
                                              .nonStriker
                                              .value
                                              ?.matchBattingStats
                                              ?.balls
                                              .value ??
                                          0;

                                      return Text(
                                        nonStrikerBalls == 0 &&
                                                nonStrikerRuns == 0
                                            ? "0.0"
                                            : ((nonStrikerRuns /
                                                        nonStrikerBalls) *
                                                    100)
                                                .toStringAsFixed(0),
                                        textAlign: TextAlign.center,
                                        style: CustomTextStyles.f14W500(
                                          color: AppColors.hintTextColor,
                                        ),
                                      );
                                    }),
                                  ),
                                ],
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
                                "${matchController.getInningDetail.bowler.value?.username}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(
                                "${matchController.getInningDetail.bowler.value?.matchBowlingStats?.oversBowled ?? 0}",
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
                                "${matchController.getInningDetail.bowler.value?.matchBowlingStats?.runs.value ?? 0}",
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
                                "${matchController.getInningDetail.bowler.value?.matchBowlingStats?.wickets.value ?? 0}",
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
                                "${matchController.getInningDetail.bowler.value?.matchBowlingStats?.maidens.value ?? 0}",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(() {
                              double? totalRunsConceded = matchController
                                      .getInningDetail
                                      .bowler
                                      .value
                                      ?.matchBowlingStats
                                      ?.runs
                                      .value
                                      .toDouble() ??
                                  0.0;
                              double totalOversBowled = double.parse(
                                Over.overs(matchController
                                        .getInningDetail
                                        .bowler
                                        .value
                                        ?.matchBowlingStats
                                        ?.balls
                                        .value ??
                                    0),
                              );

                              return Text(
                                totalRunsConceded == 0 && totalOversBowled == 0
                                    ? "0.0"
                                    : ((totalRunsConceded / totalOversBowled))
                                        .toStringAsFixed(0),
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f14W500(
                                  color: AppColors.hintTextColor,
                                ),
                              );
                            }),
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
                                title: "Extra",
                                onTap: () {
                                  // Get.toNamed(NextOverScreen.routeName);
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        margin: const EdgeInsets.fromLTRB(
                                          12,
                                          20,
                                          12,
                                          50,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              'Extras',
                                              style: CustomTextStyles.f18W600(),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Byes",
                                                    textAlign: TextAlign.center,
                                                    style: CustomTextStyles
                                                        .f14W500(
                                                      color: AppColors
                                                          .hintTextColor,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Leg-Byes",
                                                    textAlign: TextAlign.center,
                                                    style: CustomTextStyles
                                                        .f14W500(
                                                      color: AppColors
                                                          .hintTextColor,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Wide",
                                                    textAlign: TextAlign.center,
                                                    style: CustomTextStyles
                                                        .f14W500(
                                                      color: AppColors
                                                          .hintTextColor,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "No-Ball",
                                                    textAlign: TextAlign.center,
                                                    style: CustomTextStyles
                                                        .f14W500(
                                                      color: AppColors
                                                          .hintTextColor,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Penalty",
                                                    textAlign: TextAlign.center,
                                                    style: CustomTextStyles
                                                        .f14W500(
                                                      color: AppColors
                                                          .hintTextColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    matchController
                                                        .getInningDetail
                                                        .currentByes
                                                        .value
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: CustomTextStyles
                                                        .f14W500(
                                                      color: AppColors
                                                          .hintTextColor,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    matchController
                                                        .getInningDetail
                                                        .currentLegByes
                                                        .value
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: CustomTextStyles
                                                        .f14W500(
                                                      color: AppColors
                                                          .hintTextColor,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    matchController
                                                        .getInningDetail
                                                        .currentWides
                                                        .value
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: CustomTextStyles
                                                        .f14W500(
                                                      color: AppColors
                                                          .hintTextColor,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    matchController
                                                        .getInningDetail
                                                        .currentNoBalls
                                                        .value
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: CustomTextStyles
                                                        .f14W500(
                                                      color: AppColors
                                                          .hintTextColor,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    matchController
                                                        .getInningDetail
                                                        .currentPenalty
                                                        .value
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: CustomTextStyles
                                                        .f14W500(
                                                      color: AppColors
                                                          .hintTextColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
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
                                onTap: () {
                                  matchController.getInningDetail
                                      .changeStrike();
                                },
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
                            c: c,
                            matchController: matchController,
                          ),
                          AddRunTile(
                            run: 1,
                            c: c,
                            matchController: matchController,
                          ),
                          AddRunTile(
                            run: 2,
                            c: c,
                            matchController: matchController,
                          ),
                          AddRunTile(
                            run: 3,
                            c: c,
                            matchController: matchController,
                          ),
                          AddRunTile(
                            run: 4,
                            c: c,
                            matchController: matchController,
                          ),
                          AddRunTile(
                            run: 5,
                            c: c,
                            matchController: matchController,
                          ),
                          AddRunTile(
                            run: 6,
                            c: c,
                            matchController: matchController,
                          ),
                          GestureDetector(
                            onTap: () async {
                              TextEditingController runEditingController =
                                  TextEditingController(text: "0");
                              var result = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Penalty runs?"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomTextField(
                                            controller: runEditingController,
                                            textInputAction:
                                                TextInputAction.done,
                                            textInputType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                            ],
                                            labelText: "Penalty runs",
                                            hint: "0",
                                            validator:
                                                Validators.checkFieldEmpty,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back(result: false);
                                          },
                                          child: const Text(
                                            "Cancel",
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back(result: true);
                                          },
                                          child: const Text(
                                            "Ok",
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                              if (result != null && result) {
                                int? runs =
                                    int.tryParse(runEditingController.text);
                                Delivery delivery = Delivery()
                                  ..addRuns(runs ?? 0);

                                matchController.getInningDetail
                                    .addPenalty(delivery);
                                c.checkBoxReset();
                                //call the method here
                              }
                            },
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
                                "...",
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.f24W600(
                                  color: AppColors.backGroundColor,
                                ),
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
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Cancel the match!"),
                                        content: const Text(
                                            "Are you sure you want to cancel the match?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text(
                                              "No",
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.offNamedUntil(
                                                  DashboardScreen.routeName,
                                                  (route) => false);
                                            },
                                            child: const Text(
                                              "Yes",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
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
    required this.c,
    required this.matchController,
  });

  final int run;
  final TeamVsTeamGameController c;
  final MatchController matchController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (c.isWicketsSelected.value) {
          // get wicket reason and new batter;
          var result = await showDialog(
            context: context,
            builder: (context) {
              return FallOfWicketScreen(
                battingTeam: matchController.getInningDetail.battingTeam,
                currentBatters: [
                  matchController.getInningDetail.striker.value!,
                  matchController.getInningDetail.nonStriker.value!
                ].obs,
                outBattingTeam: matchController.getInningDetail.outBattingTeam,
              );
            },
          );

          if (result != null && result is FallOfWicketPopArgument) {
            Delivery delivery = Delivery()..addRuns(run);
            matchController.getInningDetail.nextBatsman.value =
                result.nextBatter;
            delivery.out = result.wicketReason;
            if (delivery.out.requiresBatter()) {
              delivery.batter = result.batterForWicket;
              if (delivery.batter == null) {
                delivery.out = Out.none;
              }
            }
            if (delivery.out != Out.none) {
              delivery.finshAddOut();
            }
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
            matchController.getInningDetail.recordDelivery(delivery);
            c.checkBoxReset();
          } else {
            CustomSnackBar.error(
              title: "Missing fields",
              message: "Please add wickets reason.",
            );
            return;
          }
        } else {
          Delivery delivery = Delivery()..addRuns(run);
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
          matchController.getInningDetail.recordDelivery(delivery);
          c.checkBoxReset();
        }
      },
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
