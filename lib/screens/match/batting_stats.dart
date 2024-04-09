import 'package:cric_score_connect/models/overs.dart';
import 'package:get/get.dart';

class MatchBattingStats {
  var runs = 0.obs;
  var balls = 0.obs;
  var fours = 0.obs;
  var sixes = 0.obs;
  var fellOnScore = 0.obs;
  var fellOnBall = 0.obs;

  String get fellAtOver => Over.overs(fellOnBall.value);

  MatchBattingStats();
}
