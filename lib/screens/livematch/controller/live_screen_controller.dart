import 'dart:async';

import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/game/game_datasource.dart';
import 'package:cric_score_connect/models/gamestats/live_match_model.dart';
import 'package:cric_score_connect/screens/dashboard/views/dashboard_screen.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:cric_score_connect/utils/helpers/request_loader.dart';
import 'package:cric_score_connect/utils/routes/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class LiveScreenController extends GetxController {
  var matchKey = "";

  Rxn<LiveMatchStat> liveMatchStat = Rxn();
  Rxn<LiveTeam> bowler = Rxn();
  Rxn<LiveTeam> striker = Rxn();
  Rxn<LiveTeam> nonStriker = Rxn();
  RequestLoader requestLoader = RequestLoader();
  Timer? _timer;

  void startFetching() {
    // Start a timer to fetch data every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      getMatchDetail();
    });
  }

  void stopFetching() {
    // Cancel the timer when no longer needed
    _timer?.cancel();
  }

  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null && args is LiveScreenArgument) {
      matchKey = args.key;
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      geLiveMatchStatForFirstTime();
    });
    super.onInit();
  }

  @override
  void onClose() {
    try {
      stopFetching();
    } catch (_) {
      CustomLogger.trace(_);
    }
    super.onClose();
  }

  var isPageLoading = true.obs;

  geLiveMatchStatForFirstTime() async {
    isPageLoading.value = true;
    requestLoader.show();
    await getMatchDetail();
  }

  Future<void> getMatchDetail() async {
    CoreController cc = Get.find<CoreController>();
    await GameDataSourceRepo.getLiveMatchDetail(
      userId: cc.currentUser.value!.id!,
      matchKey: matchKey,
      onSuccess: (liveMatchStats) async {
        liveMatchStat.value = liveMatchStats;

        liveMatchStat.refresh();
        List<LiveTeam> allPlayers = [
          ...liveMatchStat.value?.homeTeam ?? [],
          ...liveMatchStat.value?.awayTeam ?? []
        ];

        try {
          bowler.value = allPlayers.firstWhere(
            (element) => element.bowler == true,
          );
        } catch (_) {}
        try {
          striker.value =
              allPlayers.firstWhere((element) => element.striker == true);
        } catch (_) {}

        try {
          nonStriker.value =
              allPlayers.firstWhere((element) => element.nonStriker == true);
        } catch (_) {}

        requestLoader.hide();
        isPageLoading.value = false;
        startFetching();
      },
      onError: (message) async {
        if (message.contains("Invalid match key")) {
          requestLoader.hide();
          Get.back();
          CustomSnackBar.error(title: "Reject request", message: message);
        } else if (message.contains("You have not paid for this match")) {
          requestLoader.hide();
          bool? paymenResult = await showDialog(
            context: Get.context!,
            builder: (context) {
              return AlertDialog(
                title: const Text("Payment required!!!"),
                content: const Text(
                    "You haven't made any payement for this game. Please pay with our payement partner khalti."),
                actions: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(
                      ImagePath.khaltiLogo,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back(result: false);
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back(result: true);
                    },
                    child: const Text("OKay"),
                  ),
                ],
              );
            },
          );

          if (paymenResult != null && paymenResult) {
            await KhaltiScope.of(Get.context!).pay(
              config: PaymentConfig(
                amount: 1000, //in paisa
                productIdentity: 'liveId',
                productName: 'Live match',
                mobileReadOnly: false,
              ),
              preferences: [
                PaymentPreference.khalti,
              ],
              onSuccess: (paymentSuccessModel) async {
                CustomLogger.trace(paymentSuccessModel.toString());
                CustomLogger.trace(
                  paymentSuccessModel.idx,
                );
                CoreController cc = Get.find<CoreController>();
                requestLoader.show();
                await GameDataSourceRepo.saveTransaction(
                    transactionId: paymentSuccessModel.idx,
                    userId: cc.currentUser.value!.id!,
                    matchId: matchKey,
                    onSuccess: (message) {
                      requestLoader.hide();
                      Get.back();
                      Get.back();
                      CustomSnackBar.success(
                        title: "Payment success",
                        message:
                            "$message. Please load match again to view it.",
                      );
                    },
                    onError: (message) {
                      requestLoader.hide();
                      Get.back();
                      Get.back();
                      CustomSnackBar.error(
                        title: "Payment success but system error.",
                        message: message,
                      );
                    });
              },
              onFailure: (paymentFailureModel) {
                Get.back();
                CustomSnackBar.error(
                  title: "Payment failure",
                  message: paymentFailureModel.message,
                );
              },
              onCancel: () {
                Get.back();
                CustomSnackBar.error(message: "Cancled by user");
              },
            );
          } else {
            Get.back();
          }
        } else {
          requestLoader.hide();
          Get.back();
          CustomSnackBar.error(title: "Reject request", message: message);
        }
        // requestLoader.hide();
        // isPageLoading.value = false;
      },
    );
  }

  RxList<LiveTeam> get allPlayers => RxList(
        [
          ...liveMatchStat.value?.homeTeam ?? [],
          ...liveMatchStat.value?.awayTeam ?? []
        ],
      );

  // LiveTeam get getStriker =>
  //     allPlayers.value.firstWhere((element) => element.striker == true);
  // LiveTeam get getNonStriker =>
  //     allPlayers.value.firstWhere((element) => element.nonStriker == true);
  // LiveTeam get getBowler =>
  //     allPlayers.value.firstWhere((element) => element.bowler == true);
}

class LiveScreenArgument {
  final String key;
  LiveScreenArgument({required this.key});
}
