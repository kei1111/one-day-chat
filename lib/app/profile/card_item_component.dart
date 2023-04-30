import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/app/profile/card_details_button_component.dart';
import 'package:himatubu_chat/app/profile/card_order_details_component.dart';
import 'package:himatubu_chat/app/profile/card_user_details_component.dart';
import 'package:himatubu_chat/common_widgets/card_button_component.dart';
import 'package:himatubu_chat/models/user_model.dart';

import '../../styles/sizes.dart';

class CardItemComponent extends ConsumerWidget {
  const CardItemComponent({
    required this.userModel,
    Key? key,
  }) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context, ref) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.cardRadius(context)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.cardVPadding(context),
          horizontal: Sizes.cardHRadius(context),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CardOrderDetailsComponent(
                    userModel: userModel,
                  ),
                ),
                CardDetailsButtonComponent(
                  title: "詳細",
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              height: Sizes.vMarginSmallest(context),
            ),
            CardUserDetailsComponent(
              userModel: userModel,
            ),
            SizedBox(
              height: Sizes.vMarginSmallest(context),
            ),
            SizedBox(
              height: Sizes.vMarginComment(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardButtonComponent(
                  title: "cancel",
                  isColored: false,
                  onPressed: () {},
                ),
                CardButtonComponent(
                  title: "申請する",
                  isColored: true,
                  onPressed: () {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
