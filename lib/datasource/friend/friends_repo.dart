import 'dart:convert';
import 'dart:developer';

import 'package:cric_score_connect/models/friend_request_user.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:cric_score_connect/utils/helpers/http_request.dart';
import 'package:cric_score_connect/utils/routes/api.dart';
import 'package:http/http.dart' as http;

class FriendRepo {
  static Future<void> friendRequest({
    required int receiverId,
    required int senderId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
      };

      CustomLogger.trace(Api.searchUrl);
      var body = {
        "sender_id": senderId.toString(),
        "receiver_id": receiverId.toString()
      };
      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.friendRequestUrl,
        ),
        headers: headers,
        body: body,
      );

      var responseData = jsonDecode(response.body);
      CustomLogger.trace("friend request decoded response : -> $responseData");
      //check status code
      if (response.statusCode == 200) {
        onSuccess("Friend request successfully sent.");
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

  static Future<void> getAllFriendRequestUser({
    required int receiverId,
    required Function(List<FriendRequestUser> friendRequestUser) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
      };

      CustomLogger.trace(Api.searchUrl);
      var body = {
        "user_id": receiverId.toString(),
      };
      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.pendingRequestUrl,
        ),
        headers: headers,
        body: body,
      );

      var responseData = jsonDecode(response.body);
      CustomLogger.trace("friend request decoded response : -> $responseData");
      //check status code
      if (response.statusCode == 200) {
        List<FriendRequestUser> userList =
            friendRequestUserFromJson(responseData["friend_requests"]);
        onSuccess(userList);
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

  static Future<void> rejectRequest({
    required int requestId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
      };

      CustomLogger.trace(Api.rejectFriendRequestUrl(requestId));

      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.rejectFriendRequestUrl(requestId),
        ),
        headers: headers,
      );

      var responseData = jsonDecode(response.body);
      CustomLogger.trace("friend reject decoded response : -> $responseData");
      //check status code
      if (response.statusCode == 200) {
        onSuccess(responseData["message"]);
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

  static Future<void> confirmRequest({
    required int requestId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
      };

      CustomLogger.trace(Api.confirmFriendRequestUrl(requestId));

      http.Response response = await HttpRequest.post(
        Uri.parse(
          Api.confirmFriendRequestUrl(requestId),
        ),
        headers: headers,
      );

      var responseData = jsonDecode(response.body);
      CustomLogger.trace("friend confirm decoded response : -> $responseData");
      //check status code
      if (response.statusCode == 200) {
        onSuccess(responseData["message"]);
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

  static Future<void> getAllFriend({
    required int userId,
    required Function(List<User>) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
      };

      CustomLogger.trace(Api.getAllFriendUrl(userId));

      http.Response response = await HttpRequest.get(
        Uri.parse(
          Api.getAllFriendUrl(userId),
        ),
        headers: headers,
      );

      var responseData = jsonDecode(response.body);
      CustomLogger.trace("get all friends decoded response : -> $responseData");
      //check status code
      if (response.statusCode == 200) {
        CustomLogger.trace(response.body);
        List<User> users = userFromJson(responseData["friends"]);
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
