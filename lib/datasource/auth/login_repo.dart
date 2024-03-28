import 'dart:convert';
import 'dart:developer';

import 'package:cric_score_connect/models/access_token.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/utils/helpers/http_request.dart';
import 'package:cric_score_connect/utils/routes/api.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  static Future<void> login({
    required String email,
    required String password,
    required Function(User user, AccessToken token) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
        // "Content-Type": "application/json",
      };

      var body = {
        "email": email,
        "password": password,
      };

      // http.Response response = await HttpRequest.post(Uri.parse(Api.loginUrl),
      //     headers: headers, body: body);

      // log("${Api.loginUrl} ===================>");
      // log(json.encode(body));
      // log(response.body);

      // dynamic data = jsonDecode(response.body);
      // if (data["success"]) {
      //   AccessToken token = AccessToken.fromJson(data["data"]["token"]);
      //   User user = User.fromJson(data["data"]["user"]);
      //   onSuccess(user, token);
      // } else {
      //   onError(data["message"]);
      // }
      AccessToken token = AccessToken(
        accessToken: "access token",
        tokenType: "Bearer",
        expiresAt: "2024-15-15",
      );

      User user = User(
          fullName: "Bimal khatri",
          playerName: "ninja123",
          email: "bimal@gmail.com",
          phone: "9867743236",
          dob: "2002-07-07",
          address: "Pokhara",
          playerType: "All rounder",
          avatar: "https://bimalkhatri.com.np/img/hell.png");
      Future.delayed(
        const Duration(seconds: 5),
        () {
          onSuccess(user, token);
          // onError("Sorry something went wrong");
        },
      );
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry something went wrong");
    }
  }
}
