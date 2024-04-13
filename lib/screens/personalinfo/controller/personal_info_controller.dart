import 'dart:convert';
import 'dart:io';

import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/user/edit_user_repo.dart';
import 'package:cric_score_connect/screens/profile/controller/profile_controller.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/datas.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/pick_image_helper.dart';
import 'package:cric_score_connect/utils/helpers/request_loader.dart';
import 'package:cric_score_connect/utils/helpers/storage_helper.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class PersonalInfoController extends GetxController {
  late CoreController cc;
  final formKey = GlobalKey<FormState>();

  late TextEditingController fullNameController;
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController birthdayController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  String? playerTypeValue;
  String? userAvatar;

  @override
  void onInit() {
    cc = Get.find<CoreController>();
    if (cc.currentUser.value != null) {
      fullNameController =
          TextEditingController(text: cc.currentUser.value!.name);
      userNameController =
          TextEditingController(text: cc.currentUser.value!.username);
      emailController =
          TextEditingController(text: cc.currentUser.value!.email);
      birthdayController =
          TextEditingController(text: cc.currentUser.value!.dob);
      phoneController =
          TextEditingController(text: cc.currentUser.value!.phone);
      addressController =
          TextEditingController(text: cc.currentUser.value!.address);

      playerTypeValue = cc.currentUser.value!.playerType?.toString();
      userAvatar = cc.currentUser.value!.profilePhotoPath;
    } else {
      fullNameController = TextEditingController();
      userNameController = TextEditingController();
      emailController = TextEditingController();
      birthdayController = TextEditingController();
      phoneController = TextEditingController();
      addressController = TextEditingController();
    }
    super.onInit();
  }

  RxBool passwordObscure = true.obs;

  void onEyeCLick() {
    passwordObscure.value = !passwordObscure.value;
  }

  onSubmit() async {
    RequestLoader requestLoader = RequestLoader();
    CoreController cc = Get.find<CoreController>();
    var userId = cc.currentUser.value!.id;

    if (formKey.currentState!.validate()) {}
    {
      requestLoader.show();
      await UserRepo.editProfile(
        id: userId!,
        name: fullNameController.text,
        phone: phoneController.text,
        playerType: playerTypeValue!,
        profilePhotoPath: pickedFile,
        address: addressController.text,
        dob: birthdayController.text,
        onSuccess: (user, message) async {
          requestLoader.hide();
          final box = GetStorage();
          await box.write(StorageKeys.USER, jsonEncode(user.toJson()));
          await Get.find<CoreController>().loadCurrentUser();
          Get.back();
          CustomSnackBar.success(
              title: "Edit profile",
              message: "User profile edited succesfully");
        },
        onError: (message) {
          requestLoader.hide();
          CustomSnackBar.error(title: "Edit profile", message: message);
        },
      );
    }
  }

  final RxBool _isEditTap = false.obs;
  bool get isEditTap => _isEditTap.value;
  onEditToggle() {
    _isEditTap.value = !_isEditTap.value;
  }

  //dropdown
  List<DropdownMenuItem<String>> playerTypeItemList = playerType
      .map(
        (e) => DropdownMenuItem(
          value: e,
          child: Text(
            e,
            style: CustomTextStyles.f16W400(color: AppColors.backGroundColor),
          ),
        ),
      )
      .toList();

  onPlayerTypeValueChange(value) {
    playerTypeValue = value;
  }

  //for picking image
  final Rxn<File> _pickedImage = Rxn<File>();
  File? get pickedFile => _pickedImage.value;

  onPickImageTap(ImageSource source) async {
    File? pickedfilee = await PickImageHelper().pickAndCropImage(source);
    if (pickedfilee != null) {
      _pickedImage.value = pickedfilee;
    }
  }
}
