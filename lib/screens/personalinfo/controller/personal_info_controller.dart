import 'package:cric_score_connect/utils/constants/datas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class PersonalInfoController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController verifyPasswordController;
  late TextEditingController birthdayController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void onInit() {
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    verifyPasswordController = TextEditingController();
    birthdayController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
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
  String? playerTypeValue;
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
}
