// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:cric_score_connect/models/access_token.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:get_storage/get_storage.dart';

class StorageKeys {
  static const String USER = "user";
  static const String ACCESS_TOKEN = "accessToken";
}

class StorageHelper {
  static AccessToken? getToken() {
    try {
      final box = GetStorage();
      AccessToken token = AccessToken.fromJson(
          jsonDecode(box.read(StorageKeys.ACCESS_TOKEN)) ?? "");
      return token;
    } catch (e) {
      log("Failed to fetch token");
      return null;
    }
  }

  static User? getUser() {
    try {
      final box = GetStorage();
      User user = User.fromJson(json.decode(box.read(StorageKeys.USER)));

      return user;
    } catch (e) {
      log("Failed fetch customer");
      return null;
    }
  }
}
