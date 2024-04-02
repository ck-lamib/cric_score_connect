import 'package:cric_score_connect/screens/friend/widgets/friend_tile.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';

class FriendTabbarView extends StatelessWidget {
  const FriendTabbarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: AppColors.backGroundColor,
        //   width: 1,
        // ),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 10,
              bottom: 20,
            ),
            child: const CustomTextField(
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.name,
              preIconPath: Icon(Icons.search_rounded),
              labelText: "Search by username",
              hint: "Search by username",
            ),
          ),
          const FriendTile(),
        ],
      ),
    );
  }
}
