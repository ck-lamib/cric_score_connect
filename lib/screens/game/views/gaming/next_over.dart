import 'dart:io';

import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/screens/game/widgets/gaming/next_over_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_dropdown_textfield.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextOverScreen extends StatelessWidget {
  static const String routeName = "/next-over-screen";
  final RxList<User> bowlingTeam;
  final User currentBowler;
  NextOverScreen({
    super.key,
    required this.bowlingTeam,
    required this.currentBowler,
  });

  String? itemValue;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        if (itemValue == null || itemValue!.isEmpty) {
          CustomSnackBar.info(
              message: "Please select Bowler to bowl for the next over.");
          return;
        } else {
          print(itemValue);
          User user = bowlingTeam
              .firstWhere((element) => element.username == itemValue);
          Get.back(result: user);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: Container(
            color: AppColors.backGroundColor,
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const NextOverAppBar(),
              SliverToBoxAdapter(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
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
                            "Please select Bowler to bowl for the next over.",
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
                      Obx(
                        () {
                          var bowlerDropdownItemList = bowlingTeam
                              .map((element) => DropdownMenuItem(
                                  value: element.username,
                                  child: Text(
                                    "${element.name?.split(" ").first} (${element.username})",
                                    style: CustomTextStyles.f16W400(
                                      color: AppColors.backGroundColor,
                                    ),
                                  )))
                              .toList();

                          bowlerDropdownItemList.removeWhere((element) =>
                              element.value == currentBowler.username);

                          return CustomDropdownTextField(
                            key: UniqueKey(),
                            hint: "Bowler",
                            labelText: "Bowler",
                            itemValue: itemValue,
                            onValueChange: (e) {
                              itemValue = e;
                            },
                            dropDownItemLists: bowlerDropdownItemList,
                          );
                        },
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
                if (itemValue == null || itemValue!.isEmpty) {
                  CustomSnackBar.info(
                      message:
                          "Please select Bowler to bowl for the next over.");
                  return;
                } else {
                  print(itemValue);
                  User user = bowlingTeam
                      .firstWhere((element) => element.username == itemValue);
                  Get.back(result: user);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
