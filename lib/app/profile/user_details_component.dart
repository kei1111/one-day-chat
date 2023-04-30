import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/common_widgets/custom_text.dart';
import 'package:himatubu_chat/common_widgets/loading_indicators.dart';
import 'package:himatubu_chat/styles/font_styles.dart';
import 'package:himatubu_chat/styles/sizes.dart';

import '../../repository/user_repository.dart';

class UserDetailsComponent extends ConsumerWidget {
  const UserDetailsComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final userModel = ref.watch(userRepositoryProvider).userModel;

    return userModel == null
        ? LoadingIndicators.instance.smallLoadingAnimation(context)
        : Column(
            children: [
              CustomText.h3(
                context,
                userModel.username,
                weight: FontStyles.fontWeightBold,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: Sizes.vMarginDot(context),
              ),
              CustomText.h5(
                context,
                userModel.gender,
                alignment: Alignment.center,
              ),
            ],
          );
  }
}
