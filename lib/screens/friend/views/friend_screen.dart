import 'package:cric_score_connect/screens/friend/widgets/friend_screen_app_bar.dart';
import 'package:cric_score_connect/screens/friend/widgets/accepted_friend_tabbaar_view.dart';
import 'package:cric_score_connect/screens/friend/widgets/pending_friend_tabbaar_view.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';

class FriendScreen extends StatefulWidget {
  static const String routeName = "/friend-screen";
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen>
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
    // var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(
          color: AppColors.backGroundColor,
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const FriendAppBar(),
            SliverAppBar(
              pinned: true,
              scrolledUnderElevation: 0,
              flexibleSpace: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                        'Friend Requests',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Friend Lists',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            children: [
              PendingFriendTabbarView(),
              AcceptedFriendTabbarView(),
            ],
          ),
        ),
      ),
    );
  }
}
