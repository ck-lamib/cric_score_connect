import 'package:cric_score_connect/screens/friend/controller/friend_screen_controller.dart';
import 'package:cric_score_connect/screens/friend/widgets/accepted_friend_tile.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FriendTabbarView extends StatelessWidget {
  FriendTabbarView({
    super.key,
  });
  final FriendScreenController c = Get.find<FriendScreenController>();

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
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          await c.getFriendRequest();
        },
        child: Column(
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
            Expanded(
              child: Obx(
                () => c.isPendingFriendLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                        itemCount: c.friendRequestUser.length,
                        itemBuilder: (context, index) {
                          return AcceptedFriendTile(
                            user: c.friendRequestUser[index],
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
