import 'package:cric_score_connect/models/overs.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/screens/game/views/gaming/fall_of_wicket.dart';
import 'package:cric_score_connect/screens/game/views/gaming/next_over.dart';
import 'package:cric_score_connect/screens/game/widgets/gaming/fall_of_wicket_app_bar.dart';
import 'package:cric_score_connect/screens/match/batting_stats.dart';
import 'package:cric_score_connect/screens/match/bowling_stats.dart';
import 'package:cric_score_connect/screens/match/delivery.dart';
import 'package:cric_score_connect/screens/match/enums/extra.dart';
import 'package:cric_score_connect/screens/match/enums/out.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamVsTeamGameController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController homeTeamController =
      TextEditingController(text: "hoome");
  TextEditingController awayTeamController =
      TextEditingController(text: "away");

  //game setting page
  GlobalKey<FormState> gameSettingFormKey = GlobalKey<FormState>();

  TextEditingController totalNumberOfPlayer = TextEditingController(text: "2");
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
  ]);
  RxList<User> awayTeamPlayer = RxList([
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

  Rxn<User?> bowler = Rxn(
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
  );
  Rxn<User?> striker = Rxn(
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
  );
  Rxn<User?> nonStriker = Rxn(
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
  );
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

  //pick players
  var batterRecord = [];
  var bowlerRecord = [];

  //gaming screen
  var totalRunTillNow = 0.obs;
  var totalWicketTillNow = 0.obs;
  var crr = 0.0.obs;
  var rrr = 0.0.obs;
  var target = 0.0.obs;

  var gameData = [];

  // swapStrikers({required int score}) {
  //   bool swapUser = score % 2 != 0;
  //   if (swapUser) {
  //     User toBeStriker = nonStriker.value!;
  //     nonStriker.value = striker.value;
  //     striker.value = toBeStriker;
  //   }
  // }

  //record batting history
  List battingHistory = [];

  //recored bowling history
  List bowlingHistory = [];

  //matching
  bool firstInnings = true;

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

  void recordDelivery(Delivery delivery) async {
    // print("===> over is completed");

    // if wicket then get reason and next player
    if (delivery.out != Out.none) {
      //check out
      var result = await showDialog(
          context: Get.context!,
          builder: (context) {
            // return NextOverScreen(
            //   bowlingTeam: bowlingTeam,
            //   currentBowler: bowler.value!,
            // );
            return FallOfWicketScreen();
          });
      if (result != null) {
        addRuns(delivery);
        incrementBalls(delivery);
        _addWicket(delivery);
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
      } else {
        CustomSnackBar.error(
          title: "Missing wicket reason",
          message: "Please add wickets reason.",
        );

        return;
      }
    } else {
      addRuns(delivery);
      incrementBalls(delivery);
      _addWicket(delivery);
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
    }

    delivery.reset();
    update();
  }

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
