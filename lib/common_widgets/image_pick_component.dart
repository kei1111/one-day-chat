import 'package:flutter/material.dart';
import 'package:himatubu_chat/styles/sizes.dart';

class ImagePickComponent extends StatelessWidget {
  const ImagePickComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.vPaddingSmallest(context),
          horizontal: Sizes.hPaddingSmallest(context),
        ),
        constraints: const BoxConstraints(),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("オプション"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(
                      height: 1,
                    ),
                    Material(
                      color: Theme.of(context).primaryColor,
                      child: ListTile(
                        onTap: () async {},
                        title: const Text("カメラ"),
                        leading: const Icon(
                          Icons.camera,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Material(
                      color: Theme.of(context).primaryColor,
                      child: ListTile(
                        onTap: () async {},
                        title: const Text("ギャラリー"),
                        leading: const Icon(
                          Icons.account_box,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        shape: const CircleBorder(),
        fillColor: Theme.of(context).primaryColor,
        elevation: 1,
        child: const ImageIcon(AssetImage('assets/images/core/camera.png')));
  }
}
