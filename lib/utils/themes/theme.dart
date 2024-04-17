import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData basicTheme() {
  return ThemeData.light().copyWith(
    primaryColor: AppColors.primaryColor,
    // scaffoldBackgroundColor: AppColors.backGroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.backGroundColor,
      secondary: AppColors.primaryColor,
      background: AppColors.backGroundColor,
      onBackground: AppColors.onBackGroundColor,
      error: AppColors.errorColor,
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.backGroundColor, // status bar color
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.backGroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.grey,
      indicatorColor: AppColors.backGroundColor,
      elevation: 0,
      iconTheme: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(
              color: AppColors.primaryColor,
            );
          }
          return null;
        },
      ),
    ),
  );
}
