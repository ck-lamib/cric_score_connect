import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/friend/friends_repo.dart';
import 'package:cric_score_connect/datasource/game/game_datasource.dart';
import 'package:cric_score_connect/models/gamestats/live_match_model.dart';
import 'package:cric_score_connect/models/gamestats/match_store.dart';
import 'package:cric_score_connect/models/overs.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/screens/dashboard/views/dashboard_screen.dart';
import 'package:cric_score_connect/screens/game/views/gaming/next_over.dart';
import 'package:cric_score_connect/screens/game/views/pickplayer/select_opening_player.dart';
import 'package:cric_score_connect/screens/match/batting_stats.dart';
import 'package:cric_score_connect/screens/match/bowling_stats.dart';
import 'package:cric_score_connect/screens/match/delivery.dart';
import 'package:cric_score_connect/screens/match/enums/extra.dart';
import 'package:cric_score_connect/screens/match/enums/out.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:cric_score_connect/utils/helpers/request_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamVsTeamGameController extends GetxController {
  // String matchKey = "";
  Rxn<MatchStore> matchStoreData = Rxn();

  Future<bool> storeMatch() async {
    var result = false;
    CoreController cc = Get.find<CoreController>();
    int userId = cc.currentUser.value!.id!;
    RequestLoader requestLoader = RequestLoader();
    requestLoader.show(message: "Getting user!!!");

    await GameDataSourceRepo.uploadMatchDetail(
      userId: userId,
      homeTeamName: homeTeamController.text,
      homeTeamPlayer: homeTeamPlayer,
      awayTeamName: awayTeamController.text,
      awayTeamPlayer: awayTeamPlayer,
      playerPerTeam:
          int.tryParse(totalNumberOfPlayer.text) ?? awayTeamPlayer.length,
      date: selectDateController.text,
      time: selectTimeController.text,
      noOfOver: int.tryParse(numberOfOversController.text) ?? 6,
      tossWinner: tossWinner!,
      venue: venueController.text,
      onSuccess: (mkey) async {
        matchStoreData.value = mkey;
        requestLoader.hide();
        result = true;
      },
      onError: (message) {
        CustomSnackBar.error(title: "Failed", message: message);
        requestLoader.hide();
        result = false;
      },
    );
    return result;
  }

  sendData({
    bool? isGameCanceledd,
    String? message,
    bool? isGameFinished,
  }) async {
    CoreController cc = Get.find<CoreController>();
    MatchController matchController = Get.find<MatchController>();
    String battingTeam = "";
    String bowlingTeam = "";
    if (matchController.optedTo == "Bat") {
      battingTeam = matchController.tossWinner == homeTeamController.text
          ? homeTeamController.text
          : awayTeamController.text;
      bowlingTeam = matchController.tossWinner == homeTeamController.text
          ? awayTeamController.text
          : homeTeamController.text;
    } else if (matchController.optedTo == "Bowl") {
      battingTeam = matchController.tossWinner == homeTeamController.text
          ? awayTeamController.text
          : homeTeamController.text;
      bowlingTeam = matchController.tossWinner == homeTeamController.text
          ? homeTeamController.text
          : awayTeamController.text;
    }

    //for crr
    var noOfOvers = (int.tryParse(numberOfOversController.text) ?? 6);
    var totalNoOfBalls = noOfOvers * 6;

    var noOfBalls =
        totalNoOfBalls - matchController.getInningDetail.currentBalls.value;

    //for rrr
    // Calculate the runs required to win
    int runsRequired = target.value.toInt() -
        matchController.getInningDetail.totalRunTillNow.value;

    double currentOver = double.parse(matchController.getInningDetail.overs());
    var oversRemaining = noOfOvers - currentOver;
    await GameDataSourceRepo.uploadGameData(
      liveMatchStat: LiveMatchStat(
        matchId: matchStoreData.value?.id.toString(),
        team1Id: matchStoreData.value?.team1Id,
        team2Id: matchStoreData.value?.team2Id,
        isGameFinished: isGameFinished ?? false,
        userId: cc.currentUser.value!.id.toString(),
        crr: matchController.getInningDetail.totalRunTillNow.value == 0
            ? "0.00"
            : (matchController.getInningDetail.totalRunTillNow.value /
                        (matchController.getInningDetail.currentBalls.value /
                            6))
                    .isFinite
                ? (matchController.getInningDetail.totalRunTillNow.value /
                        (matchController.getInningDetail.currentBalls.value /
                            6))
                    .toStringAsFixed(2)
                : "0.00",
        extras: LiveExtras(
          byes: matchController.getInningDetail.currentByes.value,
          legByes: matchController.getInningDetail.currentLegByes.value,
          noBall: matchController.getInningDetail.currentNoBalls.value,
          penalty: matchController.getInningDetail.currentPenalty.value,
          wide: matchController.getInningDetail.currentWides.value,
        ),
        awayTeamName: awayTeamController.text,
        homeTeamName: homeTeamController.text,
        isFirstInning: matchController.getInningDetail.isFirstInning,
        firstInningTotalOver: double.tryParse(Over.overs(
                matchController.firstInningDetail.currentNoBalls.value)) ??
            0,
        firstInningTotalRun:
            matchController.firstInningDetail.totalRunTillNow.value,
        firstInningTotalWicket:
            matchController.firstInningDetail.totalWicketTillNow.value,
        secondInningTotalOver: double.tryParse(Over.overs(
                matchController.secondInningDetail.currentNoBalls.value)) ??
            0,
        secondInningTotalRun:
            matchController.secondInningDetail.totalRunTillNow.value,
        secondInningTotalWicket:
            matchController.secondInningDetail.totalWicketTillNow.value,
        finishedMessage: message ??
            ((matchController.isFirstInnings == false &&
                        matchController.isSecondInnings == true)
                    .obs
                    .value
                ? "$bowlingTeam needs ${target.value - matchController.getInningDetail.totalRunTillNow.value.toDouble()} runs from $noOfBalls balls to win against ${matchController.firstInningBattingTeamName}."
                : "$battingTeam is Batting against $bowlingTeam"),
        isGameCanceled: isGameCanceledd ?? false,
        rrr: oversRemaining == 0
            ? matchController.getInningDetail.isFirstInning == true
                ? "0.00"
                : "0.00"
            : matchController.getInningDetail.isFirstInning == true
                ? "0.00"
                : (((runsRequired.toDouble() / oversRemaining.toDouble()) * 6) /
                        6)
                    .toStringAsFixed(2),
        target: target.value.toString(),
        homeTeam: homeTeamPlayer
            .map(
              (item) => LiveTeam(
                id: item.id,
                name: item.name,
                username: item.username,
                out: item.matchBattingStats?.outReason.value != Out.none,
                bowler:
                    matchController.getInningDetail.bowler.value?.id == item.id,
                striker: matchController.getInningDetail.striker.value?.id ==
                    item.id,
                nonStriker:
                    matchController.getInningDetail.nonStriker.value?.id ==
                        item.id,
                matchBattingStat: LiveMatchBattingStat(
                  balls: item.matchBattingStats?.balls.value,
                  fours: item.matchBattingStats?.fours.value,
                  runs: item.matchBattingStats?.runs.value,
                  sixes: item.matchBattingStats?.sixes.value,
                ),
                matchBowlingStat: LiveMatchBowlingStat(
                  maidens: item.matchBowlingStats?.maidens.value,
                  balls: item.matchBowlingStats?.balls.value,
                  fours: item.matchBowlingStats?.fours.value,
                  runs: item.matchBowlingStats?.runs.value,
                  sixes: item.matchBowlingStats?.sixes.value,
                  noBalls: item.matchBowlingStats?.noBalls.value,
                  overs: double.tryParse(
                          item.matchBowlingStats?.oversBowled ?? "0.0") ??
                      0.0,
                  wickets: item.matchBowlingStats?.wickets.value,
                  wides: item.matchBowlingStats?.wides.value,
                ),
              ),
            )
            .toList(),
        awayTeam: awayTeamPlayer
            .map(
              (item) => LiveTeam(
                id: item.id,
                name: item.name,
                username: item.username,
                out: item.matchBattingStats?.outReason.value != Out.none,
                bowler:
                    matchController.getInningDetail.bowler.value?.id == item.id,
                striker: matchController.getInningDetail.striker.value?.id ==
                    item.id,
                nonStriker:
                    matchController.getInningDetail.nonStriker.value?.id ==
                        item.id,
                matchBattingStat: LiveMatchBattingStat(
                  balls: item.matchBattingStats?.balls.value,
                  fours: item.matchBattingStats?.fours.value,
                  runs: item.matchBattingStats?.runs.value,
                  sixes: item.matchBattingStats?.sixes.value,
                ),
                matchBowlingStat: LiveMatchBowlingStat(
                  maidens: item.matchBowlingStats?.maidens.value,
                  balls: item.matchBowlingStats?.balls.value,
                  fours: item.matchBowlingStats?.fours.value,
                  runs: item.matchBowlingStats?.runs.value,
                  sixes: item.matchBowlingStats?.sixes.value,
                  noBalls: item.matchBowlingStats?.noBalls.value,
                  overs: double.tryParse(
                          item.matchBowlingStats?.oversBowled ?? "0.0") ??
                      0.0,
                  wickets: item.matchBowlingStats?.wickets.value,
                  wides: item.matchBowlingStats?.wides.value,
                ),
              ),
            )
            .toList(),
      ),
      onSuccess: (message) async {
        // matchKey = mkey;
        CustomLogger.trace(message);
      },
      onError: (message) {
        CustomSnackBar.error(title: "Failed to send data", message: message);
      },
    );
  }

  Future<bool> getAllFriend() async {
    var result = false;
    CoreController cc = Get.find<CoreController>();
    int userId = cc.currentUser.value!.id!;
    RequestLoader requestLoader = RequestLoader();
    requestLoader.show(message: "Getting user!!!");
    await FriendRepo.getAllFriend(
      userId: userId,
      onSuccess: (users) async {
        requestLoader.hide();
        for (var eachUser in users) {
          allAvailablePlayers.add(eachUser.copyWith(
            matchBattingStats: MatchBattingStats(),
            matchBowlingStats: MatchBowlingStats(),
          ));
        }
        result = true;
      },
      onError: (message) {
        CustomSnackBar.error(
            title: "Failed", message: "Failed while getting user");
        requestLoader.hide();
        result = false;
      },
    );
    return result;
  }

  // Future<bool> createMatch() async {
  //   var result = false;
  //   CoreController cc = Get.find<CoreController>();
  //   int userId = cc.currentUser.value!.id!;
  //   RequestLoader requestLoader = RequestLoader();
  //   requestLoader.show(message: "Creating match!. Please Wait");
  //   await GameDataSourceRepo.createMatch(
  //     userId: userId,
  //     homeTeamName: homeTeamController.text,
  //     awayTeamName: awayTeamController.text,
  //     onSuccess: (users) async {
  //       requestLoader.hide();
  //       result = true;
  //     },
  //     onError: (message) {
  //       CustomSnackBar.error(
  //           title: "Failed",
  //           message: "Failed to create game. Please try again later.");
  //       requestLoader.hide();
  //       result = false;
  //     },
  //   );
  //   return result;
  // }

  var isCoinTossed = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController homeTeamController = TextEditingController();
  TextEditingController awayTeamController = TextEditingController();

  //game setting page
  GlobalKey<FormState> gameSettingFormKey = GlobalKey<FormState>();

  TextEditingController totalNumberOfPlayer = TextEditingController(text: "4");
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

  var hasLastManStand = false.obs;
  toggleHasLastManStand(bool value) {
    hasLastManStand.value = value;
  }

  TextEditingController wideBallRunController =
      TextEditingController(text: "1");

  int get getWideRun =>
      hasWideBall.value ? (int.tryParse(wideBallRunController.text) ?? 0) : 0;
  int get getNoBallRun =>
      hasNoBall.value ? (int.tryParse(noBallRunController.text) ?? 0) : 0;

  //create game
  GlobalKey<FormState> createGameFormKey = GlobalKey<FormState>();

  RxList<User> allAvailablePlayers = RxList();

  RxList<User> homeTeamPlayer = RxList();
  RxList<User> awayTeamPlayer = RxList();

  TextEditingController selectDateController = TextEditingController();
  TextEditingController selectTimeController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  TextEditingController numberOfOversController = TextEditingController();
  String? tossWinner;
  String? optedTo;

