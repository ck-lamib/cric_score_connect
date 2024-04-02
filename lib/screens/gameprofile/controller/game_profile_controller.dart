import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/models/gamestats/game_stats.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:get/get.dart';

class GameProfileController extends GetxController {
  final Rxn<GameStats> gameStats = Rxn();
  User? user;
  late CoreController cc;

  @override
  void onInit() {
    cc = Get.find<CoreController>();
    user = cc.currentUser.value;
    super.onInit();
  }

  getGameStats() async {
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
  }
}
