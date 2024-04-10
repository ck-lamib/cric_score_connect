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
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bimal khatri",
        username: "username2",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bimal khatri",
        username: "username3",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bimal khatri",
        username: "username4",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bimal khatri",
        username: "username5",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bimal khatri",
        username: "username6",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bimal khatri",
        username: "username7",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bimal khatri",
        username: "username8",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bimal khatri",
        username: "username9",
        email: "email@gmail.com",
        address: "Pokhara",
        dob: "2002-07-07",
        phone: "98677743236",
        matchBattingStats: MatchBattingStats(),
        matchBowlingStats: MatchBowlingStats(),
      ),
      User(
        name: "Bimal khatri",
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
      name: "Bimal khatri",
      username: "username1",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
    User(
      name: "Bimal khatri",
      username: "username2",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
    User(
      name: "Bimal khatri",
      username: "username3",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
    User(
      name: "Bimal khatri",
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
      name: "Bimal khatri",
      username: "username5",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
    User(
      name: "Bimal khatri",
      username: "username6",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
    User(
      name: "Bimal khatri",
      username: "username7",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
    User(
      name: "Bimal khatri",
      username: "username8",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
      matchBattingStats: MatchBattingStats(),
      matchBowlingStats: MatchBowlingStats(),
    ),
  ]);

  TextEditingController selectDateController = TextEditingController();
  TextEditingController selectTimeController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  TextEditingController numberOfOversController = TextEditingController();
  String? tossWinner;
  String? optedTo;

//select opening player

  GlobalKey<FormState> selectOpeningPlayerFormKey = GlobalKey<FormState>();

//first inning;
  // Rxn<User?> firstInningOpeningBowler = Rxn(
  //   User(
  //     name: "Bimal khatri",
  //     username: "username5",
  //     email: "email@gmail.com",
  //     address: "Pokhara",
  //     dob: "2002-07-07",
  //     phone: "98677743236",
  //     matchBattingStats: MatchBattingStats(),
  //     matchBowlingStats: MatchBowlingStats(),
  //   ),
  // );
  // Rxn<User?> firstInningStriker = Rxn(
  //   User(
  //     name: "Bimal khatri",
  //     username: "username1",
  //     email: "email@gmail.com",
  //     address: "Pokhara",
  //     dob: "2002-07-07",
  //     phone: "98677743236",
  //     matchBattingStats: MatchBattingStats(),
  //     matchBowlingStats: MatchBowlingStats(),
  //   ),
  // );
  // Rxn<User?> firstInningNonStriker = Rxn(
  //   User(
  //     name: "Bimal khatri",
  //     username: "username2",
  //     email: "email@gmail.com",
  //     address: "Pokhara",
  //     dob: "2002-07-07",
  //     phone: "98677743236",
  //     matchBattingStats: MatchBattingStats(),
  //     matchBowlingStats: MatchBowlingStats(),
  //   ),
  // );

  // late InningDetail firstInning;
  // initFirstInning() {
  //   firstInning = InningDetail(
  //     isFirstInning: true,
  //     battingTeam: RxList([
  //       User(
  //         name: "Bimal khatri",
  //         username: "username1",
  //         email: "email@gmail.com",
  //         address: "Pokhara",
  //         dob: "2002-07-07",
  //         phone: "98677743236",
  //         matchBattingStats: MatchBattingStats(),
  //         matchBowlingStats: MatchBowlingStats(),
  //       ),
  //       User(
  //         name: "Bimal khatri",
  //         username: "username2",
  //         email: "email@gmail.com",
  //         address: "Pokhara",
  //         dob: "2002-07-07",
  //         phone: "98677743236",
  //         matchBattingStats: MatchBattingStats(),
  //         matchBowlingStats: MatchBowlingStats(),
  //       ),
  //       User(
  //         name: "Bimal khatri",
  //         username: "username3",
  //         email: "email@gmail.com",
  //         address: "Pokhara",
  //         dob: "2002-07-07",
  //         phone: "98677743236",
  //         matchBattingStats: MatchBattingStats(),
  //         matchBowlingStats: MatchBowlingStats(),
  //       ),
  //       User(
  //         name: "Bimal khatri",
  //         username: "username4",
  //         email: "email@gmail.com",
  //         address: "Pokhara",
  //         dob: "2002-07-07",
  //         phone: "98677743236",
  //         matchBattingStats: MatchBattingStats(),
  //         matchBowlingStats: MatchBowlingStats(),
  //       ),
  //     ]),
  //     bowlingTeam: RxList(
  //       [
  //         User(
  //           name: "Bimal khatri",
  //           username: "username5",
  //           email: "email@gmail.com",
  //           address: "Pokhara",
  //           dob: "2002-07-07",
  //           phone: "98677743236",
  //           matchBattingStats: MatchBattingStats(),
  //           matchBowlingStats: MatchBowlingStats(),
  //         ),
  //         User(
  //           name: "Bimal khatri",
  //           username: "username6",
  //           email: "email@gmail.com",
  //           address: "Pokhara",
  //           dob: "2002-07-07",
  //           phone: "98677743236",
  //           matchBattingStats: MatchBattingStats(),
  //           matchBowlingStats: MatchBowlingStats(),
  //         ),
  //         User(
  //           name: "Bimal khatri",
  //           username: "username7",
  //           email: "email@gmail.com",
  //           address: "Pokhara",
  //           dob: "2002-07-07",
  //           phone: "98677743236",
  //           matchBattingStats: MatchBattingStats(),
  //           matchBowlingStats: MatchBowlingStats(),
  //         ),
  //         User(
  //           name: "Bimal khatri",
  //           username: "username8",
  //           email: "email@gmail.com",
  //           address: "Pokhara",
  //           dob: "2002-07-07",
  //           phone: "98677743236",
  //           matchBattingStats: MatchBattingStats(),
  //           matchBowlingStats: MatchBowlingStats(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

//second inning;
  // late InningDetail secondInning;
  // initSecondInning() {
  //   secondInning = InningDetail(
  //     isFirstInning: false,
  //     battingTeam: RxList([
  //       User(
  //         name: "Bimal khatri",
  //         username: "username5",
  //         email: "email@gmail.com",
  //         address: "Pokhara",
  //         dob: "2002-07-07",
  //         phone: "98677743236",
  //         matchBattingStats: MatchBattingStats(),
  //         matchBowlingStats: MatchBowlingStats(),
  //       ),
  //       User(
  //         name: "Bimal khatri",
  //         username: "username6",
  //         email: "email@gmail.com",
  //         address: "Pokhara",
  //         dob: "2002-07-07",
  //         phone: "98677743236",
  //         matchBattingStats: MatchBattingStats(),
  //         matchBowlingStats: MatchBowlingStats(),
  //       ),
  //       User(
  //         name: "Bimal khatri",
  //         username: "username7",
  //         email: "email@gmail.com",
  //         address: "Pokhara",
  //         dob: "2002-07-07",
  //         phone: "98677743236",
  //         matchBattingStats: MatchBattingStats(),
  //         matchBowlingStats: MatchBowlingStats(),
  //       ),
  //       User(
  //         name: "Bimal khatri",
  //         username: "username8",
  //         email: "email@gmail.com",
  //         address: "Pokhara",
  //         dob: "2002-07-07",
  //         phone: "98677743236",
  //         matchBattingStats: MatchBattingStats(),
  //         matchBowlingStats: MatchBowlingStats(),
  //       ),
  //     ]),
  //     bowlingTeam: RxList([
  //       User(
  //         name: "Bimal khatri",
  //         username: "username1",
  //         email: "email@gmail.com",
  //         address: "Pokhara",
  //         dob: "2002-07-07",
  //         phone: "98677743236",
  //         matchBattingStats: MatchBattingStats(),
  //         matchBowlingStats: MatchBowlingStats(),
  //       ),
  //       User(
  //         name: "Bimal khatri",
  //         username: "username2",
  //         email: "email@gmail.com",
  //         address: "Pokhara",
  //         dob: "2002-07-07",
  //         phone: "98677743236",
  //         matchBattingStats: MatchBattingStats(),
  //         matchBowlingStats: MatchBowlingStats(),
  //       ),
  //       User(
  //         name: "Bimal khatri",
  //         username: "username3",
  //         email: "email@gmail.com",
  //         address: "Pokhara",
  //         dob: "2002-07-07",
  //         phone: "98677743236",
  //         matchBattingStats: MatchBattingStats(),
  //         matchBowlingStats: MatchBowlingStats(),
  //       ),
  //       User(
  //         name: "Bimal khatri",
  //         username: "username4",
  //         email: "email@gmail.com",
  //         address: "Pokhara",
  //         dob: "2002-07-07",
  //         phone: "98677743236",
  //         matchBattingStats: MatchBattingStats(),
  //         matchBowlingStats: MatchBowlingStats(),
  //       ),
  //     ]),
  //     // bowler: firstInningOpeningBowler,
  //     // striker: firstInningStriker,
  //     // nonStriker: firstInningNonStriker,
  //   );
  // }

  // InningDetail get getInningDetail => firstInning;

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
    isCurrentMaiden.value = false;
    if (delivery.extras[0] == Extra.none) {
      _addRunsForBatter(delivery.runs);
      _addRunsAgainstBowler(delivery.runs);
      totalRunTillNow.value += delivery.runs;
      return;
    }
    if (delivery.isWide()) {
      totalRunTillNow.value += delivery.runs + 1;
      currentWides.value += delivery.runs + 1;
      _addRunsAgainstBowler(delivery.runs + 1);
    }
    if (delivery.isNoBall()) {
      totalRunTillNow.value++;
      currentNoBalls.value++;
      _addRunsAgainstBowler(1);
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
    if (delivery.extras.isLegitBall()) {
      isOverInProgress.value = true;
      currentBalls.value++;
      striker.value?.matchBattingStats?.balls.value++;
      bowler.value?.matchBowlingStats?.balls.value++;
    }
    if (delivery.isNoBall()) {
      striker.value?.matchBattingStats?.balls++;
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

  void recordDelivery(Delivery delivery) async {
    MatchController matchController = Get.find<MatchController>();
    print(matchController.getInningDetail.isFirstInning);
    if (outBattingTeam.length == battingTeam.length) {
      TeamVsTeamGameController teamGameController =
          Get.find<TeamVsTeamGameController>();

      if (matchController.getInningDetail.isFirstInning == false) {
        await showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text("End of Game"),
                content: const Text("Press continue to end game."),
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
                content: const Text("Press continue for second inning."),
                actions: [
                  TextButton(
                    onPressed: () {
                      matchController.endFirstInnings();
                      teamGameController.target.value = matchController
                          .firstInningDetail.totalRunTillNow.value
                          .toDouble();
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
      // matchController.start(
      //                                     tossWinnerr:
      //                                         c.homeTeamController.text,
      //                                     optedToo: "Bat",
      //                                     battingT: c.homeTeamPlayer,
      //                                     bowlingT: c.awayTeamPlayer,
      //                                   );
    }

    // print("===> over is completed");

    // if wicket then get reason and next player

    addRuns(delivery);
    incrementBalls(delivery);
    if (delivery.runs % 2 == 1 &&
        !delivery.isBonus() &&
        !delivery.isPenalty()) {
      _changeStrike();
    }
    lastSevenDeliveries.add(delivery.shortSummary());
    if (Over.finished(currentBalls.value) && isOverInProgress.value) {
      lastSevenDeliveries.add('|');
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
    while (lastSevenDeliveries.length > 7) {
      lastSevenDeliveries.removeAt(0);
    }
    _addWicket(delivery);

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
  }) {
    isFirstInnings = true;
    isSecondInnings = false;
    tossWinner = tossWinnerr;
    optedTo = optedToo;
    battingTeam = battingT;
    bowlingTeam = bowlingT;
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
