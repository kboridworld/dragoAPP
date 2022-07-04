import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';
import 'package:dragoma/common/res/dimens.dart';
import 'package:dragoma/common/res/gaps.dart';
import 'package:dragoma/common/res/strings.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/widgets/image_loader.dart';
import 'package:dragoma/pages/login/controller/account_controller.dart';

mixin AccountMixin {
  ///
  /// 构建header
  Widget buildHeaderWidget() {
    return Container(
      width: MediaQuery.of(Get.context!).size.width,
      padding: EdgeInsets.only(left: 21, bottom: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageLoader(
            'logo/icon_logo',
            width: 40,
            height: 40,
          ),
          Gaps.vGap16,
          Text(
            YlzString.login_hi,
            style: TextStyle(
              color: ColorValues.primaryText,
              fontSize: Dimens.font_sp24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// 公用协议widget
  Widget buildProtocolWidget(AccountController controller) {
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
                      controller.viewProtocol(YlzString.title_ylz_user_protocol,
                          YlzString.user_protocol_url);
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
                      controller.viewProtocol(
                          YlzString.title_ylz_private_protocol,
                          YlzString.private_protocol_url);
                    }),
            ]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
