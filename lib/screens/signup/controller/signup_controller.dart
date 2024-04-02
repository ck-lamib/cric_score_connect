import 'dart:convert';

import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/auth/register_repo.dart';
import 'package:cric_score_connect/screens/dashboard/views/dashboard_screen.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/request_loader.dart';
import 'package:cric_score_connect/utils/helpers/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final birthdayController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final verifyPasswordController = TextEditingController();

  RxBool passwordObscure = true.obs;
  RxBool verifyPasswordObscure = true.obs;

  void onEyeCLick() {
    passwordObscure.value = !passwordObscure.value;
  }

  void onVerifyEyeCLick() {
    verifyPasswordObscure.value = !verifyPasswordObscure.value;
  }

  onSubmit() async {
    RequestLoader requestLoader = RequestLoader();
    if (formKey.currentState!.validate()) {
      requestLoader.show();
      await RegisterRepo.register(
        fullName: fullNameController.text,
        userName: userNameController.text,
        email: emailController.text,
        dob: birthdayController.text,
        phone: phoneController.text,
        address: addressController.text,
        password: passwordController.text,
        onSuccess: (user, token) async {
          requestLoader.hide();
          final box = GetStorage();
          await box.write(StorageKeys.ACCESS_TOKEN, jsonEncode(token.toJson()));
          await box.write(StorageKeys.USER, jsonEncode(user.toJson()));
          Get.find<CoreController>().loadCurrentUser();
          Get.offAllNamed(DashboardScreen.routeName);
          CustomSnackBar.success(
              title: "Sign up", message: "User Registered Successfull");
          TextInput.finishAutofillContext();
        },
        onError: (message) {
          requestLoader.hide();
          CustomSnackBar.error(title: "Sign up", message: message);
        },
      );
    }
  }
}
