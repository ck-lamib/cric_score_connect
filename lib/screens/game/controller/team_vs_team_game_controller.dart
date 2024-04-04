import 'package:cric_score_connect/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamVsTeamGameController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController homeTeamController = TextEditingController();
  TextEditingController awayTeamController = TextEditingController();

  List<User> homeTeamPlayer = [];
  List<User> awayTeamPlayer = [];
}
