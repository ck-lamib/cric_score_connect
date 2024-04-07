import 'package:cric_score_connect/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class TeamVsTeamGameController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController homeTeamController = TextEditingController();
  TextEditingController awayTeamController = TextEditingController();

  //game setting page
  GlobalKey<FormState> gameSettingFormKey = GlobalKey<FormState>();

  TextEditingController totalNumberOfPlayer = TextEditingController(text: "6");
  var hasNoBall = true.obs;
  toggleHasNoBall(bool value) {
    hasNoBall.value = value;
  }

  var hasNoBallReball = true.obs;
  toggleHasNoBallReball(bool value) {
    hasNoBallReball.value = value;
  }

  TextEditingController noBallRunController = TextEditingController(text: "1");
  var hasWideBall = true.obs;
  toggleHasWideBall(bool value) {
    hasWideBall.value = value;
  }

  var hasWideBallReball = true.obs;
  toggleHasWideBallReball(bool value) {
    hasWideBallReball.value = value;
  }

  TextEditingController wideBallRunController =
      TextEditingController(text: "1");

  //create game
  GlobalKey<FormState> createGameFormKey = GlobalKey<FormState>();

  RxList<User> allAvailablePlayers = RxList(
    [
      User(
        name: "Bimal khatri",
        username: "username1",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
      ),
      User(
        name: "Bimal khatri",
        username: "username2",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
      ),
      User(
        name: "Bimal khatri",
        username: "username3",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
      ),
      User(
        name: "Bimal khatri",
        username: "username4",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
      ),
      User(
        name: "Bimal khatri",
        username: "username5",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
      ),
      User(
        name: "Bimal khatri",
        username: "username6",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
      ),
      User(
        name: "Bimal khatri",
        username: "username7",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
      ),
      User(
        name: "Bimal khatri",
        username: "username8",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
      ),
      User(
        name: "Bimal khatri",
        username: "username9",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
      ),
      User(
        name: "Bimal khatri",
        username: "username10",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
      ),
    ],
  );

  RxList<User> homeTeamPlayer = RxList();
  RxList<User> awayTeamPlayer = RxList();

  TextEditingController selectDateController = TextEditingController();
  TextEditingController selectTimeController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  String? numberOfOvers;
  String? tossWinner;
  String? optedTo;

//select opening player

  GlobalKey<FormState> selectOpeningPlayerFormKey = GlobalKey<FormState>();

  RxList<User> battingTeam = RxList();
  RxList<User> availableBattingTeam = RxList();
  RxList<User> bowlingTeam = RxList();

  User? bowler;
  User? striker;
  User? nonStriker;

  onChangeOpeningBolwer(String userName) {
    bowler = bowlingTeam.firstWhere((element) => element.username == userName);
  }

  onChangeStrikerBatter(String userName) {
    availableBattingTeam.assignAll(battingTeam);
    striker = availableBattingTeam
        .firstWhere((element) => element.username == userName);
    availableBattingTeam.removeWhere((element) => element.username == userName);
  }

  onChangeNonStrikerBatter(String userName) {
    availableBattingTeam.assignAll(battingTeam);
    nonStriker = availableBattingTeam
        .firstWhere((element) => element.username == userName);
    availableBattingTeam.removeWhere((element) => element.username == userName);
  }

  //pick players
  var batterRecord = [];
  var bowlerRecord = [];

  //gaming screen
  var totalRunTillNow = 0.obs;
  var totalWicketTillNow = 0.obs;
  var crr = 0;
  var rrr = 0;
  var target = 0;

  var gameData = [];
}

class BowlerGameData {
  final String bowlerUserName;

  BowlerGameData({required this.bowlerUserName});
}

class BatterGameData {
  final String batterUserName;
  final int runScored;
  final int ballReceived;
  final int totalFours;
  final int totalSixes;

  BatterGameData(
    this.runScored,
    this.ballReceived,
    this.totalFours,
    this.totalSixes, {
    required this.batterUserName,
  });
}




  // RxList<User> battingTeam = RxList([
  //   User(
  //     name: "Bimal khatri",
  //     username: "username1",
  //     email: "email@gmail.com",
  //     address: "Pokhara",
  //     dob: "2002-07-07",
  //     phone: "98677743236",
  //   ),
  //   User(
  //     name: "Bimal khatri",
  //     username: "username2",
  //     email: "email@gmail.com",
  //     address: "Pokhara",
  //     dob: "2002-07-07",
  //     phone: "98677743236",
  //   ),
  //   User(
  //     name: "Bimal khatri",
  //     username: "username3",
  //     email: "email@gmail.com",
  //     address: "Pokhara",
  //     dob: "2002-07-07",
  //     phone: "98677743236",
  //   ),
  //   User(
  //     name: "Bimal khatri",
  //     username: "username4",
  //     email: "email@gmail.com",
  //     address: "Pokhara",
  //     dob: "2002-07-07",
  //     phone: "98677743236",
  //   ),
  //   User(
  //     name: "Bimal khatri",
  //     username: "username5",
  //     email: "email@gmail.com",
  //     address: "Pokhara",
  //     dob: "2002-07-07",
  //     phone: "98677743236",
  //   ),
  // ]);