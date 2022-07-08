import 'package:dragoma/common/res/dimens.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/widgets/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';

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
    Color? titleColor,
    Color? btnColor,
    bool showBorder = false,
    Color borderColor = ColorValues.grey_ccc,
    bool isRadius = true,
    double radius = Dimens.gap_dp6,
    bool setIconAtRight = false,
  }) {
    btnColor = showBorder ? Colors.white : ColorValues.primaryColor;
    titleColor =
        titleColor ?? (showBorder ? ColorValues.grey_ccc : Colors.white);

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
      child: ElevatedButton(
        onPressed: onTap,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(color: titleColor, fontSize: fontSize),
              ),
            ]..insertAll(setIconAtRight ? 1 : 0, [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: icon,
                  ),
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
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: isRadius
                  ? BorderRadius.circular(radius)
                  : BorderRadius.all(Radius.zero)),
          primary: btnColor,
          onSurface: btnColor,
          // onPrimary: btnColor,
          elevation: 0,
        ),
      ),
    );
  }
}
