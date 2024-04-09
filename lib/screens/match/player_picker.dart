import 'dart:collection';

import 'package:cric_score_connect/models/user.dart';

class PlayerPicker {
  List<User> players;
  var alreadyPicked = HashMap<int, bool>();
  var lastIndex = 0;
  PlayerPicker(this.players);
  User next() {
    return players[lastIndex++];
  }
}
