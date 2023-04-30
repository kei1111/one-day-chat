import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ResponsiveService {
  static const Size _designSize = Size(428, 860);
  static const bool _splitScreenMode = false;

  static Size _switchableDesignSize(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? _designSize
        : const Size(860, 428);
  }

  static double fullScreenHeight(BuildContext context, {double ratio = 1}) =>
      MediaQuery.of(context).size.height * ratio;

  static double fullScreenWidth(BuildContext context, {double ratio = 1}) =>
      MediaQuery.of(context).size.width * ratio;

  static double availableScreenHeight(BuildContext context,
          {double ratio = 1}) =>
      (MediaQuery.of(context).size.height -
          MediaQueryData.fromWindow(window).viewPadding.vertical) *
      ratio;

  static double availableScreenWidth(BuildContext context,
          {double ratio = 1}) =>
      (MediaQuery.of(context).size.width -
          MediaQueryData.fromWindow(window).viewPadding.horizontal) *
      ratio;

  static Orientation orientation(BuildContext context) =>
      MediaQuery.of(context).orientation;

  static double deviceTopPadding(BuildContext context) =>
      MediaQueryData.fromWindow(window).padding.top;

  static double deviceBottomPadding(BuildContext context) =>
      MediaQueryData.fromWindow(window).padding.bottom;

  static double deviceBottomViewPadding(BuildContext context) =>
      MediaQueryData.fromWindow(window).viewPadding.bottom;

  static double deviceKeyboardHeight(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom;

  static double textScaleFactor(BuildContext context) =>
      MediaQuery.of(context).textScaleFactor;

  static double devicePixelRatio(BuildContext context) =>
      MediaQuery.of(context).devicePixelRatio;

  static double scaleWidth(BuildContext context) =>
      availableScreenWidth(context) / _switchableDesignSize(context).width;

  static double scaleHeight(BuildContext context) =>
      (_splitScreenMode
          ? max(availableScreenHeight(context), 700)
          : availableScreenHeight(context)) /
      _switchableDesignSize(context).height;

  static double scaleRadius(BuildContext context) =>
      min(scaleWidth(context), scaleHeight(context));

  static double scaleText(BuildContext context) =>
      min(scaleWidth(context), scaleHeight(context));
}
