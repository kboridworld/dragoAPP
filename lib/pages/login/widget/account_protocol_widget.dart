import 'package:dragoma/common/res/dimens.dart';
import 'package:dragoma/common/res/gaps.dart';
import 'package:dragoma/common/res/strings.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/pages/login/controller/account_controller.dart';
import 'package:dragoma/utils/web_view_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';

///
/// 登录注册协议组件
class AccountProtocolWidget<T extends AccountController>
    extends StatelessWidget {
  final T controller;

  const AccountProtocolWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() => Container(
                width: 30,
                height: 30,
                child: FittedBox(
                  child: CircleCheckbox(
                      side: BorderSide(width: 14.0),
                      value: controller.isAgreeProtocol.value,
                      checkColor: Colors.white,
                      activeColor: ColorValues.primaryColor,
                      onChanged: (checked) {
                        controller.changeAgreeProtocol();
                      }),
                ),
              )),
          Gaps.hGap8,
          Text.rich(
            TextSpan(children: <TextSpan>[
              TextSpan(
                  text: YlzString.login_tip_agreement_protocol,
                  style: TextStyle(
                      color: ColorValues.descriptionText,
                      fontSize: Dimens.font_sp12),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      controller.changeAgreeProtocol();
                    }),
              TextSpan(
                  text: YlzString.user_protocol,
                  style: TextStyle(
                      color: ColorValues.primaryColor,
                      fontSize: Dimens.font_sp12),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      WebViewUtils.gotoUserProtocol();
                    }),
              TextSpan(
                  text: '和',
                  style: TextStyle(
                      color: ColorValues.descriptionText,
                      fontSize: Dimens.font_sp12)),
              TextSpan(
                  text: YlzString.private_protocol,
                  style: TextStyle(
                      color: ColorValues.primaryColor,
                      fontSize: Dimens.font_sp12),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      WebViewUtils.gotoPrivateProtocol();
                    }),
            ]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
