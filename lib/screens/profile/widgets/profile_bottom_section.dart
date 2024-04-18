import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/models/gamestats/game_stats.dart';
import 'package:cric_score_connect/screens/gameprofile/controller/game_profile_controller.dart';
import 'package:cric_score_connect/screens/gameprofile/views/game_profile.dart';
import 'package:cric_score_connect/screens/paidHistory/views/paid_history_screen.dart';
import 'package:cric_score_connect/screens/login/views/login_screen.dart';
import 'package:cric_score_connect/screens/password/views/change_passowrd_screen.dart';
import 'package:cric_score_connect/screens/personalinfo/views/personal_info.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBottomSection extends StatelessWidget {
  ProfileBottomSection({
    super.key,
  });
  final CoreController cc = Get.find<CoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      padding: const EdgeInsets.only(
        left: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.backGroundColor,
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileListTile(
            leadingWidget: const Icon(
              Icons.person_outline_rounded,
              color: AppColors.backGroundColor,
            ),
            title: 'Personal Information',
            onTap: () =>
                Navigator.of(context).pushNamed(PersonalInfoScreen.routeName),
          ),
          ProfileListTile(
            leadingWidget: const Icon(
              Icons.gamepad_outlined,
              color: AppColors.backGroundColor,
            ),
            title: 'Game Information',
            onTap: () async {
              GameStats? gameStats = await GetGameProfileStat.getGameStats(
                  userId: cc.currentUser.value!.id!);
              if (gameStats != null && context.mounted) {
                Navigator.of(context).pushNamed(GameProfileScreen.routeName,
                    arguments: GameProfileArgument(
                      gameStats: gameStats,
                      showAddFriend: false,
                    ));
              }
            },
          ),
          ProfileListTile(
            leadingWidget: const Icon(
              Icons.password_rounded,
              color: AppColors.backGroundColor,
            ),
            title: 'Change password',
            onTap: () =>
                Navigator.of(context).pushNamed(ChangePasswordScreen.routeName),
          ),
          ProfileListTile(
            leadingWidget: const Icon(
              Icons.history_rounded,
              color: AppColors.backGroundColor,
            ),
            title: 'History',
            onTap: () =>
                Navigator.of(context).pushNamed(PaidHistoryScreen.routeName),
          ),
          ProfileListTile(
            leadingWidget: const Icon(
              Icons.logout_rounded,
              color: AppColors.errorColor,
            ),
            title: 'Logout',
            titleColor: AppColors.errorColor,
            trailing: const SizedBox.shrink(),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: const Text(
                      "Are you sure?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await cc.logOut().whenComplete(
                            () {
                              Get.offAllNamed(LoginScreen.routeName);
                              if (context.mounted) {
                                CustomSnackBar.success(
                                  title: "Logout Success",
                                  message: "You have successfully logout.",
                                );
                              }
                            },
                          );
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.title,
    this.titleColor,
    this.leadingWidget,
    this.trailing,
    this.onTap,
  });

  final String title;
  final Color? titleColor;
  final Widget? leadingWidget;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: leadingWidget,
      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w400,
          color: titleColor,
        ),
      ),
      trailing: trailing ??
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
            color: AppColors.hintTextColor,
          ),
    );
  }
}
