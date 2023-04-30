import 'package:flutter/material.dart';
import 'package:himatubu_chat/common_widgets/cached_network_image_circular.dart';
import 'package:himatubu_chat/common_widgets/custom_text.dart';
import 'package:himatubu_chat/models/user_model.dart';
import 'package:himatubu_chat/styles/sizes.dart';

class CardUserDetailsComponent extends StatelessWidget {
  final UserModel userModel;

  const CardUserDetailsComponent({
    required this.userModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CachedNetworkImageCircular(
          imageUrl: userModel.profileImageUrl,
          radius: Sizes.userImageSmallRadius(context),
        ),
        SizedBox(
          width: Sizes.hMarginSmallest(context),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.h3(
                context,
                userModel.username.isEmpty ? "匿名" : userModel.username,
                color: Theme.of(context).textTheme.headline4!.color,
                weight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
              CustomText.h4(
                context,
                userModel.place,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              CustomText.h4(
                context,
                "${userModel.age.toString()}歳",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