//select opening player

  GlobalKey<FormState> selectOpeningPlayerFormKey = GlobalKey<FormState>();

//buttons
  var isWideSelected = false.obs;
  toggleIsWideSelected(bool? value) {
    isWideSelected.value = value ?? false;
    isNoBallSelected.value = false;
    isByesSelected.value = false;
    isLegByesSelected.value = false;
  }

  var isNoBallSelected = false.obs;
  toggleIsNoBallSelected(bool? value) {
    isNoBallSelected.value = value ?? false;
    isWideSelected.value = false;
  }

  var isByesSelected = false.obs;
  toggleIsByesSelected(bool? value) {
    isByesSelected.value = value ?? false;
    isWideSelected.value = false;
    isLegByesSelected.value = false;
  }

  var isLegByesSelected = false.obs;
  toggleIsLegByesSelected(bool? value) {
    isLegByesSelected.value = value ?? false;
    isWideSelected.value = false;
    isByesSelected.value = false;
  }

  var isWicketsSelected = false.obs;
  toggleIsWicketsSelected(bool? value) {
    isWicketsSelected.value = value ?? false;
  }

  checkBoxReset() {
    isWideSelected.value = false;
    isNoBallSelected.value = false;
    isByesSelected.value = false;
    isLegByesSelected.value = false;
    isWicketsSelected.value = false;
  }

  //gaming screen
  var target = 0.0.obs;

  // InningDetail firstInning = InningDetail();
}

