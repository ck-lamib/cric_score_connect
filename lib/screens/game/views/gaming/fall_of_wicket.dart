import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/screens/game/widgets/gaming/fall_of_wicket_app_bar.dart';
import 'package:cric_score_connect/screens/match/enums/out.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_dropdown_textfield.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FallOfWicketScreen extends StatelessWidget {
  static const String routeName = "/fall-of-wicket-screen";

  final RxList<User> battingTeam;
  final RxList<User> currentBatters;
  final RxList<User> outBattingTeam;
  RxnString outReason = RxnString();
  String? outBatsManValue;
  String? newBatsManValue;

  FallOfWicketScreen({
    super.key,
    required this.battingTeam,
    required this.currentBatters,
    required this.outBattingTeam,
  });

  @override
  Widget build(BuildContext context) {
    var filteredBattingTeam = battingTeam.where((player) {
      // Check if the player is in currentBatters
      if (currentBatters
          .any((currentPlayer) => currentPlayer.username == player.username)) {
        return false; // Exclude currently batting player
      }
      // Check if the player is in outBattingTeam
      if (outBattingTeam
          .any((outPlayer) => outPlayer.username == player.username)) {
        // If the player is in outBattingTeam, check if their out reason is not "out.retired"
        if (player.matchBattingStats != null &&
            player.matchBattingStats!.outReason.value != Out.retired) {
          return false; // Exclude this player from the filtered list
        }
      }
      return true; // Include all other players
    }).toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(
          color: AppColors.backGroundColor,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const FallOfWicketAppBar(),
            SliverToBoxAdapter(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                          "Please select reason behind the wicket and next batter for batting.",
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.f16W600(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomDropdownTextField(
                      hint: "How Wicket fell?",
                      labelText: "How Wicket fell?",
                      hintStyle: CustomTextStyles.f16W400(
                        color: AppColors.backGroundColor,
                      ),
                      onValueChange: (value) {
                        outReason.value = value;
                      },
                      itemValue: outReason.value,
                      dropDownItemLists: OutExtension.all()
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.name,
                              child: Text(
                                e.text,
                                style: CustomTextStyles.f16W400(
                                  color: AppColors.backGroundColor,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Obx(() {
                      if (outReason.value != null) {
                        Out out = Out.values.firstWhere(
                            (element) => element.name == outReason.value);
                        if (out.requiresBatter()) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizeConfig.getSpace(),
                              CustomDropdownTextField(
                                hint: "Out Batsman",
                                labelText: "Out Batsman",
                                hintStyle: CustomTextStyles.f16W400(
                                  color: AppColors.backGroundColor,
                                ),
                                onValueChange: (value) {
                                  outBatsManValue = value;
                                },
                                itemValue: outBatsManValue,
                                dropDownItemLists: currentBatters
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
                            ],
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
                    SizeConfig.getSpace(),
                    // Filter battingTeam based on conditions
                    CustomDropdownTextField(
                      hint: "New Batsman",
                      labelText: "New Batsman",
                      itemValue: newBatsManValue,
                      onValueChange: (value) {
                        newBatsManValue = value;
                      },
                      hintStyle: CustomTextStyles.f16W400(
                        color: AppColors.backGroundColor,
                      ),
                      dropDownItemLists: filteredBattingTeam
                          .map(
                            (element) => DropdownMenuItem(
                              value: element.username,
                              child: Text(
                                "${element.name?.split(" ").first} (${element.username})",
                                style: CustomTextStyles.f16W400(
                                  color: AppColors.backGroundColor,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: CustomElevatedButton(
            title: "Done",
            onTap: () {
              //
              // return out , player that is out

              if (outReason.value == null || outReason.value!.isEmpty) {
                CustomSnackBar.info(message: "Please select wicket reason.");
                return;
              } else if (filteredBattingTeam.isEmpty) {
                //here only 2 batting member exist.
                User? outBatsman;
                try {
                  outBatsman = battingTeam.firstWhere(
                      (element) => element.username == outBatsManValue);
                } catch (_) {}

                Out outR = Out.values
                    .firstWhere((element) => element.name == outReason.value);
                if (outR.requiresBatter() && outBatsman == null) {
                  CustomSnackBar.info(message: "Please select out batsman.");
                  return;
                } else if (!(outR.requiresBatter())) {
                  outBatsman = null;
                }

                Get.back(
                  result: FallOfWicketPopArgument(
                    batterForWicket: outBatsman,
                    wicketReason: outR,
                    nextBatter: null,
                  ),
                );
              } else if (newBatsManValue == null || newBatsManValue!.isEmpty) {
                CustomSnackBar.info(message: "Please select new batsman.");
                return;
              } else {
                // print(itemValue);
                User? outBatsman;
                try {
                  outBatsman = battingTeam.firstWhere(
                      (element) => element.username == outBatsManValue);
                } catch (e) {}

                Out outR = Out.values
                    .firstWhere((element) => element.name == outReason.value);
                if (outR.requiresBatter() && outBatsman == null) {
                  CustomSnackBar.info(message: "Please select out batsman.");
                  return;
                } else if (!(outR.requiresBatter())) {
                  outBatsman = null;
                }

                User nextbatterr = battingTeam.firstWhere(
                    (element) => element.username == newBatsManValue);
                Get.back(
                  result: FallOfWicketPopArgument(
                    batterForWicket: outBatsman,
                    wicketReason: outR,
                    nextBatter: nextbatterr,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class FallOfWicketPopArgument {
  final User? batterForWicket;
  final Out wicketReason;
  final User? nextBatter;

  FallOfWicketPopArgument({
    this.batterForWicket,
    required this.wicketReason,
    this.nextBatter,
  });
}
