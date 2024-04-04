import 'dart:io';

import 'package:cric_score_connect/screens/password/controller/forget_password_controller.dart';
import 'package:cric_score_connect/screens/password/widgets/forgetpassword/forget_password_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName = "/forget-password-screen";
  ForgetPasswordScreen({super.key});
  final c = Get.find<ForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(
          color: AppColors.backGroundColor,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const ForgetPasswordAppBar(),
            Container(
              margin: EdgeInsets.only(
                top: height * 0.41,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverList.list(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.backGroundColor,
                            width: 1.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          child: Form(
                            key: c.formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Forget Password ?",
                                  style: CustomTextStyles.f24W600(),
                                ),
                                SizeConfig.getSpace(height: 10),
                                Text(
                                  "If you've forgotten your password, don't worry! Please enter your email address below and we'll send you instructions on how to reset it.",
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyles.f16W400(
                                    color: AppColors.hintTextColor,
                                  ),
                                ),
                                SizeConfig.getSpace(),
                                CustomTextField(
                                  controller: c.emailController,
                                  labelText: "Email",
                                  hint: "bibek@gmail.com",
                                  preIconPath: const Icon(
                                    Icons.email_outlined,
                                    color: AppColors.hintTextColor,
                                  ),
                                  validator: Validators.checkEmailField,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.emailAddress,
                                  textCapitalization: TextCapitalization.none,
                                ),
                                SizeConfig.getSpace(),
                                CustomElevatedButton(
                                  title: "Forget password",
                                  onTap: c.onSubmit,
                                ),
                                SizeConfig.getSpace(),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