class InningDetail extends GetxController {
  bool isFirstInning = false;
  RxList<User> battingTeam = RxList();
  RxList<User> bowlingTeam = RxList();
  Rxn<User?> bowler = Rxn();
  // setBowler(Rxn<User?> newBowler) {
  //   bowler = newBowler;
  // }

  Rxn<User?> striker = Rxn();
  Rxn<User?> nonStriker = Rxn();

  RxList<User> outBattingTeam = RxList();
  Rxn<User?> nextBatsman = Rxn();
  var totalRunTillNow = 0.obs;
  var totalWicketTillNow = 0.obs;
  var crr = 0.0.obs;
  var rrr = 0.0.obs;

  RxInt currentBalls = 0.obs;
  RxInt currentNoBalls = 0.obs;
  RxInt currentWides = 0.obs;
  RxInt currentByes = 0.obs;
  RxInt currentLegByes = 0.obs;
  RxInt currentPenalty = 0.obs;
  RxInt currentBonus = 0.obs;
  RxBool isCurrentMaiden = true.obs;
  RxBool isOverInProgress = false.obs;

  var lastSevenDeliveries = [].obs;

  InningDetail({
    required this.battingTeam,
    required this.bowlingTeam,
    required this.isFirstInning,
  });

//adding delevery
  void addRuns(Delivery delivery) {
    TeamVsTeamGameController teamGameController =
        Get.find<TeamVsTeamGameController>();
    isCurrentMaiden.value = false;
    if (delivery.extras[0] == Extra.none) {
      //
      _addRunsForBatter(delivery.runs);
      _addRunsAgainstBowler(delivery.runs);
      totalRunTillNow.value += delivery.runs;
      return;
    }
    if (delivery.isWide()) {
      totalRunTillNow.value += delivery.runs + teamGameController.getWideRun;
      currentWides.value += delivery.runs + 1;
      _addRunsAgainstBowler(delivery.runs + teamGameController.getWideRun);
    }
    if (delivery.isNoBall()) {
      totalRunTillNow.value =
          totalRunTillNow.value + teamGameController.getNoBallRun;
      currentNoBalls.value++;
      _addRunsAgainstBowler(teamGameController.getNoBallRun);
      if (delivery.runs > 0 && !delivery.isLegBye() && !delivery.isBye()) {
        totalRunTillNow.value += delivery.runs;
        _addRunsForBatter(delivery.runs);
        _addRunsAgainstBowler(delivery.runs);
      }
    }
    if (delivery.isLegBye()) {
      currentLegByes.value += delivery.runs;
      totalRunTillNow.value += delivery.runs;
    }
    if (delivery.isBye()) {
      currentByes.value += delivery.runs;

      totalRunTillNow.value += delivery.runs;
    }
    if (delivery.isPenalty()) {
      totalRunTillNow.value += delivery.runs;
      currentPenalty.value += delivery.runs;
    }
    if (delivery.isBonus()) {
      totalRunTillNow.value += delivery.runs;
      currentBonus.value += delivery.runs;
    }
  }

