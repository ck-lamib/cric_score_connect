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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamVsTeamGameController extends GetxController {
  @override
  void onInit() {
    // initFirstInning();

    super.onInit();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController homeTeamController =
      TextEditingController(text: "hoome");
  TextEditingController awayTeamController =
      TextEditingController(text: "away");

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

  RxList<User> allAvailablePlayers = RxList(
    [
      User(
        name: "Bibek khatri",
        username: "username1",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bibek khatri",
        username: "username2",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bibek khatri",
        username: "username3",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bibek khatri",
        username: "username4",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bibek khatri",
        username: "username5",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bibek khatri",
        username: "username6",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bibek khatri",
        username: "username7",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bibek khatri",
        username: "username8",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bibek khatri",
        username: "username9",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bibek khatri",
        username: "username10",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
    ],
  );

  RxList<User> homeTeamPlayer = RxList([
    User(
      name: "Bibek khatri",
      username: "username1",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
    User(
      name: "Bibek khatri",
      username: "username2",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
    User(
      name: "Bibek khatri",
      username: "username3",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
    User(
      name: "Bibek khatri",
      username: "username4",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
  ]);
  RxList<User> awayTeamPlayer = RxList([
    User(
      name: "Bibek khatri",
      username: "username5",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
    User(
      name: "Bibek khatri",
      username: "username6",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
    User(
      name: "Bibek khatri",
      username: "username7",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
    User(
      name: "Bibek khatri",
      username: "username8",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
  ]);

  TextEditingController selectDateController =
      TextEditingController(text: "2002-02-02");
  TextEditingController selectTimeController =
      TextEditingController(text: "2:30");
  TextEditingController venueController =
      TextEditingController(text: "pokhara");
  TextEditingController numberOfOversController =
      TextEditingController(text: "1");
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
      totalRunTillNow.value -= delivery.runs;
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
  }

  void changeStrike() {
    _changeStrike();
    update();
  }

  void changeBowler(User newBowler) {
    bowler.value = newBowler;
    update();
  }

  addPenalty(Delivery delivery) {
    totalRunTillNow.value += delivery.runs;
    currentPenalty.value += delivery.runs;
    currentBalls.value++;
    bowler.value?.matchBowlingStats?.balls.value++;
  }

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
                      onPressed: () {
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
                      onPressed: () {
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
                      onPressed: () {
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
                      onPressed: () {
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
                    onPressed: () {
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
                    onPressed: () {
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
                    onPressed: () {
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
    // while (lastSevenDeliveries.length > 7) {
    //   lastSevenDeliveries.removeAt(0);
    // }
    print(lastSevenDeliveries);
    _addWicket(delivery);
    await checkAllOut();
    await checkRunScoreOver();
    await checkOverFinish();

    delivery.reset();
    // checkBoxReset();
    update();
  }

  // checkBoxReset() {
  //   isWideSelected.value = false;
  //   isNoBallSelected.value = false;
  //   isByesSelected.value = false;
  //   isLegByesSelected.value = false;
  //   isWicketsSelected.value = false;
  // }

  void undoDelivery(Delivery delivery) {
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
