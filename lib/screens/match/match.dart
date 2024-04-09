import 'team.dart';
import 'package:get/get.dart';

class MatchController extends GetxController {
  var firstInnings = true.obs;
  static const defaultHomeTeamName = 'T1';
  static const defaultAwayTeamName = 'T2';
  var _totalOvers = 0.obs;
  int get totalOvers => _totalOvers.value;
  set totalOvers(int val) => _totalOvers.value = val;

  var _maxPlayers = 11.obs;
  int get maxPlayers => _maxPlayers.value;
  set maxPlayers(int val) => _maxPlayers.value = val;

  var frozen = false.obs;
  final homeTeam = Team(name: defaultHomeTeamName, players: []).obs;
  final awayTeam = Team(name: defaultAwayTeamName, players: []).obs;
  Team? tossTeam;
  Team? battingTeam;
  var target = 0.obs;

  Team get bowlingTeam {
    if (homeTeam.value.isBatting) return awayTeam.value;
    return homeTeam.value;
  }

  void start({required Team toss, required Team batting}) {
    tossTeam = toss;
    battingTeam = batting;
    battingTeam!.isBatting = true;
    bowlingTeam.isBatting = false;
    update();
  }

  void endFirstInnings() {
    firstInnings.value = false;
    var currentBatting = battingTeam;
    currentBatting!.isBatting = false;
    bowlingTeam.isBatting = true;
    battingTeam = bowlingTeam;
    battingTeam = currentBatting;
    update();
  }

  void end() {
    frozen.value = true;
  }
}



// class BallEvent extends MatchEvent {
//   BallEvent() : super();
//   int runs;
//   Out out;
//   Extra extra;
//   Player batter;
//   Player bowler;
//   Player outPlayer;
//   @override
//   void process(Match match) {
//     // TODO: implement process
//   }

//   @override
//   void undo(Match match) {
//     // TODO: implement undo
//   }
// }