  void _addRunsForBatter(int runs) {
    striker.value!.matchBattingStats?.runs.value += runs;
    if (runs == 4) {
      striker.value!.matchBattingStats?.fours.value += 1;
    } else if (runs == 6) {
      striker.value!.matchBattingStats?.sixes.value += 1;
    }
  }

  void _addWicket(Delivery delivery) {
    if (delivery.out == Out.none) return;
    if (delivery.out.isBowlersWicket()) {
      bowler.value?.matchBowlingStats?.wickets.value++;
    }
    totalWicketTillNow.value++;

    //get batter
    if (delivery.batter == null) {
      striker.value!.matchBattingStats?.outReason.value = delivery.out;
      outBattingTeam.add(striker.value!);
      outBattingTeam.refresh();
      if (nextBatsman.value == null) {
        striker.value = nonStriker.value;
      } else {
        striker.value = nextBatsman.value;
      }
      return;
    }
    if (delivery.batter?.username == striker.value?.username) {
      striker.value!.matchBattingStats?.outReason.value = delivery.out;
      outBattingTeam.add(striker.value!);
      outBattingTeam.refresh();
      if (nextBatsman.value == null) {
        striker.value = nonStriker.value;
      } else {
        striker.value = nextBatsman.value;
      }
    } else {
      nonStriker.value!.matchBattingStats?.outReason.value = delivery.out;
      outBattingTeam.add(nonStriker.value!);
      outBattingTeam.refresh();
      nonStriker.value = nextBatsman.value;
    }
  }

  void _addRunsAgainstBowler(int runs) {
    bowler.value?.matchBowlingStats?.runs.value += runs;
  }

