import 'package:cric_score_connect/models/overs.dart';
import 'package:get/get.dart';

class MatchBowlingStats {
  var runs = 0.obs;
  var balls = 0.obs;
  var fours = 0.obs;
  var sixes = 0.obs;
  var wides = 0.obs;
  var noBalls = 0.obs;
  var maidens = 0.obs;
  var wickets = 0.obs;
  var overs = 0.0.obs;
  String get oversBowled => Over.overs(balls.value);
}
