import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/screens/game/views/selectplayer/team_vs_team_select_player.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:get/get.dart';

class SelectPlayerController extends GetxController {
  RxList<User> allGamePlayer = RxList();
  RxList<User> selectedTeamPlayer = RxList();
  RxList<User> allSelectedPlayer = RxList();
  RxList<User> availablePlayer = RxList();
  int maxPlayerCount = 6;

  @override
  void onInit() {
    var arguments = Get.arguments;
    if (arguments != null && arguments is SelectedPlayerArgument) {
      allGamePlayer.value = arguments.allGamePlayer;
      selectedTeamPlayer.value = arguments.selectedTeamPlayer;
      allSelectedPlayer.value = arguments.allSelectedPlayer;
      maxPlayerCount = arguments.maxPlayer;
    }
    availablePlayer.value = getAllAvailablePlayer();
    super.onInit();
  }

  List<User> getAllAvailablePlayer() {
    // Finding players who are selected but not in the player list
    List<User> notSelectedPlayers = allSelectedPlayer
        .where((selectedPlayer) => !selectedTeamPlayer
            .any((player) => player.username == selectedPlayer.username))
        .toList();

    // Removing not selected players from the game player list
    List<User> gamePlayer = allGamePlayer
        .where((player) => !notSelectedPlayers.any((notSelectedPlayer) =>
            notSelectedPlayer.username == player.username))
        .toList();
    return gamePlayer;
  }

  void onDone() {
    return Get.back(
      result: SelectedPlayerArgument(
          allGamePlayer: allGamePlayer,
          selectedTeamPlayer: selectedTeamPlayer,
          allSelectedPlayer: allSelectedPlayer),
    );
  }

  togglePlayer({bool? value, required User user}) {
    if (value != null) {
      if (value) {
        //add to selected team
        if (selectedTeamPlayer.length < maxPlayerCount) {
          selectedTeamPlayer.add(user);
        } else {
          CustomSnackBar.info(
            title: "Selection failed!",
            message:
                "You cannot add more than maximum listed player. To change go to the advance setting in create game page.",
          );
        }
      } else {
        //remove from team

        selectedTeamPlayer.removeWhere((e) => e.username == user.username);
      }
    }
    selectedTeamPlayer.refresh();
  }
}