  void incrementBalls(Delivery delivery) {
    TeamVsTeamGameController teamGameController =
        Get.find<TeamVsTeamGameController>();
    if (delivery.extras.isLegitBall()) {
      isOverInProgress.value = true;
      currentBalls.value++;
      striker.value?.matchBattingStats?.balls.value++;
      bowler.value?.matchBowlingStats?.balls.value++;
    }

    if (delivery.isWide()) {
      if (teamGameController.hasWideBall.value &&
          !(teamGameController.hasWideBallReball.value)) {
        isOverInProgress.value = true;
        currentBalls.value++;
        striker.value?.matchBattingStats?.balls.value++;
        bowler.value?.matchBowlingStats?.balls.value++;
      }
    }

    if (delivery.isNoBall()) {
      if (teamGameController.hasNoBall.value &&
          (!teamGameController.hasNoBallReball.value)) {
        isOverInProgress.value = true;
        currentBalls.value++;
        striker.value?.matchBattingStats?.balls++;
        bowler.value?.matchBowlingStats?.balls.value++;
      } else {
        striker.value?.matchBattingStats?.balls++;
      }
    }
  }

  void concludeOver(User newBowler) {
    if (isCurrentMaiden.value) {
      bowler.value?.matchBowlingStats?.maidens.value++;
    }
    _changeStrike();
    _changeBowler(newBowler);
    isCurrentMaiden.value = true;
    isOverInProgress.value = false;
    deliveryHistory.clear();
  }

  void changeStrike() {
    _changeStrike();
    update();
  }

  void changeBowler(User newBowler) {
    bowler.value = newBowler;
    update();
  }

  // addPenalty(Delivery delivery) {
  //   delivery.addExtra(Extra.penalty);
  //   lastSevenDeliveries.add(delivery.shortSummary().split(','));
  //   totalRunTillNow.value += delivery.runs;
  //   currentPenalty.value += delivery.runs;
  //   currentBalls.value++;
  //   bowler.value?.matchBowlingStats?.balls.value++;
  // }

