import 'dart:async';

import 'package:cric_score_connect/datasource/game/game_datasource.dart';
import 'package:cric_score_connect/models/gamestats/live_match_model.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/request_loader.dart';
import 'package:get/get.dart';

class HistoryDetailController extends GetxController {
  var matchKey = "";

  Rxn<LiveMatchStat> liveMatchStat = Rxn();
  Rxn<LiveTeam> bowler = Rxn();
  Rxn<LiveTeam> striker = Rxn();
  Rxn<LiveTeam> nonStriker = Rxn();

  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null && args is HistoryDetailArgument) {
      matchKey = args.key;
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      geLiveMatchStatForFirstTime();
    });
    super.onInit();
  }

  var isPageLoading = true.obs;

  geLiveMatchStatForFirstTime() async {
    isPageLoading.value = true;
    RequestLoader requestLoader = RequestLoader();
    requestLoader.show();
    await getMatchDetail().whenComplete(
      () {
        requestLoader.hide();
        isPageLoading.value = false;
      },
    );
  }

  Future<void> getMatchDetail() async {
    await GameDataSourceRepo.getLiveMatchDetail(
      onSuccess: (liveMatchStats) async {
        liveMatchStat.value = liveMatchStats;

        liveMatchStat.refresh();
        List<LiveTeam> allPlayers = [
          ...liveMatchStat.value?.homeTeam ?? [],
          ...liveMatchStat.value?.awayTeam ?? []
        ];
        bowler.value =
            allPlayers.firstWhere((element) => element.bowler == true);
        striker.value =
            allPlayers.firstWhere((element) => element.striker == true);
        nonStriker.value =
            allPlayers.firstWhere((element) => element.nonStriker == true);
      },
      onError: (message) {
        CustomSnackBar.error(title: "Reject request", message: message);
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

class HistoryDetailArgument {
  final String key;
  HistoryDetailArgument({required this.key});
}
