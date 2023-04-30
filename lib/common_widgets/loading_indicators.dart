import 'package:flutter/material.dart';
import 'package:himatubu_chat/common_widgets/custom_text.dart';
import 'package:himatubu_chat/common_widgets/platform_circluar_progress_indicator.dart';
import 'package:himatubu_chat/styles/app_colors.dart';
import 'package:himatubu_chat/styles/font_styles.dart';
import 'package:himatubu_chat/styles/sizes.dart';
import 'package:lottie/lottie.dart';

class LoadingIndicators {
  LoadingIndicators._();

  static final instance = LoadingIndicators._();

  Widget defaultLoadingIndicator(
    BuildContext context, {
    String? message,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const PlatformCircularProgressIndicator(
            strokeWidth: 3,
            backgroundColor: Colors.transparent,
            color: AppColors.lightThemePrimary,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.lightThemePrimary,
            ),
            radius: 20,
          ),
          if (message != null)
            CustomText.h5(
              context,
              message,
              alignment: Alignment.center,
              weight: FontStyles.fontWeightMedium,
              color: Theme.of(context).textTheme.headline4!.color,
              margin: EdgeInsets.only(top: Sizes.vMarginHigh(context)),
            ),
        ],
      ),
    );
  }

  Widget smallLoadingAnimation(
    BuildContext context, {
    double? height,
    double? width,
  }) {
    return Center(
      child: Container(
        color: Colors.transparent,
        child: Lottie.asset(
          "assets/json/loading_animation.json",
          height: height ?? Sizes.loadingAnimationDefaultHeight(context),
          width: width ?? Sizes.loadingAnimationDefaultWidth(context),
        ),
      ),
    );
  }
}
