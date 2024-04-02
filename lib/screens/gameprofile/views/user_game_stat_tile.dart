import 'package:cric_score_connect/utils/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';

class UserGameStatsTile extends StatelessWidget {
  const UserGameStatsTile({
    super.key,
    required this.title,
    this.data,
  });
  final String title;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.f14W400(),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            data ?? "--:--",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.f14W400(),
          ),
        ],
      ),
    );
  }
}
