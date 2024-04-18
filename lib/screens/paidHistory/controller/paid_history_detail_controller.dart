import 'dart:async';

import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/game/game_datasource.dart';
import 'package:cric_score_connect/models/gamestats/live_match_model.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/request_loader.dart';
import 'package:get/get.dart';

class PaidHistoryDetailController extends GetxController {
  var matchKey = "";

  Rxn<LiveMatchStat> matchStat = Rxn();

  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null && args is PaidHistoryDetailArgument) {
      matchKey = args.key;
    }
    Future.delayed(const Duration(seconds: 1), () {
      getPaidHistoryDetail();
    });
    super.onInit();
  }

  var isPageLoading = true.obs;

  getPaidHistoryDetail() {
    RequestLoader requestLoader = RequestLoader();
    isPageLoading.value = true;
    requestLoader.show();

    GameDataSourceRepo.getPaidMatchHistoryDetail(
      matchKey: matchKey,
      matchId: matchKey,
      onSuccess: (result) {
        matchStat.value = result;
        isPageLoading.value = false;
        requestLoader.hide();
      },
      onError: (message) {
        Get.back();
        isPageLoading.value = false;
        requestLoader.hide();
        CustomSnackBar.error(message: message);
      },
    );
  }
}

class PaidHistoryDetailArgument {
  final String key;
  PaidHistoryDetailArgument({required this.key});
}
