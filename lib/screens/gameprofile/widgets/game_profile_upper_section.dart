import 'package:cric_score_connect/screens/gameprofile/widgets/game_profile_user_detail.dart';
import 'package:cric_score_connect/screens/profile/widgets/profile_friend_stat.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class GameProfileUpperSection extends StatelessWidget {
  const GameProfileUpperSection({
    super.key,
    this.tab,
  });
  final Widget? tab;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          bottom: 35,
          child: Container(
            color: AppColors.backGroundColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              GameProfileUserDetailCard(),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.backGroundColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    tab ?? SizedBox.shrink(),
                  ],

                  // [
                  //   Container(
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: 24,
                  //       vertical: 12,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: AppColors.primaryColor,
                  //       shape: BoxShape.rectangle,
                  //       borderRadius: BorderRadius.circular(8),
                  //       border: Border.all(
                  //         color: AppColors.backGroundColor,
                  //         width: 1.5,
                  //       ),
                  //     ),
                  //     child: Text(
                  //       "Team Vs Team",
                  //     ),
                  //   ),
                  //   SizedBox(
                  //     width: 5,
                  //   ),
                  //   Container(
                  //     child: Text("Team Vs Team"),
                  //   ),
                  // ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
