import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/screens/splash/views/splash_screen.dart';
import 'package:cric_score_connect/utils/routes/pages.dart';
import 'package:cric_score_connect/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CricScoreConnect extends StatelessWidget {
  const CricScoreConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(CoreController());
      }),
      debugShowCheckedModeBanner: false,
      getPages: pages,
      theme: basicTheme(),
      initialRoute: SplashScreen.routeName,
    );
  }
}
