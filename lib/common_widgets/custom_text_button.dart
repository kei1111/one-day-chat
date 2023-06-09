import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:himatubu_chat/common_widgets/custom_text.dart';
import 'package:himatubu_chat/styles/sizes.dart';

class CustomTextButton extends StatelessWidget {
  final double minHeight;
  final double minWidth;
  final Widget? child;
  final String? text;
  final VoidCallback? onPressed;
  final OutlinedBorder? shape;
  final double? elevation;
  final Color? buttonColor;
  final Color? splashColor;
  final Color? shadowColor;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onLongPress;
  final MaterialTapTargetSize? tapTargetSize;

  const CustomTextButton({
    this.minHeight = 0,
    this.minWidth = 0,
    this.child,
    this.text,
    required this.onPressed,
    this.shape,
    this.elevation,
    this.buttonColor,
    this.splashColor,
    this.shadowColor,
    this.padding,
    this.onLongPress,
    this.tapTargetSize,
    Key? key,
  })  : assert(text != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformTextButton(
      onPressed: onPressed,
      color: buttonColor,
      material: (_, __) {
        return MaterialTextButtonData(
          style: TextButton.styleFrom(
            shape: shape,
            elevation: elevation ?? 0,
            backgroundColor: buttonColor,
            shadowColor: shadowColor,
            padding: padding ??
                EdgeInsets.symmetric(
                  vertical: Sizes.vPaddingTiny(context),
                  horizontal: Sizes.hPaddingSmallest(context),
                ),
            minimumSize: Size(minWidth, minHeight),
            tapTargetSize: tapTargetSize,
          ),
          onLongPress: onLongPress,
        );
      },
      cupertino: (_, __) {
        return CupertinoTextButtonData(
          borderRadius: shape != null
              ? (shape as RoundedRectangleBorder)
                  .borderRadius
                  .resolve(Directionality.maybeOf(context))
              : null,
          padding: padding ??
              EdgeInsets.symmetric(
                vertical: Sizes.vPaddingTiny(context),
                horizontal: Sizes.hPaddingSmallest(context),
              ),
          minSize: minHeight,
        );
      },
      child: child ??
          CustomText.h5(
            context,
            text!,
            alignment: Alignment.center,
          ),
    );
  }
}
