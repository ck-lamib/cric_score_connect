import 'package:cric_score_connect/screens/gameprofile/controller/game_profile_controller.dart';
import 'package:cric_score_connect/screens/gameprofile/widgets/game_profile_app_bar.dart';
import 'package:cric_score_connect/screens/gameprofile/widgets/game_profile_upper_section.dart';
import 'package:cric_score_connect/screens/personalinfo/widgets/personal_info_app_bar.dart';
import 'package:cric_score_connect/screens/profile/widgets/profile_upper_section.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/utils/constants/validators.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/extensions.dart';
import 'package:cric_score_connect/utils/routes/image_path.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:cric_score_connect/widgets/custom/custom_date_picker.dart';
import 'package:cric_score_connect/widgets/custom/custom_dropdown_textfield.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:cric_score_connect/widgets/custom/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GameProfileScreen extends StatefulWidget {
  static const String routeName = "/game-profile-screen";
  GameProfileScreen({super.key});

  @override
  State<GameProfileScreen> createState() => _GameProfileScreenState();
}

class _GameProfileScreenState extends State<GameProfileScreen>
    with SingleTickerProviderStateMixin {
  final GameProfileController c = Get.find<GameProfileController>();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GameProfileAppBar(),
            Container(
              margin: const EdgeInsets.only(
                top: kToolbarHeight * 1.18,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverList.list(
                    children: [
                      GameProfileUpperSection(
                        tab: Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.backGroundColor,
                                width: 1,
                              ),
                            ),
                            child: TabBar(
                                controller: _tabController,
                                indicatorSize: TabBarIndicatorSize.tab,
                                dividerColor: Colors.transparent,
                                indicator: const BoxDecoration(
                                  color: AppColors.backGroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                labelStyle: CustomTextStyles.f16W600(
                                  color: AppColors.primaryColor,
                                ),
                                unselectedLabelStyle: CustomTextStyles.f16W600(
                                  color: AppColors.textColor,
                                ),
                                labelColor: AppColors.primaryColor,
                                unselectedLabelColor: AppColors.backGroundColor,
                                tabs: const [
                                  Tab(
                                    child: Text(
                                      'Team Vs Team',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Individual',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            PlayerStatsTab(),
                            PlayerStatsTab(),
                          ],
                        ),
                      ),
                      // ProfileBottomSection
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerStatsTab extends StatefulWidget {
  const PlayerStatsTab({super.key});

  @override
  State<PlayerStatsTab> createState() => _PlayerStatsTabState();
}

class _PlayerStatsTabState extends State<PlayerStatsTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.backGroundColor,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12 * 4,
            ),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.backGroundColor,
                width: 1,
              ),
            ),
            child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: const BoxDecoration(
                  color: AppColors.backGroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                labelStyle: CustomTextStyles.f14W500(
                  color: AppColors.primaryColor,
                ),
                unselectedLabelStyle: CustomTextStyles.f14W500(
                  color: AppColors.textColor,
                ),
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: AppColors.backGroundColor,
                tabs: const [
                  Tab(
                    child: Text(
                      'Batting',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Bowling',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ]),
          ),
          Container(
            height: screenHeight * 0.05,
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blueGrey[300],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blueGrey[300],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class GameProfileScreens extends StatefulWidget {
  const GameProfileScreens({super.key});

  @override
  State<GameProfileScreens> createState() => _GameProfileScreensState();
}

class _GameProfileScreensState extends State<GameProfileScreens>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Statistics'),
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.black54,
            tabs: const <Widget>[
              Tab(
                text: ('Pokhara Lekhnath'),
              ),
              Tab(
                text: ('Outside Pokhara-Lekhnath'),
              ),
            ]),
      ),
      body: TabBarView(
        children: <Widget>[
          NestedTabBar(),
          NestedTabBar(),
        ],
        controller: _tabController,
      ),
    );
  }
}

// class Locationstat extends StatefulWidget {
//   @override
//   _LocationstatState createState() => _LocationstatState();
// }

// class _LocationstatState extends State<Locationstat>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   @override
//   void initState() {
//     super.initState();
//     _tabController = new TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _tabController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text('Statistics'),
//         bottom: TabBar(
//             controller: _tabController,
//             indicatorColor: Colors.orange,
//             labelColor: Colors.orange,
//             unselectedLabelColor: Colors.black54,
//             tabs: <Widget>[
//               Tab(
//                 text: ('Pokhara Lekhnath'),
//               ),
//               Tab(
//                 text: ('Outside Pokhara-Lekhnath'),
//               ),
//             ]),
//       ),
//       body: TabBarView(
//         children: <Widget>[
//           NestedTabBar(),
//           NestedTabBar(),
//         ],
//         controller: _tabController,
//       ),
//     );
//   }
// }

class NestedTabBar extends StatefulWidget {
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;
  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.orange,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          tabs: const <Widget>[
            Tab(
              text: "Inside Pokhara",
            ),
            Tab(
              text: "Outside Pokhara",
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.70,
          margin: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blueGrey[300],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blueGrey[300],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
