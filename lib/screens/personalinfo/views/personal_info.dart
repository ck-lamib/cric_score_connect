import 'dart:io';

import 'package:cric_score_connect/screens/personalinfo/controller/personal_info_controller.dart';
import 'package:cric_score_connect/screens/personalinfo/widgets/personal_info_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/extensions.dart';
import 'package:cric_score_connect/utils/routes/image_path.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_date_picker.dart';
import 'package:cric_score_connect/widgets/custom/custom_dropdown_textfield.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfoScreen extends StatelessWidget {
  static const String routeName = "/personal-information";
  PersonalInfoScreen({super.key});

  final PersonalInfoController c = Get.find<PersonalInfoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(
          color: AppColors.backGroundColor,
        ),
      ),
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
                              child: Obx(() => c.pickedFile != null
                                  ? CircleAvatar(
                                      backgroundColor: AppColors.primaryColor,
                                      backgroundImage: FileImage(c.pickedFile!),
                                      radius: 55,
                                    )
                                  : c.userAvatar != null
                                      ? const CircleAvatar(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          backgroundImage: NetworkImage(
                                              "https://bimalkhatri.com.np/img/hell.png"),
                                          radius: 55,
                                        )
                                      : const CircleAvatar(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          backgroundImage: AssetImage(
                                            ImagePath.defaultAvatar,
                                          ),
                                          radius: 55,
                                        )),
                            ),
                            Obx(() => !c.isEditTap
                                ? const SizedBox.shrink()
                                : Positioned(
                                    bottom: 5,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    "Choose an image source",
                                                    style: CustomTextStyles
                                                        .f18W600(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text("Camera"),
                                                trailing: const Icon(
                                                    Icons.chevron_right),
                                                leading: const Icon(
                                                    Icons.camera_alt_outlined),
                                                onTap: () async {
                                                  await c.onPickImageTap(
                                                      ImageSource.camera);
                                                  if (context.mounted) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                              ListTile(
                                                title: const Text("Gallery"),
                                                leading: const Icon(
                                                    Icons.image_outlined),
                                                trailing: const Icon(
                                                    Icons.chevron_right),
                                                onTap: () async {
                                                  await c.onPickImageTap(
                                                      ImageSource.gallery);
                                                  if (context.mounted) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                              const ListTile(
                                                visualDensity:
                                                    VisualDensity.compact,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
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
                                    ),
                                  ))
                          ],
                        ),
                        SizeConfig.getSpace(),
                        Obx(
                          () => CustomTextField(
                            controller: c.fullNameController,
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
                          controller: c.userNameController,
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
                                    "You cannot edit player name. Please ask your app admin.");
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
                                    "You cannot edit email. Please ask your app admin.");
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
                            suffixIconPath: const Icon(
                              Icons.calendar_month_outlined,
                              color: AppColors.hintTextColor,
                            ),
                            validator: Validators.checkFieldEmpty,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.datetime,
                            readOnly: true,
                            style: c.isEditTap
                                ? CustomTextStyles.f16W400(
                                    color: AppColors.backGroundColor)
                                : CustomTextStyles.f16W400(
                                    color: AppColors.hintTextColor),
                            onTap: !c.isEditTap
                                ? () {
                                    if (!c.isEditTap) {
                                      CustomSnackBar.info(
                                          message:
                                              "Please tap edit to edit date of birth");
                                      FocusScope.of(context).requestFocus(
                                        FocusNode(),
                                      );
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
                            hint: "98******36",
                            maxCharacters: 10,
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
                        Obx(
                          () => CustomTextField(
                            controller: c.addressController,
                            labelText: "Address",
                            hint: "Pokhara",
                            preIconPath: const Icon(
                              Icons.home_outlined,
                              color: AppColors.hintTextColor,
                            ),
                            onTap: () {
                              if (!c.isEditTap) {
                                CustomSnackBar.info(
                                    message: "Please tap edit to edit address");
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            },
                            readOnly: !c.isEditTap,
                            validator: Validators.checkFieldEmpty,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.streetAddress,
                          ),
                        ),
                        SizeConfig.getSpace(),
                        Obx(
                          () => !c.isEditTap
                              ? GestureDetector(
                                  onTap: () {
                                    CustomSnackBar.info(
                                      message:
                                          "Please tap edit to edit player type",
                                    );
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                  child: AbsorbPointer(
                                    absorbing: true,
                                    child: CustomDropdownTextField(
                                      hint: "Player Type",
                                      itemValue: c.playerTypeValue,
                                      onValueChange: c.onPlayerTypeValueChange,
                                      dropDownItemLists: c.playerTypeItemList,
                                    ),
                                  ),
                                )
                              : CustomDropdownTextField(
                                  hint: "Player Type",
                                  itemValue: c.playerTypeValue,
                                  onValueChange: c.onPlayerTypeValueChange,
                                  dropDownItemLists: c.playerTypeItemList,
                                ),
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
