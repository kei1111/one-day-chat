import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/common_widgets/cached_network_image_circular.dart';
import 'package:himatubu_chat/common_widgets/image_pick_component.dart';
import 'package:himatubu_chat/repository/user_repository.dart';
import 'package:himatubu_chat/styles/sizes.dart';

class UserImageComponent extends ConsumerWidget {
  const UserImageComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final userModel = ref.watch(userRepositoryProvider).userModel;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CachedNetworkImageCircular(
          imageUrl: userModel?.profileImageUrl,
          radius: Sizes.userImageHighRadius(context),
        ),
        Padding(
          padding: EdgeInsets.only(right: Sizes.hPaddingTiny(context)),
          child: const ImagePickComponent(),
        ),
      ],
    );
  }
}
