import 'dart:convert';

import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/auth/login_repo.dart';
import 'package:cric_score_connect/screens/dashboard/views/dashboard_screen.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/request_loader.dart';
import 'package:cric_score_connect/utils/helpers/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool passwordObscure = true.obs;

  void onEyeCLick() {
    passwordObscure.value = !passwordObscure.value;
  }

  void onSubmit() async {
    RequestLoader requestLoader = RequestLoader();
    if (formKey.currentState!.validate()) {
      requestLoader.show();
      await LoginRepo.login(
        email: emailController.text.toLowerCase(),
        password: passwordController.text,
        onSuccess: (user, token) async {
          requestLoader.hide();
          final box = GetStorage();
          await box.write(StorageKeys.ACCESS_TOKEN, jsonEncode(token.toJson()));
          await box.write(StorageKeys.USER, jsonEncode(user.toJson()));
          Get.find<CoreController>().loadCurrentUser();
          Get.offAllNamed(DashboardScreen.routeName);
          CustomSnackBar.success(title: "Login", message: "Login Successfull");
        },
        onError: (message) {
          requestLoader.hide();
          CustomSnackBar.error(title: "Login", message: message);
        },
      );
    }
  }
}
