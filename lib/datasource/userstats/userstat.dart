import 'dart:convert';
import 'dart:developer';

import 'package:cric_score_connect/models/gamestats/game_stats.dart';
import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:cric_score_connect/utils/helpers/http_request.dart';
import 'package:cric_score_connect/utils/routes/api.dart';
import 'package:http/http.dart' as http;

class UserStatsRepo {
  static Future<void> getUserStat({
    required int userId,
    required Function(GameStats gameStats) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
      };

      CustomLogger.trace(Api.getUserStatUrl(userId));

      http.Response response = await HttpRequest.get(
        Uri.parse(
          Api.getUserStatUrl(userId),
        ),
        headers: headers,
      );

      var responseData = jsonDecode(response.body);
      CustomLogger.trace("user stats decoded response : -> $responseData");
      //check status code
      if (response.statusCode == 200) {
        GameStats gameStats = GameStats.fromJson(responseData);
        onSuccess(gameStats);
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

  static Future<void> getUserSummaryStat({
    required int userId,
    required Function(int totalFreiend, int totalMatchPlayed) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
      };

      CustomLogger.trace(Api.getUserStatUrl(userId));

      http.Response response = await HttpRequest.get(
        Uri.parse(
          Api.getUserMatchSummary(userId),
        ),
        headers: headers,
      );

      var responseData = jsonDecode(response.body);
      CustomLogger.trace(
          "user summary stats decoded response : -> $responseData");
      //check status code
      if (response.statusCode == 200) {
        onSuccess(
            responseData["Total_friend"], responseData["Total_match_played"]);
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
