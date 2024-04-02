import 'package:cric_score_connect/screens/login/controller/login_controller.dart';
import 'package:cric_score_connect/screens/password/views/forget_passowrd_screen.dart';
import 'package:cric_score_connect/screens/signup/views/signup_screen.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_passwordfield.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login-screen";
  LoginScreen({super.key});
  final c = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: c.formKey,
              child: AutofillGroup(
                onDisposeAction: AutofillContextAction.commit,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizeConfig.getSpace(),
                    Text(
                      "Login",
                      style: CustomTextStyles.f32W600(),
                    ),
                    Text(
                      "Hi! Welcome 👋",
                      style: CustomTextStyles.f18W600().copyWith(
                        color: AppColors.hintTextColor,
                      ),
                    ),
                    SizeConfig.getSpace(height: 100),
                    CustomTextField(
                      controller: c.emailController,
                      labelText: "Email",
                      hint: "bibek@gmail.com",
                      preIconPath: const Icon(
                        Icons.email_outlined,
                        color: AppColors.hintTextColor,
                      ),
                      autofillHints: const [AutofillHints.email],
                      validator: Validators.checkEmailField,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                    ),
                    SizeConfig.getSpace(),
                    Obx(
                      () => CustomPasswordField(
                        labelText: "Password",
                        eye: c.passwordObscure.value,
                        onEyeClick: c.onEyeCLick,
                        controller: c.passwordController,
                        autofillHints: const [
                          AutofillHints.password,
                        ],
                        textInputAction: TextInputAction.done,
                        validator: Validators.checkPasswordField,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomElevatedButton(
                      title: "Login",
                      onTap: c.onSubmit,
                    ),
                    SizeConfig.getSpace(),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(ForgetPasswordScreen.routeName);
                        },
                        child: Text(
                          "Forget Password?",
                          style: CustomTextStyles.f16W400(
                              color: AppColors.backGroundColor),
                        ),
                      ),
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: CustomTextStyles.f16W400(
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offNamed(SignupScreen.routeName);
                          },
                          child: Text(
                            "Sign Up Now",
                            style: CustomTextStyles.f16W400(
                              color: AppColors.backGroundColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