  checkAllOut() async {
    MatchController matchController = Get.find<MatchController>();
    print(matchController.getInningDetail.isFirstInning);
    TeamVsTeamGameController teamGameController =
        Get.find<TeamVsTeamGameController>();

    if (teamGameController.hasLastManStand.value) {
      if (outBattingTeam.length == battingTeam.length) {
//get frist batter team name  wins by

        //by run
        // second beam
        //target run and scored run
        if (matchController.getInningDetail.isFirstInning == false) {
          await showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text("End of Game"),
                  content: Text(
                    "${matchController.firstInningBattingTeamName} wins by ${(teamGameController.target.value - 1) - (matchController.getInningDetail.totalRunTillNow.value)} runs.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await teamGameController.sendData(
                          isGameFinished: true,
                          message:
                              "${matchController.firstInningBattingTeamName} wins by ${(teamGameController.target.value - 1) - (matchController.getInningDetail.totalRunTillNow.value)} runs.",
                        );
                        Get.offNamedUntil(
                            DashboardScreen.routeName, (route) => false);
                      },
                      child: const Text(
                        "Continue",
                      ),
                    ),
                  ],
                );
              });
        } else {
          await showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text("End of First inning."),
                  content: const Text(
                      "End of first inning due to all-out. Press continue for second inning."),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await teamGameController.sendData();
                        matchController.endFirstInnings();
                        teamGameController.target.value = matchController
                                .firstInningDetail.totalRunTillNow.value
                                .toDouble() +
                            1;
                        Get.offAndToNamed(
                          SelectOpeningPlayerScreen.routeName,
                          arguments: SelectOpeningPlayerArgument(
                            battingTeam:
                                matchController.getInningDetail.battingTeam,
                            bowlingTeam:
                                matchController.getInningDetail.bowlingTeam,
                          ),
                        );

                        // Get.back();
                        // Get.offNamedUntil(
                        //     DashboardScreen.routeName, (route) => false);
                      },
                      child: const Text(
                        "Continue",
                      ),
                    ),
                  ],
                );
              });
        }
        return;
      }
    } else {
      if (outBattingTeam.length - 1 == battingTeam.length) {
//get frist batter team name  wins by

        //by run
        // second beam
        //target run and scored run
        if (matchController.getInningDetail.isFirstInning == false) {
          await showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text("End of Game"),
                  content: Text(
                    "${matchController.firstInningBattingTeamName} wins by ${(teamGameController.target.value - 1) - (matchController.getInningDetail.totalRunTillNow.value)} runs.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await teamGameController.sendData(
                          isGameFinished: true,
                          message:
                              "${matchController.firstInningBattingTeamName} wins by ${(teamGameController.target.value - 1) - (matchController.getInningDetail.totalRunTillNow.value)} runs.",
                        );

                        Get.offNamedUntil(
                            DashboardScreen.routeName, (route) => false);
                      },
                      child: const Text(
                        "Continue",
                      ),
                    ),
                  ],
                );
              });
        } else {
          await showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text("End of First inning."),
                  content: const Text(
                      "End of first inning due to all-out. Press continue for second inning."),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await teamGameController.sendData();
                        matchController.endFirstInnings();
                        teamGameController.target.value = matchController
                                .firstInningDetail.totalRunTillNow.value
                                .toDouble() +
                            1;
                        Get.offAndToNamed(
                          SelectOpeningPlayerScreen.routeName,
                          arguments: SelectOpeningPlayerArgument(
                            battingTeam:
                                matchController.getInningDetail.battingTeam,
                            bowlingTeam:
                                matchController.getInningDetail.bowlingTeam,
                          ),
                        );

                        // Get.back();
                        // Get.offNamedUntil(
                        //     DashboardScreen.routeName, (route) => false);
                      },
                      child: const Text(
                        "Continue",
                      ),
                    ),
                  ],
                );
              });
        }
        return;
      }
    }
  }

  checkOverFinish() async {
    MatchController matchController = Get.find<MatchController>();
    TeamVsTeamGameController teamGameController =
        Get.find<TeamVsTeamGameController>();

    int totalNoOfBalls =
        ((double.tryParse(teamGameController.numberOfOversController.text) ??
                    6) *
                6)
            .toInt();
    int currentBall = matchController.getInningDetail.currentBalls.value + 1;
    print("total ball $totalNoOfBalls");
    print("current ball $currentBall");

    if (currentBall > totalNoOfBalls) {
      if (matchController.getInningDetail.isFirstInning == false) {
        //first team wins the run by run

        // "${matchController.firstInningBattingTeamName} wins by ${(teamGameController.target - 1) - (matchController.getInningDetail.totalRunTillNow.value)} runs.",
        await showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text("End of Game."),
                content: Text(
                  "${matchController.firstInningBattingTeamName} wins by ${(teamGameController.target.value - 1) - (matchController.getInningDetail.totalRunTillNow.value)} runs.",
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await teamGameController.sendData(
                        isGameFinished: true,
                        message:
                            "${matchController.firstInningBattingTeamName} wins by ${(teamGameController.target.value - 1) - (matchController.getInningDetail.totalRunTillNow.value)} runs.",
                      );

                      Get.offNamedUntil(
                          DashboardScreen.routeName, (route) => false);
                    },
                    child: const Text(
                      "Continue",
                    ),
                  ),
                ],
              );
            });
      } else {
        await showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text("End of First inning."),
                content: const Text(
                    "Total no. of over is finished. Press continue for second inning."),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await teamGameController.sendData();
                      matchController.endFirstInnings();
                      teamGameController.target.value = matchController
                              .firstInningDetail.totalRunTillNow.value
                              .toDouble() +
                          1;
                      Get.offAndToNamed(
                        SelectOpeningPlayerScreen.routeName,
                        arguments: SelectOpeningPlayerArgument(
                          battingTeam:
                              matchController.getInningDetail.battingTeam,
                          bowlingTeam:
                              matchController.getInningDetail.bowlingTeam,
                        ),
                      );

                      // Get.back();
                      // Get.offNamedUntil(
                      //     DashboardScreen.routeName, (route) => false);
                    },
                    child: const Text(
                      "Continue",
                    ),
                  ),
                ],
              );
            });
      }
      return;
    }
  }

  checkRunScoreOver() async {
    MatchController matchController = Get.find<MatchController>();
    TeamVsTeamGameController teamGameController =
        Get.find<TeamVsTeamGameController>();

    double targetRun = teamGameController.target.value;

    int currentRun = matchController.getInningDetail.totalRunTillNow.value;
    print("total ball $targetRun");
    print("current ball $currentRun");

    if (currentRun >= targetRun) {
      if (matchController.getInningDetail.isFirstInning == false) {
        //run le jity by wicket
        // "${matchController.firstInningBattingTeamName} wins by ${(teamGameController.target - 1) - (matchController.getInningDetail.totalRunTillNow.value)} runs.",
        await showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text("End of Game."),
                content: Text(
                  "${matchController.firstInningBowlingTeamName} wins by ${(teamGameController.hasLastManStand.value ? matchController.getInningDetail.battingTeam.length : matchController.getInningDetail.battingTeam.length - 1) - (matchController.getInningDetail.outBattingTeam.length)} wicket.",
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await teamGameController.sendData(
                        isGameFinished: true,
                        message:
                            "${matchController.firstInningBowlingTeamName} wins by ${(teamGameController.hasLastManStand.value ? matchController.getInningDetail.battingTeam.length : matchController.getInningDetail.battingTeam.length - 1) - (matchController.getInningDetail.outBattingTeam.length)} wicket.",
                      );
                      Get.offNamedUntil(
                          DashboardScreen.routeName, (route) => false);
                    },
                    child: const Text(
                      "Continue",
                    ),
                  ),
                ],
              );
            });
      } else {
        return;
      }
      return;
    }
  }

  void recordDelivery(Delivery delivery) async {
    recordDeliveryHistory(delivery);
    print("hello $deliveryHistory");
    MatchController matchController = Get.find<MatchController>();
    TeamVsTeamGameController teamGameController =
        Get.find<TeamVsTeamGameController>();

    int totalNoOfBalls =
        ((double.tryParse(teamGameController.numberOfOversController.text) ??
                    6) *
                6)
            .toInt();
    int currentBall = matchController.getInningDetail.currentBalls.value + 1;
    // bool endGameByOver = currentBall > totalNoOfBalls;
    //check all out
    // print("===> over is completed");

    // if wicket then get reason and next player

    addRuns(delivery);
    incrementBalls(delivery);
    if (delivery.runs % 2 == 1 &&
        !delivery.isBonus() &&
        !delivery.isPenalty()) {
      _changeStrike();
    }
    lastSevenDeliveries.add(delivery.shortSummary().split(','));
    if (Over.finished(currentBalls.value) && isOverInProgress.value) {
      lastSevenDeliveries.value = [];

//for calculating team game controller
      TeamVsTeamGameController teamGameController =
          Get.find<TeamVsTeamGameController>();

      int totalNoOfBalls =
          ((double.tryParse(teamGameController.numberOfOversController.text) ??
                      6) *
                  6)
              .toInt();
      int currentBall = matchController.getInningDetail.currentBalls.value + 1;

      if (currentBall > totalNoOfBalls) {
      } else {
        var result = await showDialog(
            context: Get.context!,
            builder: (context) {
              return NextOverScreen(
                bowlingTeam: bowlingTeam,
                currentBowler: bowler.value!,
              );
            });
        if (result != null && result is User) {
          concludeOver(result);
        }
      }
    }
    // while (lastSevenDeliveries.length > 7) {
    //   lastSevenDeliveries.removeAt(0);
    // }
    print(lastSevenDeliveries);
    _addWicket(delivery);
    await checkAllOut();
    await checkRunScoreOver();
    await checkOverFinish();
    teamGameController.sendData();
    delivery.reset();
    // checkBoxReset();
    update();
  }

  String overs() {
    return Over.overs(currentBalls.value);
  }

  _changeStrike() {
    var t = striker.value;
    striker.value = nonStriker.value;
    nonStriker.value = t;
    update();
  }

  _changeBowler(User newBowler) {
    bowler.value = newBowler;
    bowlerHistory.add(newBowler);
    update();
  }

  List<User> bowlerHistory = [];

  // void undoDelivery() {
  //   CustomLogger.trace(deliveryHistory.last.runs);

  //   // Delivery lastDelivery;
  //   // if (deliveryHistory.isNotEmpty) {
  //   //   lastDelivery = deliveryHistory.last;
  //   //   CustomLogger.trace(lastDelivery);
  //   //   undoRecordDelivery(lastDelivery);
  //   // }
  //   update();
  // }

  RxList<Delivery> deliveryHistory = RxList();
  recordDeliveryHistory(Delivery delivery) {
    deliveryHistory.value = [
      Delivery().copyWith(
        batter: delivery.batter,
        bowler: delivery.bowler,
        extras: delivery.extras,
        out: delivery.out,
        runs: delivery.runs,
      )
    ];
    CustomLogger.trace(deliveryHistory.last.runs);
    deliveryHistory.refresh();
    update();
  }

