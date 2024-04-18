import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/game/game_datasource.dart';
import 'package:cric_score_connect/models/gamestats/live_match_model.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:get/get.dart';

class HistoryScreenController extends GetxController {
  @override
  void onInit() {
    getMatchHistoryDetail();
    super.onInit();
  }

  RxList<LiveMatchStat> liveMatchStatList = RxList();
  var isDataLoading = true.obs;

  Future<void> getMatchHistoryDetail() async {
    isDataLoading.value = true;
    CoreController cc = Get.find<CoreController>();
    await GameDataSourceRepo.getMatchHistoryDetail(
      userId: cc.currentUser.value!.id!,
      onSuccess: (liveMatchStatsListt) async {
        liveMatchStatList.value = liveMatchStatsListt;
        liveMatchStatList.refresh();
        isDataLoading.value = false;
      },
      onError: (message) {
        CustomSnackBar.error(title: "Reject request", message: message);
        isDataLoading.value = false;
        liveMatchStatList.value = [];
      },
    );
  }
}
