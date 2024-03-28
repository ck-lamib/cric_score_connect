import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static success({String? title, String? message}) {
    Get.snackbar(title ?? "Successful", message ?? "The action was successful!",
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        backgroundColor: Colors.green,
        colorText: AppColors.backGroundColor);
  }

  static info({String? title, required String message}) {
    Get.snackbar(title ?? "Info", message,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        backgroundColor: Colors.orange,
        colorText: AppColors.primaryColor);
  }

  static error({String? title, String? message}) {
    Get.snackbar(
        title ?? "Error!", message ?? "Unknown error! Please try again later!",
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white);
  }
}
