import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/screens/dashboard/views/dashboard_screen.dart';
import 'package:cric_score_connect/screens/login/views/login_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final cc = Get.find<CoreController>();

  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (cc.isUserLoggedIn()) {
          Get.offAndToNamed(DashboardScreen.routeName);
        } else {
          Get.offAllNamed(LoginScreen.routeName);
        }
      },
    );
    super.onInit();
  }
}
