import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/screens/game/views/pickplayer/select_opening_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectOpeningPlayerController extends GetxController {
  @override
  void onInit() {
    var arg = Get.arguments;
    if (arg != null && arg is SelectOpeningPlayerArgument) {
      battingTeam.value = arg.battingTeam;
      bowlingTeam.value = arg.bowlingTeam;
    }
    super.onInit();
  }

  GlobalKey<FormState> selectOpeningPlayerFormKey = GlobalKey<FormState>();

  RxList<User> battingTeam = RxList();
  RxList<User> availableBattingTeam = RxList();
  RxList<User> bowlingTeam = RxList();

  Rxn<User?> openingBowler = Rxn();
  Rxn<User?> openingStriker = Rxn();
  Rxn<User?> openingNonStriker = Rxn();

  onChangeOpeningBolwer(String userName) {
    openingBowler.value =
        bowlingTeam.firstWhere((element) => element.username == userName);
  }

  onChangeStrikerBatter(String userName) {
    availableBattingTeam.assignAll(battingTeam);
    openingStriker.value = availableBattingTeam
        .firstWhere((element) => element.username == userName);
    availableBattingTeam.removeWhere((element) => element.username == userName);
  }

  onChangeNonStrikerBatter(String userName) {
    availableBattingTeam.assignAll(battingTeam);
    openingNonStriker.value = availableBattingTeam
        .firstWhere((element) => element.username == userName);
    availableBattingTeam.removeWhere((element) => element.username == userName);
  }
}
