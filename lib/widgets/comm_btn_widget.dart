import 'package:flutter/material.dart';
import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';
import 'package:dragoma/common/res/dimens.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/widgets/image_loader.dart';
import 'package:dragoma/utils/ui_utils.dart';

class CommonBtnWidget {
  ///
  /// 通用按钮
  static Widget buttonWidget(
    BuildContext context,
    String title,
    VoidCallback? onTap, {
    double? width,
    double height = Dimens.button_normal_height,
    double iconSize = Dimens.gap_dp14,
    Widget? icon,
    String? iconPath,
    double fontSize = Dimens.font_sp17,
    Color titleColor = Colors.white,
    Color? btnColor,
    bool showBorder = false,
    Color borderColor = ColorValues.grey_ccc,
    bool isRadius = true,
    double radius = Dimens.gap_dp6,
    bool setIconAtRight = false,
    bool enable = true,
  }) {
    btnColor = showBorder ? Colors.white : ColorValues.primaryColor;

    return Container(
      height: height,
      constraints:
          BoxConstraints(maxWidth: width ?? MediaQuery.of(context).size.width),
      decoration: BoxDecoration(
        borderRadius: isRadius
            ? BorderRadius.circular(radius)
            : BorderRadius.all(Radius.zero),
        border: showBorder
            ? Border.all(color: borderColor, width: 1)
            : Border.all(width: 0, style: BorderStyle.none),
      ),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: isRadius
                ? BorderRadius.circular(radius)
                : BorderRadius.all(Radius.zero)),
        color: btnColor,
        disabledColor: btnColor.withOpacity(0.3),
        highlightColor: Colors.transparent,
        splashColor:Colors.transparent,
        focusColor:Colors.transparent,
        // 设为透明色
        elevation: 0,
        onPressed: enable
            ? () => throttle(() {
                  onTap?.call();
                })
            : null,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(color: titleColor, fontSize: fontSize),
              ),
            ]..insertAll(setIconAtRight ? 1 : 0, [
                if (icon != null) icon,
                if (iconPath.isNotTextEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: ImageLoader(
                      iconPath!,
                      width: iconSize,
                      height: iconSize,
                    ),
                  )
              ])),
      ),
    );
  }

  ///
  /// 带有渐变色的button
  static Widget buttonGradientWidget(
    BuildContext context,
    String title,
    VoidCallback? onTap, {
    double? width,
    double? height,
    double fontSize = Dimens.font_sp17,
    FontWeight fontWeight = FontWeight.normal,
    Color textColor = Colors.white,
    Gradient gradient = ViewStyles.linear,
  }) {
    return Container(
      height: height ?? Dimens.button_normal_height,
      constraints:
          BoxConstraints(maxWidth: width ?? MediaQuery.of(context).size.width),
      decoration: BoxDecoration(
          gradient: onTap == null ? ViewStyles.grayLinear : gradient, // 渐变色
          borderRadius: BorderRadius.circular(22)),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        color: Colors.transparent,
        // 设为透明色
        elevation: 0,
        disabledColor: ColorValues.grey_ccc,
        highlightElevation: 0,
        onPressed: () => throttle(() {
          onTap?.call();
        }),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: textColor, fontSize: fontSize, fontWeight: fontWeight),
            ),
          ],
        ),
      ),
    );
  }
}
