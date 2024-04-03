import 'package:cric_score_connect/screens/game/widgets/gaming/next_over_app_bar.dart';
import 'package:cric_score_connect/widgets/custom/custom_dropdown_textfield.dart';
import 'package:cric_score_connect/widgets/custom/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class NextOverScreen extends StatelessWidget {
  static const String routeName = "/next-over-screen";
  const NextOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            NextOverAppBar(),
            SliverToBoxAdapter(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    CustomDropdownTextField(
                      hint: "Select Bowler",
                      labelText: "Select Bowler",
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

        // NestedScrollView(
        //   headerSliverBuilder: (context, innerBoxIsScrolled) => [
        //     const
        //   ],
        //   body: ,
        // ),
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
