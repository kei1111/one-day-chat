import 'package:flutter/material.dart';

import '../common_widgets/size_configs.dart';

const Color kPrimaryColor = Color(0xffFC9D45);
const Color kSecondaryColor = Color(0xff573353);
const Color kScaffoldBackground = Color(0xffFFF3E9);

const kTitle = TextStyle(
  fontFamily: 'Klasik',
  color: kSecondaryColor,
);

final kTitle2 = TextStyle(
  fontFamily: 'Klasik',
  fontSize: SizeConfig.blockSizeH! * 6,
  color: kSecondaryColor,
);

final kBodyText1 = TextStyle(
  color: kSecondaryColor,
  fontSize: SizeConfig.blockSizeH== null ? 12 :  SizeConfig.blockSizeH! * 4.5,
  fontWeight: FontWeight.bold,
);

const kBodyText2 = TextStyle(
  color: kSecondaryColor,
  
  fontWeight: FontWeight.bold,
);

const kBodyText3 = TextStyle(
    color: kSecondaryColor,
    fontWeight: FontWeight.normal);

final kInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: BorderSide.none,
);

final kInputHintStyle = kBodyText2.copyWith(
  fontWeight: FontWeight.normal,
  color: kSecondaryColor.withOpacity(0.5),
);