//undo delivery

  _undoChangeStrike() {
    var t = striker.value;
    print(striker.value?.username);
    striker.value = nonStriker.value;
    nonStriker.value = t;
    update();
  }

  void _undoAddRunsForBatter(int runs) {
    striker.value!.matchBattingStats?.runs.value -= runs;
    if (runs == 4) {
      striker.value!.matchBattingStats?.fours.value -= 1;
    } else if (runs == 6) {
      striker.value!.matchBattingStats?.sixes.value -= 1;
    }
  }

  void _undoAddRunsAgainstBowler(int runs) {
    bowler.value?.matchBowlingStats?.runs.value -= runs;
  }

  void undoAddRuns(Delivery delivery) {
    TeamVsTeamGameController teamGameController =
        Get.find<TeamVsTeamGameController>();
    isCurrentMaiden.value = false;
    if (delivery.extras[0] == Extra.none) {
      //
      _undoAddRunsForBatter(delivery.runs);
      _undoAddRunsAgainstBowler(delivery.runs);
      print(totalRunTillNow.value);
      print(delivery.runs);
      totalRunTillNow.value -= delivery.runs;
      print(totalRunTillNow.value);
      return;
    }
    if (delivery.isWide()) {
      totalRunTillNow.value -= delivery.runs + teamGameController.getWideRun;
      currentWides.value -= delivery.runs + 1;
      _undoAddRunsAgainstBowler(delivery.runs + teamGameController.getWideRun);
    }
    if (delivery.isNoBall()) {
      totalRunTillNow.value =
          totalRunTillNow.value - teamGameController.getNoBallRun;
      currentNoBalls.value--;
      _undoAddRunsAgainstBowler(teamGameController.getNoBallRun);
      if (delivery.runs > 0 && !delivery.isLegBye() && !delivery.isBye()) {
        totalRunTillNow.value -= delivery.runs;
        _undoAddRunsForBatter(delivery.runs);
        _undoAddRunsAgainstBowler(delivery.runs);
      }
    }
    if (delivery.isLegBye()) {
      currentLegByes.value -= delivery.runs;
      totalRunTillNow.value -= delivery.runs;
    }
    if (delivery.isBye()) {
      currentByes.value -= delivery.runs;

      totalRunTillNow.value -= delivery.runs;
    }
    if (delivery.isPenalty()) {
      totalRunTillNow.value -= delivery.runs;
      currentPenalty.value -= delivery.runs;
    }
    if (delivery.isBonus()) {
      totalRunTillNow.value -= delivery.runs;
      currentBonus.value -= delivery.runs;
    }
  }

  void undoIncrementBalls(Delivery delivery) {
    TeamVsTeamGameController teamGameController =
        Get.find<TeamVsTeamGameController>();
    if (delivery.extras.isLegitBall()) {
      isOverInProgress.value = true;
      currentBalls.value--;
      striker.value?.matchBattingStats?.balls.value--;
      bowler.value?.matchBowlingStats?.balls.value--;
    }

    if (delivery.isWide()) {
      if (teamGameController.hasWideBall.value &&
          !(teamGameController.hasWideBallReball.value)) {
        isOverInProgress.value = true;
        currentBalls.value--;
        striker.value?.matchBattingStats?.balls.value--;
        bowler.value?.matchBowlingStats?.balls.value--;
      }
    }

    if (delivery.isNoBall()) {
      if (teamGameController.hasNoBall.value &&
          (!teamGameController.hasNoBallReball.value)) {
        isOverInProgress.value = true;
        currentBalls.value--;
        striker.value?.matchBattingStats?.balls--;
        bowler.value?.matchBowlingStats?.balls.value--;
      } else {
        striker.value?.matchBattingStats?.balls--;
      }
    }
  }

  void undoRecordDelivery(Delivery delivery) async {
    MatchController matchController = Get.find<MatchController>();
    TeamVsTeamGameController teamGameController =
        Get.find<TeamVsTeamGameController>();
    CustomLogger.trace(delivery.runs);

    if (delivery.runs % 2 == 1 &&
        !delivery.isBonus() &&
        !delivery.isPenalty()) {
      _undoChangeStrike();
    }

    undoAddRuns(delivery);
    undoIncrementBalls(delivery);

    lastSevenDeliveries.removeLast();

    teamGameController.sendData();
    delivery.reset();
    deliveryHistory.clear();
    update();
  }
}

