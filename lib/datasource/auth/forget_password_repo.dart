import 'dart:convert';
import 'dart:developer';

import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:cric_score_connect/utils/helpers/http_request.dart';
import 'package:cric_score_connect/utils/routes/api.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordRepo {
  static Future<void> forgetPassword({
    required String email,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
        // "Content-Type": "application/json",
      };

      var body = {
        "email": email,
      };

      CustomLogger.trace(Api.forgetPasswordUrl);
      CustomLogger.trace(json.encode(body));

      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.forgetPasswordUrl,
        ),
        headers: headers,
        body: body,
      );

      var responseData = jsonDecode(response.body);
      CustomLogger.trace(
          " forget password decoded response : -> $responseData");
      //check status code
      if (response.statusCode == 200) {
        if (responseData.toString().contains("message")) {
          onSuccess(responseData["message"]);
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
