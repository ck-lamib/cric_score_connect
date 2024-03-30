import 'package:cric_score_connect/screens/personalinfo/controller/personal_info_controller.dart';
import 'package:cric_score_connect/screens/personalinfo/widgets/personal_info_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/extensions.dart';
import 'package:cric_score_connect/widgets/custom/custom_date_picker.dart';
import 'package:cric_score_connect/widgets/custom/custom_dropdown_textfield.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoScreen extends StatelessWidget {
  static const String routeName = "/personal-information";
  PersonalInfoScreen({super.key});

  final PersonalInfoController c = Get.find<PersonalInfoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            PersonalInfoAppBar(),
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: c.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizeConfig.getSpace(),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.backGroundColor,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                radius: 55,
                              ),
                            ),
                            Obx(() => !c.isEditTap
                                ? const SizedBox.shrink()
                                : Positioned(
                                    bottom: 5,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        shape: BoxShape.circle,
                                        // borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: AppColors.backGroundColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.camera,
                                        color: AppColors.backGroundColor,
                                      ),
                                    ),
                                  ))
                          ],
                        ),
                        SizeConfig.getSpace(),
                        Obx(
                          () => CustomTextField(
                            controller: c.userNameController,
                            labelText: "Full name",
                            hint: "Harry Gonzalage",
                            preIconPath: const Icon(
                              Icons.person_2_outlined,
                              color: AppColors.hintTextColor,
                            ),
                            onTap: () {
                              if (!c.isEditTap) {
                                CustomSnackBar.info(
                                    message: "Please tap edit to edit name");
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            },
                            readOnly: !c.isEditTap,
                            validator: Validators.checkFieldEmpty,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                          ),
                        ),
                        SizeConfig.getSpace(),
                        CustomTextField(
                          // controller: c.userNameController,
                          labelText: "User name",
                          hint: "Player123",
                          preIconPath: const Icon(
                            Icons.person_3_outlined,
                            color: AppColors.hintTextColor,
                          ),
                          readOnly: true,
                          onTap: () {
                            CustomSnackBar.info(
                                message:
                                    "You cannot edit player name. Please ask your app admins.");
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          validator: Validators.checkFieldEmpty,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                        ),
                        SizeConfig.getSpace(),
                        CustomTextField(
                          controller: c.emailController,
                          labelText: "Email",
                          hint: "harry@gmail.com",
                          readOnly: true,
                          preIconPath: const Icon(
                            Icons.email_outlined,
                            color: AppColors.hintTextColor,
                          ),
                          onTap: () {
                            CustomSnackBar.info(
                                message:
                                    "You cannot edit email. Please ask your app admins.");
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          validator: Validators.checkEmailField,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizeConfig.getSpace(),
                        Obx(
                          () => CustomTextField(
                            controller: c.birthdayController,
                            labelText: "Birthday",
                            hint: "2002-07-07",
                            preIconPath: const Icon(
                              Icons.calendar_month_outlined,
                              color: AppColors.hintTextColor,
                            ),
                            validator: Validators.checkEmailField,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.datetime,
                            readOnly: true,
                            onTap: !c.isEditTap
                                ? () {
                                    if (!c.isEditTap) {
                                      CustomSnackBar.info(
                                          message:
                                              "Please tap edit to edit date of birth");
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    }
                                  }
                                : () async {
                                    DateTime? result =
                                        await CustomDatePicker().pickDate(
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
                        ),
                        SizeConfig.getSpace(),
                        Obx(
                          () => CustomTextField(
                            controller: c.phoneController,
                            labelText: "Phone",
                            hint: "9867743236",
                            preIconPath: const Icon(
                              Icons.phone,
                              color: AppColors.hintTextColor,
                            ),
                            onTap: () {
                              if (!c.isEditTap) {
                                CustomSnackBar.info(
                                    message:
                                        "Please tap edit to edit phone number");
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            },
                            readOnly: !c.isEditTap,
                            validator: Validators.checkPhoneField,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.phone,
                          ),
                        ),
                        SizeConfig.getSpace(),
                        CustomDropdownTextField(
                          hint: "Player Type",
                          itemValue: c.playerTypeValue,
                          onValueChange: c.onPlayerTypeValueChange,
                          dropDownItemLists: c.playerTypeItemList,
                        ),
                        SizeConfig.getSpace(),
                        Obx(
                          () => !c.isEditTap
                              ? const SizedBox.shrink()
                              : CustomElevatedButton(
                                  title: "Save",
                                  onTap: c.onSubmit,
                                ),
                        ),
                        SizeConfig.getSpace(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
