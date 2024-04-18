import 'dart:convert';
import 'dart:developer';

import 'package:cric_score_connect/models/gamestats/live_match_model.dart';
import 'package:cric_score_connect/models/gamestats/match_history_model.dart';
import 'package:cric_score_connect/models/gamestats/match_store.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:cric_score_connect/utils/helpers/http_request.dart';
import 'package:cric_score_connect/utils/routes/api.dart';
import 'package:http/http.dart' as http;

class GameDataSourceRepo {
  //

  static Future<void> uploadMatchDetail({
    required int userId,
    required String homeTeamName,
    required List<User> homeTeamPlayer,
    required String awayTeamName,
    required List<User> awayTeamPlayer,
    required String date,
    required String time,
    required String venue,
    required int noOfOver,
    required int playerPerTeam,
    required String tossWinner,
    required Function(MatchStore matchStore) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      var body = jsonEncode({
        "user_id": userId,
        "team1": {
          "name": homeTeamName,
          "type": "home",
          "users": homeTeamPlayer.map((user) => user.id).toList()
        },
        "team2": {
          "name": awayTeamName,
          "type": "away",
          "users": awayTeamPlayer.map((user) => user.id).toList()
        },
        "date": date,
        "time": time,
        "venue": venue,
        "overs": noOfOver,
        "players_per_team": playerPerTeam,
        "toss_winner": tossWinner == homeTeamName ? "team1" : "team2"
      });

      CustomLogger.trace(body);
      CustomLogger.trace(Api.storeMatchUrl);
      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.storeMatchUrl,
        ),
        headers: headers,
        body: body,
      );
      CustomLogger.trace(response);

      var responseData = jsonDecode(response.body);
      CustomLogger.trace("register decoded response : -> $responseData");
      //check status code
      if (response.statusCode >= 200 || response.statusCode < 300) {
        CustomLogger.trace(response.body);
        MatchStore matchKey = MatchStore.fromJson(responseData);
        onSuccess(matchKey);
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

  static Future<void> getLiveMatchDetail({
    required int userId,
    required String matchKey,
    required Function(LiveMatchStat liveMatchStat) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      var body = {
        "user_id": userId,
        "key": matchKey,
      };

      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.fetchLiveMatchUrl,
        ),
        headers: headers,
        body: jsonEncode(body),
      );
      CustomLogger.trace(response);

      var responseData = jsonDecode(response.body);
      CustomLogger.trace(
          "fetch live match decoded response : -> $responseData");
      //check status code
      if (response.statusCode >= 200 && response.statusCode < 300) {
        CustomLogger.trace(response.body);
        LiveMatchStat liveMatchStat = LiveMatchStat.fromJson(responseData);
        onSuccess(liveMatchStat);
      } else if (response.statusCode == 403) {
        onError(responseData["error"]);
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

  static Future<void> uploadGameData({
    required LiveMatchStat liveMatchStat,
    required Function(String matchCode) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      var body = liveMatchStat.toJson();
      CustomLogger.trace("api: => ${Api.updateGameDataUrl}");

      CustomLogger.trace(jsonEncode(body));
      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.updateGameDataUrl,
        ),
        headers: headers,
        body: jsonEncode(body),
      );
      CustomLogger.trace(response);

      var responseData = jsonDecode(response.body);
      CustomLogger.trace("upload game decoded response : -> $responseData");
      //check status code
      if (response.statusCode >= 200 && response.statusCode < 300) {
        CustomLogger.trace(response.body);
        String matchKey = "${responseData["key"]}";
        onSuccess(matchKey);
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

  static Future<void> saveTransaction({
    required String transactionId,
    required int userId,
    required String matchId,
    required Function(String matchCode) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      var body = {
        "transaction_id": transactionId,
        "user_id": userId,
        "key": matchId
      };

      CustomLogger.trace(jsonEncode(body));
      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.payementStoreUrl,
        ),
        headers: headers,
        body: jsonEncode(body),
      );
      CustomLogger.trace(response);

      var responseData = jsonDecode(response.body);
      CustomLogger.trace("upload payment decoded response : -> $responseData");
      //check status code
      if (response.statusCode >= 200 && response.statusCode < 300) {
        CustomLogger.trace(response.body);
        onSuccess("Payment success");
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

  static Future<void> getPaidMatchHistorys({
    required int userId,
    required Function(List<MatchHistoryModel> matchHistoryModelList) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      CustomLogger.trace(Api.getPaidMatchHistoryUrl);
      var body = {
        "user_id": userId,
      };
      CustomLogger.trace(body);

      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.getPaidMatchHistoryUrl,
        ),
        headers: headers,
        body: jsonEncode(body),
      );
      CustomLogger.trace(response);

      var responseData = jsonDecode(response.body);
      CustomLogger.trace(
          "paid match history decoded response : -> $responseData");
      //check status code
      if (response.statusCode >= 200 && response.statusCode < 300) {
        CustomLogger.trace(response.body);
        List<MatchHistoryModel> matchHistoryModelList =
            matchHistoryModelListFromJson(responseData);
        onSuccess(matchHistoryModelList);
      } else if (response.statusCode == 403) {
        onError(responseData["error"]);
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

  static Future<void> getUnPaidMatchHistorys({
    required int userId,
    required Function(List<MatchHistoryModel> matchHistoryModelList) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      CustomLogger.trace(Api.getUnPaidMatchHistoryUrl);
      var body = {
        "user_id": userId,
      };
      CustomLogger.trace(body);

      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.getUnPaidMatchHistoryUrl,
        ),
        headers: headers,
        body: jsonEncode(body),
      );
      CustomLogger.trace(response);

      var responseData = jsonDecode(response.body);
      CustomLogger.trace(
          "paid match history decoded response : -> $responseData");
      //check status code
      if (response.statusCode >= 200 && response.statusCode < 300) {
        CustomLogger.trace(response.body);
        List<MatchHistoryModel> matchHistoryModelList =
            matchHistoryModelListFromJson(responseData);
        onSuccess(matchHistoryModelList);
      } else if (response.statusCode == 403) {
        onError(responseData["error"]);
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

  static Future<void> getPaidMatchHistoryDetail({
    required String matchKey,
    required String matchId,
    required Function(LiveMatchStat matchStat) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      CustomLogger.trace(Api.getMatchHistoryDetail);
      var body = {
        "key": matchKey,
      };
      CustomLogger.trace(body);

      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.getMatchHistoryDetail,
        ),
        headers: headers,
        body: jsonEncode(body),
      );
      CustomLogger.trace(response);

      var responseData = jsonDecode(response.body);
      CustomLogger.trace(
          "paid match history's detail decoded response : -> $responseData");
      //check status code
      if (response.statusCode >= 200 && response.statusCode < 300) {
        CustomLogger.trace(response.body);
        LiveMatchStat matchHistoryModelList =
            LiveMatchStat.fromJson(responseData);
        onSuccess(matchHistoryModelList);
      } else if (response.statusCode == 403) {
        onError(responseData["error"]);
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
