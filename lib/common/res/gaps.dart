import 'package:dragoma/common/res/dimens.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Gaps {
  static const Widget empty = SizedBox.shrink();

  /// 水平间隔
  static const Widget hGap2 = SizedBox(width: Dimens.gap_dp2);
  static const Widget hGap4 = SizedBox(width: Dimens.gap_dp4);
  static const Widget hGap6 = SizedBox(height: Dimens.gap_dp6);
  static const Widget hGap8 = SizedBox(width: Dimens.gap_dp8);
  static const Widget hGap10 = SizedBox(width: Dimens.gap_dp10);
  static const Widget hGap12 = SizedBox(width: Dimens.gap_dp12);
  static const Widget hGap14 = SizedBox(width: Dimens.gap_dp14);
  static const Widget hGap16 = SizedBox(width: Dimens.gap_dp16);
  static const Widget hGap20 = SizedBox(width: Dimens.gap_dp20);

  static const Widget hGap24 = SizedBox(width: Dimens.gap_dp24);
  static const Widget hGap32 = SizedBox(width: Dimens.gap_dp32);

  /// 垂直间隔
  static const Widget vGap2 = SizedBox(width: Dimens.gap_dp2);
  static const Widget vGap4 = SizedBox(height: Dimens.gap_dp4);
  static const Widget vGap6 = SizedBox(height: Dimens.gap_dp6);
  static const Widget vGap8 = SizedBox(height: Dimens.gap_dp8);
  static const Widget vGap10 = SizedBox(height: Dimens.gap_dp10);
  static const Widget vGap12 = SizedBox(height: Dimens.gap_dp12);
  static const Widget vGap14 = SizedBox(height: Dimens.gap_dp14);
  static const Widget vGap16 = SizedBox(height: Dimens.gap_dp16);
  static const Widget vGap20 = SizedBox(height: Dimens.gap_dp20);
  static const Widget vGap24 = SizedBox(height: Dimens.gap_dp24);
  static const Widget vGap28 = SizedBox(height: Dimens.gap_dp28);
  static const Widget vGap32 = SizedBox(height: Dimens.gap_dp32);
  static const Widget vGap40 = SizedBox(height: Dimens.gap_dp40);

  static const Widget hLin = Divider(
    color: ColorValues.divider_ebedf0,
    height: 0.5,
  );

  static const Widget hLinDeep = Divider(
    color: ColorValues.divider_dcdee0,
    height: 0.5,
  );

  static Widget vLin(
          {double width = 0.5,
          double height = 24,
          Color color = ColorValues.divider_ebedf0}) =>
      SizedBox(
          width: width, height: height, child: VerticalDivider(color: color));
}
