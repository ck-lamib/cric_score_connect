import 'dart:convert';
import 'dart:developer';

import 'package:cric_score_connect/models/access_token.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:cric_score_connect/utils/helpers/http_request.dart';
import 'package:cric_score_connect/utils/routes/api.dart';
import 'package:http/http.dart' as http;

class RegisterRepo {
  static Future<void> register({
    required String fullName,
    required String userName,
    required String email,
    required String dob,
    required String phone,
    required String address,
    required String password,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
        // "Content-Type": "application/json",
      };

      var body = {
        "name": fullName,
        "username": userName,
        "email": email,
        "dob": dob,
        "phone": phone,
        "password": password.trim(),
        "address": address,
      };

      //   "name": fullName,
      //   "userName": userName,
      //   "email": email,
      //   "dob": dob,
      //   "phone": phone,
      //   "address": address,
      //   "password": password.trim(),
      // };
      CustomLogger.trace(Api.signupUrl);
      CustomLogger.trace(json.encode(body));

      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.signupUrl,
        ),
        headers: headers,
        body: body,
      );

      var responseData = jsonDecode(response.body);
      CustomLogger.trace("register decoded response : -> $responseData");
      //check status code
      if (response.statusCode == 403) {
        if (responseData.toString().contains("Email verification required")) {
          onSuccess("Email verification required");
        } else {
          onError("Invalid data available");
        }
      } else {
        if (responseData.toString().contains("error")) {
          onError(responseData["error"]);
        } else {
          if (response.statusCode == 500) {
            onSuccess("Email verification required");
          } else {
            onError("Sorry something went wrong");
          }
        }
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry something went wrongg");
    }
  }
}
