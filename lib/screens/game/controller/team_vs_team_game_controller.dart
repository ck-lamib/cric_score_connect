import 'package:cric_score_connect/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamVsTeamGameController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController homeTeamController = TextEditingController();
  TextEditingController awayTeamController = TextEditingController();

  //game setting page
  GlobalKey<FormState> gameSettingFormKey = GlobalKey<FormState>();

  TextEditingController totalNumberOfPlayer = TextEditingController(text: "6");
  var hasNoBall = true.obs;
  toggleHasNoBall(bool value) {
    hasNoBall.value = value;
  }

  var hasNoBallReball = true.obs;
  toggleHasNoBallReball(bool value) {
    hasNoBallReball.value = value;
  }

  TextEditingController noBallRunController = TextEditingController(text: "1");
  var hasWideBall = true.obs;
  toggleHasWideBall(bool value) {
    hasWideBall.value = value;
  }

  var hasWideBallReball = true.obs;
  toggleHasWideBallReball(bool value) {
    hasWideBallReball.value = value;
  }

  TextEditingController wideBallRunController =
      TextEditingController(text: "1");

  //create game
  RxList<User> allAvailablePlayers = RxList([
    User(
      name: "Bimal khatri",
      username: "username1",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
    ),
    User(
      name: "Bimal khatri",
      username: "username2",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
    ),
    User(
      name: "Bimal khatri",
      username: "username3",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
    ),
    User(
      name: "Bimal khatri",
      username: "username4",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
    ),
    User(
      name: "Bimal khatri",
      username: "username5",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
    ),
    User(
      name: "Bimal khatri",
      username: "username6",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
    ),
    User(
      name: "Bimal khatri",
      username: "username7",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
    ),
    User(
      name: "Bimal khatri",
      username: "username8",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
    ),
    User(
      name: "Bimal khatri",
      username: "username9",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
    ),
    User(
      name: "Bimal khatri",
      username: "username10",
      email: "email@gmail.com",
      address: "Pokhara",
      dob: "2002-07-07",
      phone: "98677743236",
    ),
  ]);

  RxList<User> homeTeamPlayer = RxList();
  RxList<User> awayTeamPlayer = RxList();
}
