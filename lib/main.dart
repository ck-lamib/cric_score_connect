import 'package:cric_score_connect/app.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.backGroundColor, // status bar color
    statusBarIconBrightness: Brightness.light,
  ));
  await GetStorage.init();
  runApp(
    const CricScoreConnect(),
  );
}
