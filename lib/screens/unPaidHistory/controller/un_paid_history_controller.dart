import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/game/game_datasource.dart';
import 'package:cric_score_connect/models/gamestats/match_history_model.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:get/get.dart';

class UnPaidHistoryScreenController extends GetxController {
  @override
  void onInit() {
    getUnPaidMatchHistoryDetail();
    super.onInit();
  }

  RxList<MatchHistoryModel> matchHistoryModelList = RxList();
  var isDataLoading = true.obs;

  Future<void> getUnPaidMatchHistoryDetail() async {
    isDataLoading.value = true;
    CoreController cc = Get.find<CoreController>();
    await GameDataSourceRepo.getUnPaidMatchHistorys(
      userId: cc.currentUser.value!.id!,
      onSuccess: (listss) async {
        matchHistoryModelList.value = listss;
        matchHistoryModelList.refresh();
        isDataLoading.value = false;
      },
      onError: (message) {
        CustomSnackBar.error(title: "Reject request", message: message);
        isDataLoading.value = false;
        matchHistoryModelList.value = [];
      },
    );
  }
}