class MatchController extends GetxController {
  bool isFirstInnings = true;
  bool isSecondInnings = false;
  String? tossWinner;
  String? optedTo;

  RxList<User> battingTeam = RxList();
  RxList<User> bowlingTeam = RxList();
  String? firstInningBattingTeamName;
  String? firstInningBowlingTeamName;
  late InningDetail firstInningDetail;
  late InningDetail secondInningDetail;

  // Initialize inning details for both innings
  MatchController() {
    firstInningDetail = InningDetail(
      isFirstInning: true,
      battingTeam: battingTeam,
      bowlingTeam: bowlingTeam,
    );
    secondInningDetail = InningDetail(
      isFirstInning: false,
      battingTeam: battingTeam,
      bowlingTeam: bowlingTeam,
    );
  }

  InningDetail get getInningDetail {
    if (isFirstInnings == true && isSecondInnings == false) {
      return firstInningDetail;
    } else {
      return secondInningDetail;
    }
  }

  void start({
    required String tossWinnerr,
    required String optedToo,
    required RxList<User> battingT,
    required RxList<User> bowlingT,
    required String firstInningBattingTeam,
    required String firstInningBowlingTeam,
  }) {
    isFirstInnings = true;
    isSecondInnings = false;
    tossWinner = tossWinnerr;
    optedTo = optedToo;
    battingTeam = battingT;
    bowlingTeam = bowlingT;
    firstInningBattingTeamName = firstInningBattingTeam;
    firstInningBowlingTeamName = firstInningBowlingTeam;
    firstInningDetail = InningDetail(
      isFirstInning: true,
      battingTeam: battingTeam,
      bowlingTeam: bowlingTeam,
    );
  }

  void endFirstInnings() {
    isFirstInnings = false;
    isSecondInnings = true;
    var currentBatting = battingTeam;
    battingTeam = bowlingTeam;
    bowlingTeam = currentBatting;
    secondInningDetail = InningDetail(
      isFirstInning: false,
      battingTeam: battingTeam,
      bowlingTeam: bowlingTeam,
    );
    update();
  }
}
