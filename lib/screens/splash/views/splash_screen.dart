import 'package:cric_score_connect/screens/splash/controller/splash_controller.dart';
import 'package:cric_score_connect/utils/routes/image_path.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "/splash-screen";
  final c = Get.find<SplashController>();
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(
            //   "CricScoreConnect",
            //   style: CustomTextStyles.f32W600(),
            // ),
            Image.asset(
              ImagePath.splashLogo,
              height: Get.height / 3,
              fit: BoxFit.contain,
            )
          ],
        ),
      ),
    );
  }
}
