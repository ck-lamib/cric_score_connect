import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/friend/friends_repo.dart';
import 'package:cric_score_connect/datasource/userstats/userstat.dart';
import 'package:cric_score_connect/models/gamestats/game_stats.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/screens/friend/controller/friend_screen_controller.dart';
import 'package:cric_score_connect/screens/search/controller/search_controller.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/request_loader.dart';
import 'package:get/get.dart';

class GameProfileController extends GetxController {
  final Rxn<GameStats> gameStats = Rxn();
  var showAddFriend = false.obs;

  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null && args is GameProfileArgument) {
      gameStats.value = args.gameStats;
      showAddFriend.value = true;
    }
    super.onInit();
  }

  var isAddFriendSuccess = false.obs;
  addFriend(User user) async {
    RequestLoader requestLoader = RequestLoader();
    CoreController cc = Get.find<CoreController>();
    int senderId = cc.currentUser.value!.id!;

    requestLoader.show();
    await FriendRepo.friendRequest(
      receiverId: user.id!,
      senderId: senderId,
      onSuccess: (message) async {
        requestLoader.hide();
        isAddFriendSuccess.value = true;
        CustomSnackBar.success(
            title: "Friend Request",
            message: "Friend request sent successfull");
        SearchScreenController ssc = Get.find<SearchScreenController>();
        ssc.searchedUser.removeWhere((element) => element.id == user.id);
        ssc.searchedUser.refresh();
      },
      onError: (message) {
        requestLoader.hide();
        CustomSnackBar.success(title: "Friend Request", message: message);
      },
    );
  }
}

class GameProfileArgument {
  final GameStats gameStats;
  final bool showAddFriend;
  GameProfileArgument({
    required this.gameStats,
    required this.showAddFriend,
  });
}

class GetGameProfileStat {
  static Future<GameStats?> getGameStats({required int userId}) async {
    GameStats? gameStats;
    RequestLoader requestLoader = RequestLoader();
    requestLoader.show();

    await UserStatsRepo.getUserStat(
      userId: userId,
      onSuccess: (gameStas) async {
        requestLoader.hide();
        gameStats = gameStas;
      },
      onError: (message) {
        requestLoader.hide();
        CustomSnackBar.error(title: "Failed", message: message);
      },
    );
    return gameStats;
  }
}
