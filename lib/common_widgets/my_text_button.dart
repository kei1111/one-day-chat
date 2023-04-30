import 'package:flutter/material.dart';
import 'package:himatubu_chat/common_widgets/size_configs.dart';


class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key? key,
    required this.buttonName,
    required this.onPressed,
    required this.bgColor,
  }) : super(key: key);
  final String buttonName;
  final VoidCallback onPressed;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: SizedBox(
        height: SizeConfig.blockSizeH == null ?  40 : SizeConfig.blockSizeH!* 15.5,
        width: SizeConfig.blockSizeH == null ? 100:  SizeConfig.blockSizeH!  * 100,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            buttonName,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}