import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/screens/splash/views/splash_screen.dart';
import 'package:cric_score_connect/utils/routes/pages.dart';
import 'package:cric_score_connect/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

GlobalKey<ScaffoldMessengerState> scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class CricScoreConnect extends StatelessWidget {
  const CricScoreConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_32bf9a5ce5d741d3b90e248bc33d4e15",
        builder: (context, navKey) {
          return GetMaterialApp(
            title: "Cric Score Connect",
            navigatorKey: navKey,
            scaffoldMessengerKey: scaffoldKey,
            initialBinding: BindingsBuilder(() {
              Get.put(CoreController());
            }),
            debugShowCheckedModeBanner: false,
            getPages: pages,
            theme: basicTheme(),
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            initialRoute: SplashScreen.routeName,
          );
        });
  }
}
