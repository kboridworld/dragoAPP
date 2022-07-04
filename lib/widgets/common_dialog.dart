import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lib_ylz_utils_package/extension/text_utils.dart';
import 'package:dragoma/common/res/dimens.dart';
import 'package:dragoma/common/res/gaps.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/widgets/comm_btn_widget.dart';

///
/// 通用dialog
class CommonDialog extends StatelessWidget {
  final String title;
  final String? content;

  // 积极推荐的操作（主题色提醒）
  final String positiveLabel;
  final Function? positiveCallback;

  // 消极不推荐的操作（灰色提醒）
  final String negativeLabel;
  final Function? negativeCallback;
  final bool isSingle;

  const CommonDialog({
    required this.title,
    this.content,
    this.positiveLabel = '确认',
    this.negativeLabel = '取消',
    this.positiveCallback,
    this.negativeCallback,
    this.isSingle = false,
  });

  @override
  Widget build(BuildContext context) {
    double contentWith = min((MediaQuery.of(context).size.width / 2 - 60), 120);

    return SimpleDialog(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            children: [
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorValues.primaryText,
                      fontSize: Dimens.font_sp17,
                      fontWeight: FontWeight.bold)),
              _buildContent(this.content),
              Gaps.vGap20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (!isSingle)
                    CommonBtnWidget.buttonWidget(
                      context,
                      negativeLabel,
                      () {
                        negativeCallback?.call();
                        Navigator.of(context).maybePop();
                      },
                      width: contentWith,
                      height: 38,
                      radius: 4,
                      fontSize: Dimens.font_sp13,
                      showBorder: true,
                      titleColor: ColorValues.summaryText,
                    ),
                  if (!isSingle) Gaps.hGap8,
                  CommonBtnWidget.buttonWidget(
                    context,
                    positiveLabel,
                    () {
                      positiveCallback?.call();
                      Navigator.of(context).maybePop();
                    },
                    width: contentWith,
                    height: 38,
                    radius: 4,
                    fontSize: Dimens.font_sp13,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildContent(String? text) {
    return null == text || text.isTextEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.only(top: 12, bottom: 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: ColorValues.color_646566),
            ),
          );
  }
}
