import 'package:cric_score_connect/models/gamestats/live_match_model.dart';
import 'package:get/get.dart';

class HistoryDetailController extends GetxController {
  var matchKey = "";

  Rxn<LiveMatchStat> matchStat = Rxn();

  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null && args is LiveMatchStat) {
      matchStat.value = args;
    }

    super.onInit();
  }
}

class HistoryDetailArgument {
  final String key;
  HistoryDetailArgument({required this.key});
}
