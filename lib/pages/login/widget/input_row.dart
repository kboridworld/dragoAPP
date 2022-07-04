import 'package:flutter/material.dart';
import 'package:lib_ylz_ui_kit_package/input/clean_suffix_text_field.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';
import 'package:dragoma/common/res/gaps.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/widgets/image_loader.dart';

class InputRow extends StatelessWidget {
  final String title;

  //如果titleTextSpanList有值，会覆盖掉title的内容
  final List<TextSpan>? titleTextSpanList;
  final TextEditingController? controller;
  final String? placeholder;
  final VoidCallback? onTapTextField;
  final String? actionName;
  final VoidCallback? onAction;
  final bool enable;
  final bool showIndicator;
  final bool readOnly;
  final int? maxLength;
  final bool showMaxLength;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FocusNode? focusNode;
  final bool showCleanIcon;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;
  final double? titleWidth;
  final bool showLeftIcon;
  final double fontSize;
  final FontWeight fontWeight;

  Widget? emptyBuildCounter(
    BuildContext context, {
    required int currentLength,
    int? maxLength,
    required bool isFocused,
  }) {
    return null;
  }

  const InputRow(
    this.title, {
    Key? key,
    this.titleTextSpanList,
    this.controller,
    this.placeholder,
    this.onTapTextField,
    this.actionName,
    this.onAction,
    this.enable = true,
    this.showIndicator = false,
    this.readOnly = false,
    this.maxLength = 5000,
    this.showMaxLength = false,
    this.keyboardType,
    this.obscureText = false,
    this.focusNode,
    this.showCleanIcon = false,
    this.onEditingComplete,
    this.titleWidth = 75,
    this.onChanged,
    this.showLeftIcon = true,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          child: Text.rich(TextSpan(children: [
            if (titleTextSpanList == null)
              TextSpan(
                  text: title,
                  style:
                      TextStyle(color: ColorValues.primaryText, fontSize: 15)),
            ...?titleTextSpanList
          ])),
          width: titleWidth ?? 75,
        ),
        Expanded(
          child: showCleanIcon
              ? CleanSuffixTextField(
                  style: TextStyle(
                      color: ColorValues.primaryText,
                      fontSize: fontSize,
                      fontWeight: fontWeight),
                  focusNode: focusNode,
                  controller: controller,
                  maxLength: maxLength,
                  buildCounter: showMaxLength ? null : emptyBuildCounter,
                  keyboardType: keyboardType,
                  obscureText: obscureText,
                  onChanged: onChanged,
                  onEditingComplete: onEditingComplete,
                  decoration: InputDecoration(
                    icon: showLeftIcon
                        ? ImageLoader(
                            'user/icon_login_tips_code',
                            width: 24,
                            color: ColorValues.tipsText,
                          )
                        : Gaps.empty,
                    border: InputBorder.none,
                    hintText: placeholder ?? "",
                    hintStyle: TextStyle(
                        color: ColorValues.grey_ccc,
                        fontSize: fontSize,
                        fontWeight: fontWeight),
                  ),
                  onTap: onTapTextField,
                  readOnly: readOnly,
                )
              : TextField(
                  style: TextStyle(
                      color: ColorValues.primaryText,
                      fontSize: fontSize,
                      fontWeight: fontWeight),
                  focusNode: focusNode,
                  controller: controller,
                  maxLength: maxLength,
                  buildCounter: showMaxLength ? null : emptyBuildCounter,
                  keyboardType: keyboardType,
                  obscureText: obscureText,
                  onEditingComplete: onEditingComplete,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    icon: showLeftIcon
                        ? ImageLoader(
                            'user/icon_login_tips_code',
                            width: 24,
                            color: ColorValues.tipsText,
                          )
                        : Gaps.empty,
                    border: InputBorder.none,
                    hintText: placeholder ?? "",
                    hintStyle: TextStyle(
                        color: ColorValues.grey_ccc,
                        fontSize: fontSize,
                        fontWeight: fontWeight),
                  ),
                  onTap: onTapTextField,
                  readOnly: readOnly,
                ),
        ),
        if (actionName != null)
          Container(
            height: 28,
            child: RaisedButton(
                padding: EdgeInsets.zero,
                color: Colors.transparent,
                // 设为透明色
                elevation: 0,
                // 正常时阴影隐藏
                highlightElevation: 0,
                // 点击时阴影隐藏
                disabledColor: Colors.transparent,
                disabledTextColor: ColorValues.grey_ccc,
                onPressed: () {
                  if (enable) {
                    onAction?.call();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(
                      width: 1,
                      color: enable
                          ? ColorValues.primaryColor
                          : ColorValues.grey_ccc,
                    )),
                child: Text(
                  actionName!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: enable
                        ? ColorValues.primaryColor
                        : ColorValues.grey_ccc,
                    fontSize: 12,
                  ),
                )),
          ),
        if (showIndicator)
          Image.asset(
            'assets/images/icon_right_indicator.png',
            package: packageName,
            width: 6,
            height: 11,
          )
      ],
    );
  }
}
