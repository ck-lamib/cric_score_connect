import 'package:cric_score_connect/screens/game/widgets/gaming/fall_of_wicket_app_bar.dart';
import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:cric_score_connect/utils/constants/datas.dart';
import 'package:cric_score_connect/utils/constants/size_config.dart';
import 'package:cric_score_connect/widgets/custom/custom_dropdown_textfield.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class FallOfWicketScreen extends StatelessWidget {
  static const String routeName = "/fall-of-wicket-screen";
  const FallOfWicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(
          color: AppColors.backGroundColor,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const FallOfWicketAppBar(),
            SliverToBoxAdapter(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomDropdownTextField(
                      hint: "How Wicket fell?",
                      labelText: "How Wicket fell?",
                      dropDownItemLists: [
                        ...wicketReason
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList()
                      ],
                    ),
                    SizeConfig.getSpace(),
                    const CustomDropdownTextField(
                      hint: "New Batsman",
                      labelText: "New Batsman",
                      dropDownItemLists: [
                        DropdownMenuItem(
                          value: "Bimal kc",
                          child: Text("Bimal kc"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: CustomElevatedButton(
            title: "Done",
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
