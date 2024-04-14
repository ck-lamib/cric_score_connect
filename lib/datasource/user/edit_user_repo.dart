import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:cric_score_connect/utils/routes/api.dart';
import 'package:http/http.dart' as http;

class UserRepo {
  static Future<void> editProfile({
    required int id,
    required String name,
    required String dob,
    required String phone,
    required String playerType,
    required String address,
    required File? profilePhotoPath,
    required Function(User user, String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      CustomLogger.trace(Api);

      var request =
          http.MultipartRequest("POST", Uri.parse(Api.editProfileUrl(id)));
      CustomLogger.trace(Api.editProfileUrl(id));

      request.fields.addAll(
        {
          "name": name,
          "dob": dob,
          "phone": phone,
          "address": address,
          "player_type": playerType,
        },
      );

      if (profilePhotoPath != null) {
        var profilePhotoStream = http.ByteStream(profilePhotoPath.openRead());
        var length = await profilePhotoPath.length();
        // var basefile = await profilePhotoPath.readAsBytes();
        var multipartFile = http.MultipartFile(
          'profile_photo_path',
          profilePhotoStream,
          length,
          filename: profilePhotoPath.path.split('/').last,
        );
        request.files.add(multipartFile);
      }

      print(request.fields);
      print(request.files);
      var response = await request.send();
      print(response.statusCode);

      final res = await http.Response.fromStream(response);

      var responseData = jsonDecode(res.body);
      CustomLogger.trace("edited data decoded response : -> $responseData");
      //check status code
      if (response.statusCode == 200) {
        User user = User.fromJson(responseData["user"]);

        onSuccess(user, "Profile edited successfully.");
      } else {
        if (responseData.toString().contains("error")) {
          onError(responseData["error"].toString());
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
