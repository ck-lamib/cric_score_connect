import 'dart:convert';

import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/auth/login_repo.dart';
import 'package:cric_score_connect/screens/dashboard/views/dashboard_screen.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final loading = SimpleFontelicoProgressDialog(
    context: Get.context!,
    barrierDimisable: false,
  );

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool passwordObscure = true.obs;

  void onEyeCLick() {
    passwordObscure.value = !passwordObscure.value;
  }

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      loading.show(
        message: "Please wait ...",
        type: SimpleFontelicoProgressDialogType.multiHurricane,
        horizontal: true,
        width: 200.0,
        height: 100.0,
        hideText: false,
        indicatorColor: AppColors.backGroundColor,
        elevation: 10,
      );

      await LoginRepo.login(
        email: emailController.text.toLowerCase(),
        password: passwordController.text,
        onSuccess: (user, token) async {
          loading.hide();
          final box = GetStorage();
          await box.write(StorageKeys.ACCESS_TOKEN, jsonEncode(token.toJson()));
          await box.write(StorageKeys.USER, jsonEncode(user.toJson()));
          Get.find<CoreController>().loadCurrentUser();
          Get.offAllNamed(DashboardScreen.routeName);
          CustomSnackBar.success(title: "Login", message: "Login Successfull");
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Login", message: message);
        },
      );
    }
  }
}
