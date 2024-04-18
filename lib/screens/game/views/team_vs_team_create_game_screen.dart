import 'dart:math';

import 'package:cric_score_connect/screens/game/controller/team_vs_team_game_controller.dart';
import 'package:cric_score_connect/screens/game/views/game_setting.dart';
import 'package:cric_score_connect/screens/game/views/pickplayer/select_opening_player.dart';
import 'package:cric_score_connect/screens/game/views/selectplayer/team_vs_team_select_player.dart';
import 'package:cric_score_connect/screens/game/widgets/team_vs_team_create_game_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/datas.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/extensions.dart';
import 'package:cric_score_connect/utils/helpers/request_loader.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_date_picker.dart';
import 'package:cric_score_connect/widgets/custom/custom_dropdown_textfield.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_outline_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TeamVsTeamCreateGame extends StatelessWidget {
  static const String routeName = "/teamvsteam-create-game-";
  TeamVsTeamCreateGame({super.key});
  final TeamVsTeamGameController c = Get.find<TeamVsTeamGameController>();
  final MatchController matchController = Get.find<MatchController>();

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
            const TeamVsTeamCreateGameAppBar(),
          ],
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Form(
              key: c.createGameFormKey,
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
                              c.homeTeamController.text,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f24W600(),
                            ),
                            SizeConfig.getSpace(),
                            Obx(
                              () => CustomOutlineButton(
                                title:
                                    "Add Player (${c.homeTeamPlayer.length})",
                                padding: EdgeInsets.zero,
                                height: 40,
                                onTap: () async {
                                  int? playerCount = int.tryParse(
                                    c.totalNumberOfPlayer.text,
                                  );

                                  var data = await Get.toNamed(
                                    SelectPlayer.routeName,
                                    arguments: SelectedPlayerArgument(
                                      allGamePlayer: c.allAvailablePlayers,
                                      selectedTeamPlayer: c.homeTeamPlayer,
                                      allSelectedPlayer: [
                                        ...c.homeTeamPlayer,
                                        ...c.awayTeamPlayer
                                      ],
                                      maxPlayer: playerCount ?? 6,
                                    ),
                                  );
                                },
                              ),
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
                              c.awayTeamController.text,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.f24W600(),
                            ),
                            SizeConfig.getSpace(),
                            Obx(
                              () => CustomOutlineButton(
                                title:
                                    "Add Player (${c.awayTeamPlayer.length})",
                                padding: EdgeInsets.zero,
                                height: 40,
                                onTap: () async {
                                  int? playerCount = int.tryParse(
                                    c.totalNumberOfPlayer.text,
                                  );

                                  var data = await Get.toNamed(
                                    SelectPlayer.routeName,
                                    arguments: SelectedPlayerArgument(
                                      allGamePlayer: c.allAvailablePlayers,
                                      selectedTeamPlayer: c.awayTeamPlayer,
                                      allSelectedPlayer: [
                                        ...c.homeTeamPlayer,
                                        ...c.awayTeamPlayer
                                      ],
                                      maxPlayer: playerCount ?? 6,
                                    ),
                                  );
                                  // if (data != null &&
                                  //     data is SelectedPlayerArgument) {
                                  //   c.awayTeamPlayer.value = [];
                                  //   c.awayTeamPlayer.value =
                                  //       data.selectedTeamPlayer;
                                  // }
                                },
                              ),
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
                    controller: c.selectDateController,
                    suffixIconPath: const Icon(
                      Icons.calendar_month_outlined,
                      color: AppColors.hintTextColor,
                    ),
                    validator: Validators.checkFieldEmpty,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.datetime,
                    readOnly: true,
                    style: CustomTextStyles.f16W400(
                      color: AppColors.backGroundColor,
                    ),
                    onTap: () async {
                      DateTime? result = await CustomDatePicker().pickDate(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 1),
                      );
                      if (result != null) {
                        c.selectDateController.text =
                            result.parseDateTimeToString();
                      }
                    },
                  ),
                  SizeConfig.getSpace(),
                  CustomTextField(
                    labelText: "Select Time",
                    hint: "11:11",
                    controller: c.selectTimeController,
                    suffixIconPath: const Icon(
                      Icons.punch_clock,
                      color: AppColors.hintTextColor,
                    ),
                    validator: Validators.checkFieldEmpty,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.datetime,
                    readOnly: true,
                    style: CustomTextStyles.f16W400(
                      color: AppColors.backGroundColor,
                    ),
                    onTap: () async {
                      TimeOfDay? result = await CustomDatePicker().pickTime(
                        context: context,
                      );
                      if (result != null && context.mounted) {
                        c.selectTimeController.text = result.format(context);
                      }
                    },
                  ),
                  SizeConfig.getSpace(),
                  CustomTextField(
                    controller: c.venueController,
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
                  // CustomDropdownTextField(
                  //   hint: "Number of overs",
                  //   labelText: "Number of overs",
                  // itemValue: c.numberOfOvers,
                  //   onValueChange: (value) => c.numberOfOvers = value,
                  //   dropDownItemLists: noOfOverData
                  //       .map(
                  //         (e) => DropdownMenuItem(
                  //           value: e,
                  //           child: Text(
                  //             e,
                  //             style: CustomTextStyles.f16W400(
                  //               color: AppColors.backGroundColor,
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //       .toList(),
                  // ),
                  CustomTextField(
                    controller: c.numberOfOversController,
                    labelText: "Number of overs",
                    hint: "5",
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    textInputType: TextInputType.number,
                    validator: Validators.checkFieldEmpty,
                  ),
                  SizeConfig.getSpace(),
                  Obx(
                    () => CustomElevatedButton(
                      title: "Toss a coin",
                      onTap: c.isCoinTossed.value
                          ? () {
                              CustomSnackBar.info(
                                title: "Coin toss.",
                                message: "Already Tossed",
                              );
                            }
                          : () async {
                              RequestLoader requestLoader = RequestLoader();
                              requestLoader.show(
                                message: "Tossing",
                              );
                              await Future.delayed(const Duration(seconds: 2),
                                  () {
                                requestLoader.hide();
                                var doubleValue = Random().nextInt(9999);
                                c.isCoinTossed.value = true;
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          "It's ${doubleValue.isEven ? "Heads" : "Tails"}",
                                          textAlign: TextAlign.center,
                                          style: CustomTextStyles.f24W600(),
                                        ),
                                        actions: [
                                          CustomElevatedButton(
                                            onTap: () {
                                              Get.back();
                                            },
                                            title: "Ok",
                                          )
                                        ],
                                      );
                                    });
                              });
                            },
                    ),
                  ),
                  SizeConfig.getSpace(),
                  CustomDropdownTextField(
                    hint: "Toss Winner",
                    labelText: "Toss Winner",
                    itemValue: c.tossWinner,
                    onValueChange: (value) => c.tossWinner = value,
                    dropDownItemLists: [
                      DropdownMenuItem(
                        value: c.homeTeamController.text,
                        child: Text(
                          c.homeTeamController.text,
                          style: CustomTextStyles.f16W400(
                            color: AppColors.backGroundColor,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: c.awayTeamController.text,
                        child: Text(
                          c.awayTeamController.text,
                          style: CustomTextStyles.f16W400(
                            color: AppColors.backGroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizeConfig.getSpace(),
                  CustomDropdownTextField(
                    hint: "Opted To?",
                    labelText: "Opted To?",
                    itemValue: c.optedTo,
                    onValueChange: (value) => c.optedTo = value,
                    dropDownItemLists: optedToDaata
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: CustomTextStyles.f16W400(
                                  color: AppColors.backGroundColor,
                                ),
                              ),
                            ))
                        .toList(),
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
                          onTap: () async {
                            var homeTeamPlayerCount = c.homeTeamPlayer.length;
                            var awayTeamPlayerCount = c.awayTeamPlayer.length;

                            int? totalNumberOfPlayerCount = int.tryParse(
                              c.totalNumberOfPlayer.text,
                            );

                            if (c.createGameFormKey.currentState!.validate()) {
                              if (homeTeamPlayerCount !=
                                  totalNumberOfPlayerCount) {
                                CustomSnackBar.info(
                                    message:
                                        "${c.homeTeamController.text}'s player count should be $totalNumberOfPlayerCount. But you have $homeTeamPlayerCount.");
                              } else if (awayTeamPlayerCount !=
                                  totalNumberOfPlayerCount) {
                                CustomSnackBar.info(
                                    message:
                                        "${c.awayTeamController.text}'s player count should be $totalNumberOfPlayerCount. But you have $homeTeamPlayerCount.");
                              } else {
                                if (c.numberOfOversController.text
                                    .trim()
                                    .isEmpty) {
                                  CustomSnackBar.info(
                                      message: "Please add number of overs.");
                                } else if (c.tossWinner == null) {
                                  CustomSnackBar.info(
                                      message: "Please add toss winner.");
                                } else if (c.optedTo == null) {
                                  CustomSnackBar.info(
                                      message: "Please add opted to.");
                                } else {
                                  if (c.numberOfOversController.text
                                          .trim()
                                          .isNotEmpty &&
                                      c.tossWinner != null &&
                                      c.tossWinner!.trim().isNotEmpty &&
                                      c.optedTo != null &&
                                      c.optedTo!.trim().isNotEmpty) {
                                    //if hometeam wins the toss
                                    if (c.tossWinner ==
                                        c.homeTeamController.text) {
                                      if (c.optedTo == "Bat") {
                                        matchController.start(
                                          tossWinnerr:
                                              c.homeTeamController.text,
                                          optedToo: "Bat",
                                          battingT: c.homeTeamPlayer,
                                          bowlingT: c.awayTeamPlayer,
                                          firstInningBattingTeam:
                                              c.homeTeamController.text,
                                          firstInningBowlingTeam:
                                              c.awayTeamController.text,
                                        );

                                        // c.getInningDetail.battingTeam =
                                        //     c.homeTeamPlayer;
                                        // c.getInningDetail.bowlingTeam =
                                        //     c.awayTeamPlayer;
                                      } else {
                                        // c.getInningDetail.bowlingTeam =
                                        //     c.homeTeamPlayer;
                                        // c.getInningDetail.battingTeam =
                                        //     c.awayTeamPlayer;
                                        matchController.start(
                                          tossWinnerr:
                                              c.homeTeamController.text,
                                          optedToo: "Bowl",
                                          battingT: c.awayTeamPlayer,
                                          bowlingT: c.homeTeamPlayer,
                                          firstInningBattingTeam:
                                              c.awayTeamController.text,
                                          firstInningBowlingTeam:
                                              c.homeTeamController.text,
                                        );
                                      }
                                    } else {
                                      if (c.optedTo == "Bat") {
                                        matchController.start(
                                          tossWinnerr:
                                              c.awayTeamController.text,
                                          optedToo: "Bat",
                                          battingT: c.awayTeamPlayer,
                                          bowlingT: c.homeTeamPlayer,
                                          firstInningBattingTeam:
                                              c.awayTeamController.text,
                                          firstInningBowlingTeam:
                                              c.homeTeamController.text,
                                        );
                                        // c.getInningDetail.battingTeam =
                                        //     c.awayTeamPlayer;
                                        // c.getInningDetail.bowlingTeam =
                                        //     c.homeTeamPlayer;
                                      } else {
                                        matchController.start(
                                          tossWinnerr:
                                              c.awayTeamController.text,
                                          optedToo: "Bowl",
                                          battingT: c.homeTeamPlayer,
                                          bowlingT: c.awayTeamPlayer,
                                          firstInningBattingTeam:
                                              c.homeTeamController.text,
                                          firstInningBowlingTeam:
                                              c.awayTeamController.text,
                                        );
                                      }
                                    }

                                    var success = await c.storeMatch();
                                    if (success) {
                                      // Get.toNamed(
                                      //   SelectOpeningPlayerScreen.routeName,
                                      //   arguments: SelectOpeningPlayerArgument(
                                      //     battingTeam: matchController
                                      //         .getInningDetail.battingTeam,
                                      //     bowlingTeam: matchController
                                      //         .getInningDetail.bowlingTeam,
                                      //   ),
                                      // );

                                      Get.toNamed(
                                        SelectOpeningPlayerScreen.routeName,
                                        arguments: SelectOpeningPlayerArgument(
                                          battingTeam: matchController
                                              .getInningDetail.battingTeam,
                                          bowlingTeam: matchController
                                              .getInningDetail.bowlingTeam,
                                        ),
                                      );
                                    } else {
                                      CustomSnackBar.error(
                                        message: "Something went wrong.",
                                      );
                                      //no continue
                                    }
                                  }
                                }
                              }
                            }
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
      ),
    );
  }
}
