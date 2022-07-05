import 'package:dragoma/common/res/dimens.dart';
import 'package:dragoma/common/res/gaps.dart';
import 'package:dragoma/common/res/strings.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/utils/web_view_utils.dart';
import 'package:dragoma/widgets/comm_btn_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProtocolDialog {
  ///用户协议和隐私协议弹窗
  static show(
      {VoidCallback? positiveCallback, VoidCallback? negativeCallback}) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          contentPadding: EdgeInsets.all(0),
          title: Text('用户协议和隐私协议',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorValues.primaryText,
                  fontSize: Dimens.font_sp17,
                  fontWeight: FontWeight.w600)),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: '欢迎使用${YlzString.appName}！\n请充分阅读',
                            style: TextStyle(
                                color: ColorValues.primaryText,
                                fontSize: Dimens.font_sp14)),
                        TextSpan(
                            text: YlzString.user_protocol,
                            style: TextStyle(
                                color: ColorValues.primaryColor,
                                fontSize: Dimens.font_sp14),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                WebViewUtils.gotoUserProtocol(outsideApp: true);
                              }),
                        TextSpan(
                            text: '和',
                            style: TextStyle(
                                color: ColorValues.primaryText,
                                fontSize: Dimens.font_sp14)),
                        TextSpan(
                            text: YlzString.private_protocol,
                            style: TextStyle(
                                color: ColorValues.primaryColor,
                                fontSize: Dimens.font_sp14),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                WebViewUtils.gotoPrivateProtocol(
                                    outsideApp: true);
                              }),
                        TextSpan(
                          text: '，点击“同意并继续”按钮代表您已同意前述协议及下列约定：'
                              '\n为了识别您的身份进行快捷登录，我们将申请电话权限；'
                              '\n为了基于位置提供合适的用车服务，我们将申请定位权限；'
                              '\n为了存储软件运行的日志、历史数据等内容，我们将申请数据存储权限；'
                              '\n为了快捷填写发货、收货联系人，我们将申请读取联系人权限。',
                          style: TextStyle(
                              color: ColorValues.primaryText,
                              fontSize: Dimens.font_sp14),
                        ),
                      ],
                      style: TextStyle(
                          color: ColorValues.primaryText,
                          fontSize: Dimens.font_sp14),
                    ),
                  ),
                  Gaps.vGap24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: CommonBtnWidget.buttonWidget(
                          Get.context!,
                          '取消',
                          () {
                            Get.back();
                            negativeCallback?.call();
                          },
                          height: 38,
                          radius: 4,
                          fontSize: Dimens.font_sp13,
                          showBorder: true,
                          titleColor: ColorValues.summaryText,
                        ),
                      ),
                      Gaps.hGap8,
                      Expanded(
                        child: CommonBtnWidget.buttonWidget(
                          Get.context!,
                          '同意并继续',
                          () {
                            Get.back();
                            positiveCallback?.call();
                          },
                          height: 38,
                          radius: 4,
                          fontSize: Dimens.font_sp13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
