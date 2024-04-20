import 'package:cached_network_image/cached_network_image.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/screens/game/controller/selectplayer/select_player_controller.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/routes/image_path.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPlayer extends StatelessWidget {
  static const String routeName = "/select-player-screen";
  SelectPlayer({super.key});

  final SelectPlayerController c = Get.find<SelectPlayerController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        // print(didPop);
        if (didPop) {
          return;
        }
        c.onDone();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              c.onDone();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 22,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Select Player",
            textAlign: TextAlign.center,
            style: CustomTextStyles.f18W600(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                c.onDone();
              },
              child: Text("Done"),
            )
          ],
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: c.availablePlayer.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                  c.availablePlayer[index].profilePhotoPath == null
                      ? const CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.onBackGroundColor,
                          backgroundImage: AssetImage(
                            ImagePath.defaultAvatar,
                          ),
                        )
                      : SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  c.availablePlayer[index].profilePhotoPath!,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      Image.asset(
                                ImagePath.defaultAvatar,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                ImagePath.defaultAvatar,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                  Expanded(
                    child: Theme(
                      data: ThemeData(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: Obx(
                        () => CheckboxListTile(
                          checkColor: AppColors.primaryColor,
                          selectedTileColor: AppColors.backGroundColor,
                          fillColor: MaterialStateColor.resolveWith(
                            (states) {
                              if (states.contains(MaterialState.selected)) {
                                return AppColors.backGroundColor;
                              }
                              return AppColors.primaryColor;
                            },
                          ),
                          onChanged: (value) {
                            c.togglePlayer(
                                value: value, user: c.availablePlayer[index]);
                          },
                          value: c.selectedTeamPlayer.any(
                            (e) =>
                                e.username == c.availablePlayer[index].username,
                          ),
                          title: Text(
                              c.availablePlayer[index].name ?? "Demo user"),
                          subtitle: Text(c.availablePlayer[index].username ??
                              "demoUser@12"),
                          splashRadius: 0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
            // ListTile(
            //   onTap: () {},
            //   leading: c.availablePlayer[index].profilePhotoPath == null
            //       ? const CircleAvatar(
            //           backgroundColor: AppColors.onBackGroundColor,
            //           backgroundImage: AssetImage(
            //             ImagePath.defaultAvatar,
            //           ),
            //         )
            //       : const CircleAvatar(
            //           backgroundColor: AppColors.onBackGroundColor,
            //           backgroundImage: AssetImage(
            //             ImagePath.defaultAvatar,
            //           ),
            //         ),
            //   title: Text(c.availablePlayer[index].name ?? "Demo user"),
            //   subtitle:
            //       Text(c.availablePlayer[index].username ?? "demoUser@12"),
            //   trailing: Obx(
            //     () => SizedBox(
            //       // height: 22,
            //       // width: 22,
            //       child: Checkbox(
            //         onChanged: (value) {
            //           c.togglePlayer(
            //               value: value, user: c.availablePlayer[index]);
            //         },
            //         value: c.selectedTeamPlayer.any(
            //           (e) => e.username == c.availablePlayer[index].username,
            //         ),
            //       ),
            //     ),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}

class SelectedPlayerArgument {
  final List<User> allGamePlayer;
  final List<User> selectedTeamPlayer;
  final List<User> allSelectedPlayer;
  final int maxPlayer;

  SelectedPlayerArgument({
    required this.allGamePlayer,
    required this.selectedTeamPlayer,
    required this.allSelectedPlayer,
    this.maxPlayer = 6,
  });
}
