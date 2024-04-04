import 'dart:io';

import 'package:cric_score_connect/screens/password/controller/change_password_controller.dart';
import 'package:cric_score_connect/screens/password/widgets/changepassword/change_password_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const String routeName = "/change-password-screen";
  ChangePasswordScreen({super.key});
  final c = Get.find<ChangePasswordController>();

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
            const ChangePasswordAppBar(),
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
                                  "Change Password ?",
                                  style: CustomTextStyles.f24W600(),
                                ),
                                SizeConfig.getSpace(height: 10),
                                Text(
                                  "Create a strong, unique password with uppercase, lowercase letters, numbers, and special characters. Avoid common words or personal info for security.",
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
                                  readOnly: true,
                                  validator: Validators.checkEmailField,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.emailAddress,
                                  textCapitalization: TextCapitalization.none,
                                ),
                                SizeConfig.getSpace(),
                                CustomElevatedButton(
                                  title: "Change password",
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
