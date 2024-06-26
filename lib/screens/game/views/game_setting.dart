import 'package:cric_score_connect/screens/game/controller/team_vs_team_game_controller.dart';
import 'package:cric_score_connect/screens/game/widgets/gamesetting/game_setting_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class GameSettingScreen extends StatelessWidget {
  static const String routeName = "/game-setting-screen";
  GameSettingScreen({super.key});
  final TeamVsTeamGameController c = Get.find<TeamVsTeamGameController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        if (c.gameSettingFormKey.currentState!.validate()) {
          Navigator.of(context).pop();
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
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const GameSettingAppBar(),
            ],
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Form(
                key: c.gameSettingFormKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizeConfig.getSpace(height: 30),
                    CustomTextField(
                      controller: c.totalNumberOfPlayer,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      labelText: "Player per Team",
                      hint: "4",
                      preIconPath: const Icon(
                        Icons.group,
                      ),
                      validator: (contentField) {
                        var value = Validators.checkFieldEmpty(contentField);
                        if (value != null) {
                          return value;
                        } else {
                          var intValue = int.parse(contentField!);
                          if (intValue >= 4 && intValue <= 11) {
                            return null;
                          } else {
                            return "Player should be between 4 and 11";
                          }
                        }
                      },
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
                        Obx(
                          () => Switch(
                            value: c.hasNoBall.value,
                            onChanged: c.toggleHasNoBall,
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => !(c.hasNoBall.value)
                          ? const SizedBox.shrink()
                          : Column(
                              children: [
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
                                          Obx(
                                            () => Switch(
                                              value: c.hasNoBallReball.value,
                                              onChanged:
                                                  c.toggleHasNoBallReball,
                                            ),
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
                                              margin: const EdgeInsets.only(
                                                bottom: 10,
                                                left: 10,
                                                right: 10,
                                              ),
                                              child: TextFormField(
                                                controller:
                                                    c.noBallRunController,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                onTapOutside: (event) =>
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus(),
                                                validator:
                                                    Validators.checkFieldEmpty,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: "1",
                                                  hintStyle:
                                                      CustomTextStyles.f16W400(
                                                          color: AppColors
                                                              .hintTextColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
                        Obx(
                          () => Switch(
                            value: c.hasWideBall.value,
                            onChanged: c.toggleHasWideBall,
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => !(c.hasWideBall.value)
                          ? const SizedBox.shrink()
                          : Column(
                              children: [
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
                                          Obx(
                                            () => Switch(
                                              value: c.hasWideBallReball.value,
                                              onChanged:
                                                  c.toggleHasWideBallReball,
                                            ),
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
                                              margin: const EdgeInsets.only(
                                                bottom: 10,
                                                left: 10,
                                                right: 10,
                                              ),
                                              child: TextFormField(
                                                controller:
                                                    c.wideBallRunController,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(r'[0-9]'),
                                                  ),
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                onTapOutside: (event) =>
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus(),
                                                validator:
                                                    Validators.checkFieldEmpty,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: "1",
                                                  hintStyle:
                                                      CustomTextStyles.f16W400(
                                                          color: AppColors
                                                              .hintTextColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                    SizeConfig.getSpace(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Last Man Stand",
                            style: CustomTextStyles.f18W600(),
                          ),
                        ),
                        Obx(
                          () => Switch(
                            value: c.hasLastManStand.value,
                            onChanged: c.toggleHasLastManStand,
                          ),
                        ),
                      ],
                    ),
                    SizeConfig.getSpace(),
                    CustomElevatedButton(
                      title: "Save Setting",
                      onTap: () {
                        if (c.gameSettingFormKey.currentState!.validate()) {
                          Navigator.of(context).pop();
                        }
                        // Get.toNamed(TeamVsTeamCreateGame.routeName);
                      },
                    ),
                    SizeConfig.getSpace(height: 5),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
