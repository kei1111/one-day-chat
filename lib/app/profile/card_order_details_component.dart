import 'package:flutter/material.dart';
import 'package:himatubu_chat/common_widgets/custom_text.dart';
import 'package:himatubu_chat/models/user_model.dart';
import 'package:himatubu_chat/styles/sizes.dart';
import 'package:intl/intl.dart';

class CardOrderDetailsComponent extends StatelessWidget {
  final UserModel userModel;

  const CardOrderDetailsComponent({
    required this.userModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Container(
              height: Sizes.statusCircleRadius(context),
              width: Sizes.statusCircleRadius(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: userModel.gender == "男性" ? Colors.green : Colors.pink,
              ),
            ),
            SizedBox(
              width: Sizes.hMarginTiny(context),
            ),
            Expanded(
              child: CustomText.h6(
                context,
                userModel.gender,
                color: userModel.gender == "男性" ? Colors.green : Colors.pink,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        CustomText.h6(
          context,
          "登録日：${DateFormat.yMMMMEEEEd('ja').format(userModel.createdAt)}",
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
