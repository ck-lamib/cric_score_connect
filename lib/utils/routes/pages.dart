import 'package:cric_score_connect/screens/dashboard/controller/dashboard_controller.dart';
import 'package:cric_score_connect/screens/dashboard/views/dashboard_screen.dart';
import 'package:cric_score_connect/screens/friend/controller/friend_screen_controller.dart';
import 'package:cric_score_connect/screens/friend/views/friend_screen.dart';
import 'package:cric_score_connect/screens/gameprofile/controller/game_profile_controller.dart';
import 'package:cric_score_connect/screens/gameprofile/views/game_profile.dart';
import 'package:cric_score_connect/screens/home/controller/home_controller.dart';
import 'package:cric_score_connect/screens/login/controller/login_controller.dart';
import 'package:cric_score_connect/screens/login/views/login_screen.dart';
import 'package:cric_score_connect/screens/password/controller/change_password_controller.dart';
import 'package:cric_score_connect/screens/password/controller/forget_password_controller.dart';
import 'package:cric_score_connect/screens/password/views/change_passowrd_screen.dart';
import 'package:cric_score_connect/screens/password/views/forget_passowrd_screen.dart';
import 'package:cric_score_connect/screens/personalinfo/controller/personal_info_controller.dart';
import 'package:cric_score_connect/screens/personalinfo/views/personal_info.dart';
import 'package:cric_score_connect/screens/profile/controller/profile_controller.dart';
import 'package:cric_score_connect/screens/signup/controller/signup_controller.dart';
import 'package:cric_score_connect/screens/signup/views/signup_screen.dart';
import 'package:cric_score_connect/screens/splash/controller/splash_controller.dart';
import 'package:cric_score_connect/screens/splash/views/splash_screen.dart';
import 'package:get/get.dart';

var pages = [
  GetPage(
    name: SplashScreen.routeName,
    page: () => SplashScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => SplashController());
      },
    ),
  ),
  GetPage(
    name: LoginScreen.routeName,
    page: () => LoginScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => LoginController());
      },
    ),
  ),
  GetPage(
    name: SignupScreen.routeName,
    page: () => SignupScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => SignupController());
      },
    ),
  ),
  GetPage(
    name: ForgetPasswordScreen.routeName,
    page: () => ForgetPasswordScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => ForgetPasswordController());
      },
    ),
  ),
  GetPage(
    name: ChangePasswordScreen.routeName,
    page: () => ChangePasswordScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => ChangePasswordController());
      },
    ),
  ),
  GetPage(
    name: DashboardScreen.routeName,
    page: () => DashboardScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => DashboardController());
        Get.lazyPut(() => HomeController());
        Get.lazyPut(() => ProfileController());
        Get.lazyPut(() => FriendScreenController());
      },
    ),
  ),
  GetPage(
    name: PersonalInfoScreen.routeName,
    page: () => PersonalInfoScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => PersonalInfoController());
      },
    ),
  ),
  GetPage(
    name: GameProfileScreen.routeName,
    page: () => GameProfileScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => GameProfileController());
      },
    ),
  ),
  GetPage(
    name: FriendScreen.routeName,
    page: () => FriendScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => FriendScreenController());
      },
    ),
  ),
];
