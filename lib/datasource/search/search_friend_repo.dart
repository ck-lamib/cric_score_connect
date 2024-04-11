import 'dart:convert';
import 'dart:developer';

import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:cric_score_connect/utils/helpers/http_request.dart';
import 'package:cric_score_connect/utils/routes/api.dart';
import 'package:http/http.dart' as http;

class SearchFriendRepo {
  static Future<void> searchFriend({
    required String query,
    required Function(List<User> userList) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
      };

      CustomLogger.trace(Api.searchUrl);
      var body = {
        "query": query,
      };
      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.searchUrl,
        ),
        headers: headers,
        body: body,
      );

      var responseData = jsonDecode(response.body);
      CustomLogger.trace("register decoded response : -> $responseData");
      //check status code
      if (response.statusCode == 200) {
        List<User> users = userFromJson(responseData);
        onSuccess(users);
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
