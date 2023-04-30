import 'package:flutter/material.dart';
import 'package:himatubu_chat/common_widgets/custom_text.dart';
import 'package:himatubu_chat/common_widgets/custom_text_button.dart';
import 'package:himatubu_chat/styles/sizes.dart';

class CardDetailsButtonComponent extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const CardDetailsButtonComponent({
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      elevation: 1,
      minWidth: Sizes.textButtonMinWidth(context),
      minHeight: Sizes.textButtonMinHeight(context),
      buttonColor: Colors.amberAccent,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: onPressed,
      child: CustomText.h5(
        context,
        title,
        color: Colors.white,
        alignment: Alignment.center,
      ),
    );
  }
}
