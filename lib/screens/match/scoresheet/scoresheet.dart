// import 'package:cric_score_connect/models/overs.dart';
// import 'package:cric_score_connect/models/user.dart';
// import 'package:cric_score_connect/screens/match/delivery.dart';
// import 'package:cric_score_connect/screens/match/enums/extra.dart';
// import 'package:cric_score_connect/screens/match/enums/out.dart';
// import 'package:cric_score_connect/screens/match/player_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ScoresheetController extends GetxController {
//   RxInt target = 0.obs;
//   RxInt currentRuns = 0.obs;
//   RxInt currentWickets = 0.obs;
//   RxInt currentBalls = 0.obs;
//   RxInt currentNoBalls = 0.obs;
//   RxInt currentWides = 0.obs;
//   RxInt currentByes = 0.obs;
//   RxInt currentLegByes = 0.obs;
//   RxInt currentPenalty = 0.obs;
//   RxInt currentBonus = 0.obs;
//   Rx<User> currentBowler1 = User().obs;
//   Rx<User> currentBowler2 = User().obs;
//   Rx<User> currentBatter1 = User().obs;
//   Rx<User> currentBatter2 = User().obs;
//   RxBool isCurrentMaiden = true.obs;
//   RxBool isOverInProgress = false.obs;
//   final PlayerPicker ballPicker;
//   final PlayerPicker batPicker;
//   var lastSevenDeliveries = [].obs;

//   ScoresheetController({
//     required this.batPicker,
//     required this.ballPicker,
//   }) {
//     currentBatter1.value = batPicker.next();
//     currentBatter2.value = batPicker.next();
//     currentBowler1.value = ballPicker.next();
//     currentBowler2.value = ballPicker.next();
//   }

//   void addRuns(Delivery delivery) {
//     isCurrentMaiden.value = false;
//     if (delivery.extras[0] == Extra.none) {
//       _addRunsForBatter(delivery.runs);
//       _addRunsAgainstBowler(delivery.runs);
//       currentRuns.value += delivery.runs;
//       return;
//     }
//     if (delivery.isWide()) {
//       currentRuns.value += delivery.runs + 1;
//       currentWides.value += delivery.runs + 1;
//       _addRunsAgainstBowler(delivery.runs + 1);
//     }
//     if (delivery.isNoBall()) {
//       currentRuns.value++;
//       currentNoBalls.value++;
//       _addRunsAgainstBowler(1);
//       if (delivery.runs > 0 && !delivery.isLegBye() && !delivery.isBye()) {
//         currentRuns.value += delivery.runs;
//         _addRunsForBatter(delivery.runs);
//         _addRunsAgainstBowler(delivery.runs);
//       }
//     }
//     if (delivery.isLegBye()) {
//       currentLegByes.value += delivery.runs;
//       currentRuns.value += delivery.runs;
//     }
//     if (delivery.isBye()) {
//       currentByes.value += delivery.runs;
//       currentRuns.value += delivery.runs;
//     }
//     if (delivery.isPenalty()) {
//       currentRuns.value -= delivery.runs;
//       currentPenalty.value += delivery.runs;
//     }
//     if (delivery.isBonus()) {
//       currentRuns.value += delivery.runs;
//       currentBonus.value += delivery.runs;
//     }
//   }

//   void _addRunsForBatter(int runs) {
//     currentBatter1.value.matchBattingStats.runs += runs;
//   }

//   void _addWicket(Delivery delivery) {
//     if (delivery.out == Out.none) return;
//     if (delivery.out.isBowlersWicket()) {
//       currentBowler1.value.matchBowlingStats.wickets++;
//     }
//     currentWickets.value++;
//     // if (delivery.batter == null) {
//     //   currentBatter1.value.out = delivery.out;
//     //   currentBatter1.value = batPicker.next();
//     //   return;
//     // }
//     // if (delivery.batter == currentBatter1.value) {
//     //   currentBatter1.value.out = delivery.out;
//     //   currentBatter1.value = batPicker.next();
//     // } else {
//     //   currentBatter2.value.out = delivery.out;
//     //   currentBatter2.value = batPicker.next();
//     // }
//   }

//   void _addRunsAgainstBowler(int runs) {
//     currentBowler1.value.matchBowlingStats.runs += runs;
//   }

//   void incrementBalls(Delivery delivery) {
//     if (delivery.extras.isLegitBall()) {
//       isOverInProgress.value = true;
//       currentBalls.value++;
//       currentBatter1.value.matchBattingStats.balls++;
//       currentBowler1.value.matchBowlingStats.balls++;
//     }
//     if (delivery.isNoBall()) {
//       currentBatter1.value.matchBattingStats.balls++;
//     }
//   }

//   void concludeOver() {
//     if (isCurrentMaiden.value) {
//       currentBowler1.value.matchBowlingStats.maidens++;
//     }
//     _changeStrike();
//     _changeBowler();
//     isCurrentMaiden.value = true;
//     isOverInProgress.value = false;
//   }

//   void changeStrike() {
//     _changeStrike();
//     update();
//   }

//   void changeBowler(User newBowler) {
//     currentBowler1.value = newBowler;
//     update();
//   }

//   void recordDelivery(Delivery delivery) {
//     addRuns(delivery);
//     incrementBalls(delivery);
//     _addWicket(delivery);
//     if (delivery.runs % 2 == 1 &&
//         !delivery.isBonus() &&
//         !delivery.isPenalty()) {
//       _changeStrike();
//     }
//     lastSevenDeliveries.add(delivery.shortSummary());
//     if (Over.finished(currentBalls.value) && isOverInProgress.value) {
//       lastSevenDeliveries.add('|');
//       concludeOver();
//     }
//     while (lastSevenDeliveries.length > 7) {
//       lastSevenDeliveries.removeAt(0);
//     }
//     delivery.reset();

//     update();
//   }

//   void undoDelivery(Delivery delivery) {
//     update();
//   }

//   String overs() {
//     return Over.overs(currentBalls.value);
//   }

//   _changeStrike() {
//     var t = currentBatter1.value;
//     currentBatter1.value = currentBatter2.value;
//     currentBatter2.value = t;
//   }

//   _changeBowler() {
//     var t = currentBowler1.value;
//     currentBowler1.value = currentBowler2.value;
//     currentBowler2.value = t;
//   }
// }
