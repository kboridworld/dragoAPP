import 'package:flutter/material.dart';
import 'package:dragoma/common/res/dimens.dart';

class TextStyles {
  static const TextStyle textSize12 = TextStyle(fontSize: Dimens.font_sp12);
  static const TextStyle textSize13 = TextStyle(fontSize: Dimens.font_sp13);
  static const TextStyle textSize14 = TextStyle(fontSize: Dimens.font_sp14);
  static const TextStyle textSize15 = TextStyle(fontSize: Dimens.font_sp15);
  static const TextStyle textSize17 = TextStyle(fontSize: Dimens.font_sp17);
  static const TextStyle textSize22 = TextStyle(fontSize: Dimens.font_sp22);
  static const TextStyle textSize24 = TextStyle(fontSize: Dimens.font_sp24);
}

//
class ViewStyles {
  // button 渐变背景按钮
  static const linear = LinearGradient(colors: [
    Color(0xff0bc86c),
    Color(0xff03af8a),
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);

  static const linearOpacity0_5 = LinearGradient(colors: [
    Color(0x7f0bc86c),
    Color(0x7f03af8a),
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);

  static const grayLinear = LinearGradient(colors: [
    ColorValues.grey_ccc,
    ColorValues.grey_ccc,
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);

  static const itemBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(Dimens.radius_dp10)),
    color: Colors.white,
  );
}

class ColorValues {
  static const Color primaryColor = Color(0xFF06B880);
  static const Color primaryOrange = Color(0xFFFB9432);
  static const Color primaryBlue = Color(0xFF2A7CD6);

  static const Color accentOrange = Color(0xFFFFEAD5);
  static const Color accentBlue = Color(0xFFD9E9FC);

  static const Color primWarningTips = Color(0xFFED4934);

  static const Color primaryText = Color(0xFF323233);
  static const Color summaryText = Color(0xFF646566);
  static const Color descriptionText = Color(0xFF969799);
  static const Color tipsText = Color(0xFFC8C9CC);

  static const Color grey_90 = Color(0xFF909090);
  static const Color grey_bd = Color(0xFFBDBDBD);
  static const Color grey_ccc = Color(0xFFCCCCCC);
  static const Color grey_bg = Color(0xFFF5F6F7);
  static const Color grey_eaebec = Color(0xFFEAEBEC);
  static const Color grey_e1e4e6 = Color(0xFFE1E4E6);

  static const Color divider_ebedf0 = Color(0xFFebedf0);
  static const Color divider_dcdee0 = Color(0xFFdcdee0);

  static const Color color_646566 = Color(0xFF646566);
  static const Color color_d8d8d8 = Color(0xFFD8D8D8);

  static const Color color_shadow = Color(0x219EA5A5);
  static const Color color_shadow_cfd2d5= Color(0xFFCFD2D5);
  static const Color color_shadow_3D8C9C= Color(0x503D8C9C);
  static const Color color_e4fdf5 = Color(0xFFE4FDF5);
  static const Color color_f4fffb = Color(0xFFF4FFFB);
}
