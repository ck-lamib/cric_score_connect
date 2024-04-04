import 'dart:io';

import 'package:cric_score_connect/screens/login/views/login_screen.dart';
import 'package:cric_score_connect/screens/signup/controller/signup_controller.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/helpers/extensions.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_date_picker.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_passwordfield.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = "/signup-screen";
  SignupScreen({super.key});
  final SignupController c = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 0),
        child: Container(
          color: AppColors.backGroundColor,
        ),
      ),
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
                      "Sign up",
                      style: CustomTextStyles.f32W600(),
                    ),
                    Text(
                      "Create your account to get started 😉",
                      style: CustomTextStyles.f18W600().copyWith(
                        color: AppColors.hintTextColor,
                      ),
                    ),
                    SizeConfig.getSpace(height: 50),
                    CustomTextField(
                      controller: c.fullNameController,
                      labelText: "Full name",
                      hint: "Harry Gonzalage",
                      preIconPath: const Icon(
                        Icons.person_2_outlined,
                        color: AppColors.hintTextColor,
                      ),
                      validator: Validators.checkFieldEmpty,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                    ),
                    SizeConfig.getSpace(),
                    CustomTextField(
                      controller: c.userNameController,
                      labelText: "User name",
                      hint: "Player123",
                      preIconPath: const Icon(
                        Icons.person_3_outlined,
                        color: AppColors.hintTextColor,
                      ),
                      validator: Validators.checkFieldEmpty,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                      textCapitalization: TextCapitalization.none,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                          RegExp(r'\s'),
                        ),
                      ],
                    ),
                    SizeConfig.getSpace(),
                    CustomTextField(
                      controller: c.emailController,
                      labelText: "Email",
                      hint: "harry@gmail.com",
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
                    CustomTextField(
                      controller: c.birthdayController,
                      labelText: "Birthday",
                      hint: "2002-07-07",
                      suffixIconPath: const Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.hintTextColor,
                      ),
                      validator: Validators.checkFieldEmpty,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.datetime,
                      readOnly: true,
                      onTap: () async {
                        DateTime? result = await CustomDatePicker().pickDate(
                          context: context,
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );
                        if (result != null) {
                          c.birthdayController.text =
                              result.parseDateTimeToString();
                        }
                      },
                    ),
                    SizeConfig.getSpace(),
                    CustomTextField(
                      controller: c.phoneController,
                      labelText: "Phone",
                      hint: "98******36",
                      maxCharacters: 10,
                      preIconPath: const Icon(
                        Icons.phone,
                        color: AppColors.hintTextColor,
                      ),
                      validator: Validators.checkPhoneField,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.phone,
                    ),
                    SizeConfig.getSpace(),
                    CustomTextField(
                      controller: c.addressController,
                      labelText: "Address",
                      hint: "Pokhara",
                      preIconPath: const Icon(
                        Icons.home_outlined,
                        color: AppColors.hintTextColor,
                      ),
                      validator: Validators.checkFieldEmpty,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.streetAddress,
                    ),
                    SizeConfig.getSpace(),
                    Obx(
                      () => CustomPasswordField(
                        controller: c.passwordController,
                        labelText: "Password",
                        autofillHints: const [AutofillHints.password],
                        eye: c.passwordObscure.value,
                        onEyeClick: c.onEyeCLick,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizeConfig.getSpace(),
                    Obx(
                      () => CustomPasswordField(
                        labelText: "Verify Password",
                        eye: c.verifyPasswordObscure.value,
                        onEyeClick: c.onVerifyEyeCLick,
                        controller: c.verifyPasswordController,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          return Validators.checkConfirmPassword(
                              c.passwordController.text, value);
                        },
                      ),
                    ),
                    SizeConfig.getSpace(),
                    CustomElevatedButton(
                      title: "Sign up",
                      onTap: c.onSubmit,
                    ),
                    SizeConfig.getSpace(),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: CustomTextStyles.f16W400(
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offNamed(LoginScreen.routeName);
                          },
                          child: Text(
                            "Login Now",
                            style: CustomTextStyles.f16W400(
                              color: AppColors.backGroundColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizeConfig.getSpace(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              "By signing up or signing in, you agree to our  ",
                          style: CustomTextStyles.f14W400(
                            color: AppColors.hintTextColor,
                          ),
                          children: [
                            TextSpan(
                                text: "Terms of Use",
                                style: CustomTextStyles.f14W400(
                                  color: AppColors.backGroundColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {}),
                            const TextSpan(
                              text: "  and  ",
                            ),
                            TextSpan(
                                text: "Privacy Policy",
                                style: CustomTextStyles.f14W400(
                                  color: AppColors.backGroundColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {}),
                          ],
                        ),
                      ),
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
