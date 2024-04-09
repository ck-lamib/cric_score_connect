import 'package:cric_score_connect/models/user.dart';

class Team {
  String name;

  var isBatting = false;
  List<User> players = [];
  bool get isBowling => !isBatting;

  Team({
    required this.name,
    required this.players,
  });
}
