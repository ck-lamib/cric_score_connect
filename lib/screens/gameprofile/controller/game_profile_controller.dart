import 'dart:io';

import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/utils/constants/datas.dart';
import 'package:cric_score_connect/utils/helpers/pick_image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class GameProfileController extends GetxController {
  late CoreController cc;
  final formKey = GlobalKey<FormState>();
  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

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

      playerTypeValue =
          cc.currentUser.value!.playerType?.toString().capitalizeFirst;
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
    if (formKey.currentState!.validate()) {}
    // {
    //   loading.show(message: "PLease wiat ..");
    //   await RegisterRepo.register(
    //     name: "${nameController.text} ${lastNameController.text}",
    //     email: emailController.text,
    //     password: passwordController.text,
    //     onSuccess: (user, token) async {
    //       loading.hide();
    //       final box = GetStorage();
    //       await box.write(
    //           StorageKeys.ACCESS_TOKEN, json.encode(token.toJson()));
    //       await box.write(StorageKeys.USER, json.encode(user.toJson()));
    //       Get.find<CoreController>().loadCurrentUser();
    //       Get.offAllNamed(DashScreen.routeName);
    //       CustomSnackBar.success(
    //           title: "Sign up", message: "User registered succesfully");
    //     },
    //     onError: (message) {
    //       loading.hide();
    //       CustomSnackBar.error(title: "Sign up", message: message);
    //     },
    //   );
    // }
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
          child: Text(e),
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
    File? pickedfile = await PickImageHelper().pickAndCropImage(source);
    if (pickedfile != null) {
      _pickedImage.value = pickedfile;
    }
  }
}
