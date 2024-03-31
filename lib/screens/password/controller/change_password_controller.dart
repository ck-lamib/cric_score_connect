import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/auth/forget_password_repo.dart';
import 'package:cric_score_connect/screens/login/views/login_screen.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/request_loader.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late CoreController cc;

  late TextEditingController emailController;
  @override
  void onInit() {
    cc = Get.find<CoreController>();
    if (cc.currentUser.value != null) {
      emailController = TextEditingController(
        text: cc.currentUser.value?.email,
      );
    } else {
      emailController = TextEditingController();
    }

    super.onInit();
  }

  void onSubmit() async {
    RequestLoader requestLoader = RequestLoader();
    if (formKey.currentState!.validate()) {
      requestLoader.show();
      await ForgetPasswordRepo.forgetPassword(
        email: emailController.text.toLowerCase(),
        onSuccess: (message) async {
          requestLoader.hide();
          await cc.logOut();
          await showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Change password success!",
                  style: CustomTextStyles.f24W600(),
                ),
                content: RichText(
                  text: TextSpan(
                    text: "A instruction has been sent to your email",
                    style: CustomTextStyles.f18W400(
                      color: AppColors.hintTextColor,
                    ),
                    children: [
                      TextSpan(
                        text: " (${emailController.text}). ",
                        style: CustomTextStyles.f16W600(
                          color: AppColors.backGroundColor,
                        ),
                      ),
                      const TextSpan(
                        text:
                            "Please! follow the instruction to reset password.",
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Get.offAllNamed(LoginScreen.routeName);
                      CustomSnackBar.success(
                          title: "Forget password",
                          message: "Forget password Successfull");
                    },
                    child: Text(
                      "Okay",
                      style: CustomTextStyles.f16W600(
                        color: AppColors.backGroundColor,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        onError: (message) {
          requestLoader.hide();
          CustomSnackBar.error(title: "Forget password", message: message);
        },
      );
    }
  }
}
