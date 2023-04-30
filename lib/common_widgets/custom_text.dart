import 'package:flutter/material.dart';
import 'package:himatubu_chat/styles/sizes.dart';

class CustomText extends Container {
  CustomText(
    BuildContext context,
    String text, {
    Key? key,
    double? size,
    color,
    weight,
    width,
    bool underline = false,
    strutStyle,
    textAlign,
    textDirection,
    locale,
    softWrap,
    overflow,
    textScaleFactor,
    maxLines,
    semanticsLabel,
    textWidthBasis,
    height,
    textHeightBehavior,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Alignment? alignment,
  }) : super(
            key: key,
            margin: margin,
            padding: padding,
            alignment: alignment ?? (Alignment.topLeft),
            width: width,
            child: Text(
              text,
              style: TextStyle(
                color: color,
                height: height,
                fontSize: size,
                fontWeight: weight,
                decoration: underline ? TextDecoration.underline : null,
              ),
              strutStyle: strutStyle,
              textAlign: textAlign,
              textDirection: textDirection,
              locale: locale,
              softWrap: softWrap,
              overflow: overflow,
              textScaleFactor: textScaleFactor,
              maxLines: maxLines,
              semanticsLabel: semanticsLabel,
              textWidthBasis: textWidthBasis,
              textHeightBehavior: textHeightBehavior,
            ));

  CustomText.h0(
    BuildContext context,
    String text, {
    Key? key,
    Color? color,
    FontWeight? weight,
    bool? underline,
    TextAlign? textAlign,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? height,
    int? maxLines,
    Alignment? alignment,
  }) : this(
          context,
          text,
          key: key,
          maxLines: maxLines,
          size: Sizes.fontSizes(context)['h0'],
          padding: padding,
          margin: margin,
          height: height,
          color: color ?? Theme.of(context).textTheme.displayLarge?.color,
          weight: weight ?? FontWeight.w900,
          textAlign: textAlign,
          alignment: alignment,
        );

  CustomText.h1(
    BuildContext context,
    String text, {
    Key? key,
    Color? color,
    FontWeight? weight,
    bool? underline,
    TextAlign? textAlign,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? height,
    int? maxLines,
    Alignment? alignment,
  }) : this(
          context,
          text,
          key: key,
          maxLines: maxLines,
          size: Sizes.fontSizes(context)['h1'],
          padding: padding,
          margin: margin,
          height: height,
          color: color ?? Theme.of(context).textTheme.displayLarge?.color,
          weight: weight ?? FontWeight.w900,
          textAlign: textAlign,
          alignment: alignment,
        );

  CustomText.h2(
    BuildContext context,
    String text, {
    Key? key,
    Color? color,
    FontWeight? weight,
    TextAlign? textAlign,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? height,
    int? maxLines,
    dynamic overflow,
    Alignment? alignment,
  }) : this(
          context,
          text,
          key: key,
          padding: padding,
          margin: margin,
          size: Sizes.fontSizes(context)['h2'],
          color: color ?? Theme.of(context).textTheme.displayMedium?.color,
          weight: weight ?? FontWeight.w900,
          textAlign: textAlign,
          height: height,
          maxLines: maxLines,
          overflow: overflow,
          alignment: alignment,
        );

  CustomText.h3(
    BuildContext context,
    String text, {
    Key? key,
    Color? color,
    FontWeight? weight,
    TextAlign? textAlign,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? height,
    bool underline = false,
    dynamic overflow,
    int? maxLines,
    Alignment? alignment,
  }) : this(
          context,
          text,
          key: key,
          maxLines: maxLines,
          size: Sizes.fontSizes(context)['h3'],
          padding: padding,
          margin: margin,
          height: height,
          color: color ?? Theme.of(context).textTheme.displaySmall?.color,
          weight: weight,
          textAlign: textAlign,
          underline: underline,
          overflow: overflow,
          alignment: alignment,
        );

  CustomText.h4(
    BuildContext context,
    String text, {
    Key? key,
    Color? color,
    FontWeight? weight,
    TextAlign? textAlign,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? height,
    bool underline = false,
    dynamic overflow,
    int? maxLines,
    Alignment? alignment,
  }) : this(
          context,
          text,
          key: key,
          padding: padding,
          margin: margin,
          size: Sizes.fontSizes(context)['h4'],
          color: color ?? Theme.of(context).textTheme.headlineMedium?.color,
          weight: weight,
          height: height,
          textAlign: textAlign,
          underline: underline,
          maxLines: maxLines,
          overflow: overflow,
          alignment: alignment,
        );

  CustomText.h5(
    BuildContext context,
    String text, {
    Key? key,
    Color? color,
    FontWeight? weight,
    TextAlign? textAlign,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? height,
    dynamic overflow,
    int? maxLines,
    Alignment? alignment,
  }) : this(
          context,
          text,
          key: key,
          maxLines: maxLines,
          size: Sizes.fontSizes(context)['h5'],
          padding: padding,
          margin: margin,
          height: height,
          color: color ?? Theme.of(context).textTheme.headlineSmall?.color,
          weight: weight,
          overflow: overflow,
          textAlign: textAlign,
          alignment: alignment,
        );

  CustomText.h6(
    BuildContext context,
    String text, {
    Key? key,
    Color? color,
    FontWeight? weight,
    TextAlign? textAlign,
    dynamic overflow,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? height,
    int? maxLines,
    Alignment? alignment,
  }) : this(
          context,
          text,
          key: key,
          maxLines: maxLines,
          size: Sizes.fontSizes(context)['h6'],
          padding: padding,
          margin: margin,
          height: height,
          overflow: overflow,
          color: color ?? Theme.of(context).textTheme.titleLarge?.color,
          weight: weight,
          textAlign: textAlign,
          alignment: alignment,
        );
}