import 'dart:convert';
import 'dart:developer';

import 'package:cric_score_connect/models/access_token.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
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

      CustomLogger.trace(Api.loginUrl);
      CustomLogger.trace(json.encode(body));

      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.loginUrl,
        ),
        headers: headers,
        body: body,
      );

      var responseData = jsonDecode(response.body);
      CustomLogger.trace(" login decoded response : -> $responseData");
      //check status code
      if (response.statusCode == 200) {
        if (responseData.toString().contains("token")) {
          AccessToken token = AccessToken.fromJson(responseData);
          User user = User.fromJson(
            responseData["user"],
          );
          onSuccess(user, token);
        } else {
          onError("Invalid data available");
        }
      } else {
        if (responseData.toString().contains("error")) {
          onError(responseData["error"]);
        } else {
          onError("Sorry something went wrong");
        }
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry something went wrong");
    }
  }
}



      // return onSuccess(
      //   User(
      //     name: "Bimal khatri",
      //     username: "username",
      //     email: "email@gmail.com",
      //     address: "Pokhara",
      //     dob: "2002-07-07",
      //     phone: "98677743236",
      //   ),
      //   AccessToken(accessToken: "token"),

      // );
