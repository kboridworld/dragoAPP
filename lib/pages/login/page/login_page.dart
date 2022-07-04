import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart'
    hide InputRow;
import 'package:dragoma/common/res/dimens.dart';
import 'package:dragoma/common/res/gaps.dart';
import 'package:dragoma/common/res/strings.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/widgets/image_loader.dart';
import 'package:dragoma/pages/login/controller/login_controller.dart';
import 'package:dragoma/pages/login/login_helper.dart';
import 'package:dragoma/pages/login/mixin/account_mixin.dart';
import 'package:dragoma/pages/login/widget/input_row.dart';
import 'package:dragoma/widgets/comm_btn_widget.dart';

///
/// 登录页面
class LoginPage extends GetView<LoginController> with AccountMixin {
  @override
  Widget build(BuildContext context) {
    double headerHeight = Get.width / 375 * 280;
    double headerShowHeight = Get.width / 375 * 235;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  // 头部
                  Container(
                    height: headerHeight,
                    child: Stack(
                      children: [
                        // 头部背景
                        ImageLoader('user/bg_login'),
                        // 头部内容
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 标题栏
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                color: Colors.transparent,
                                width: 44,
                                height: 44.0,
                                margin: EdgeInsets.only(top: 40.0),
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: ImageLoader(
                                  'comm/icon_back_arrow',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                            // 头部信息内容
                            buildHeaderWidget(),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 主体内容
                  Positioned(
                    top: headerShowHeight,
                    child: GetBuilder<LoginController>(
                      assignId: true,
                      builder: (controller) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height -
                              headerShowHeight,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x52C5E1D1),
                                offset: Offset(0.0, -2.0),
                                blurRadius: 16.0,
                                spreadRadius: 0.0,
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _contentWidget(),
                              _buildMoreLogin(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// 更多登录方式
  _buildMoreLogin() {
    TextStyle _loginStyle = TextStyle(
        color: ColorValues.descriptionText, fontSize: Dimens.font_sp12);
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      padding: EdgeInsets.only(bottom: 61.0) +
          EdgeInsets.only(bottom: Get.mediaQuery.padding.bottom),
      child: Column(
        children: [
          Text(
            '更多登录方式',
            style: TextStyles.textSize12.copyWith(color: ColorValues.grey_ccc),
          ),
          Gaps.vGap12,
          Row(
            children: [
              Gaps.hGap50,
              if (controller.loginType == LoginType.TYPE_CODE)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.codeFocusNode.unfocus();
                      controller.changeLoginType();
                    },
                    child: Column(
                      children: [
                        ImageLoader('user/icon_login_pwd',
                            width: 44, height: 44),
                        Gaps.vGap8,
                        Text('账号密码登录', style: _loginStyle),
                      ],
                    ),
                  ),
                ),
              if (controller.loginType == LoginType.TYPE_PWD)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.codeFocusNode.unfocus();
                      controller.changeLoginType();
                    },
                    child: Column(
                      children: [
                        ImageLoader('user/icon_login_code',
                            width: 44, height: 44),
                        Gaps.vGap8,
                        Text('手机验证码登录', style: _loginStyle),
                      ],
                    ),
                  ),
                ),
              Gaps.hGap50,
            ],
          ),
        ],
      ),
    );
  }

  ///
  /// 账号输入主widget
  _contentWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          controller.loginType == LoginType.TYPE_PWD
              ? _buildPwdWidget(() {
                  controller.loginByAccount(controller.phoneEditController.text,
                      controller.pwdEditController.text);
                })
              : _buildCodeWidget(() {
                  controller.loginByCode(controller.phoneEditController.text,
                      controller.codeEditController.text);
                }),
          Gaps.vGap24,
          Text.rich(TextSpan(
            children: [
              TextSpan(
                  text: '还没有账号吗？',
                  style: TextStyle(
                      color: ColorValues.summaryText,
                      fontSize: Dimens.font_sp14,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: '申请企业注册',
                  style: TextStyle(
                      fontSize: Dimens.font_sp14,
                      color: ColorValues.primaryColor,
                      fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      LoginHelper.register();
                    }),
            ],
          )),
        ],
      ),
    );
  }

  ///
  /// 账号密码登录widget
  _buildPwdWidget(VoidCallback action) {
    return Column(
      children: [
        /// 手机号码
        CleanSuffixTextField(
          style: TextStyle(
              color: ColorValues.primaryText,
              fontSize: 17,
              fontWeight: FontWeight.bold),
          keyboardType: TextInputType.phone,
          controller: controller.phoneEditController,
          focusNode: controller.phoneFocusNode,
          maxLength: controller.maxPhoneLength,
          buildCounter: (BuildContext context,
              {required int currentLength,
              int? maxLength,
              required bool isFocused}) {
            return null;
          },
          decoration: InputDecoration(
            icon: ImageLoader(
              'user/icon_login_tips_phone',
              width: 24,
              color: ColorValues.tipsText,
            ),
            border: InputBorder.none,
            hintText: '请输入手机号/账号',
            hintStyle: TextStyle(
                color: ColorValues.grey_ccc,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          onEditingComplete: () {
            controller.pwdFocusNode.requestFocus();
          },
          onChanged: (String text) {
            controller.refreshLoginBtnEnable();
          },
        ),
        Gaps.hLin,
        SizedBox(height: 20),

        /// 密码
        Obx(() => Row(
              children: [
                Expanded(
                  child: CleanSuffixTextField(
                    style: TextStyle(
                        color: ColorValues.primaryText,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    obscureText: controller.isObscureText.value,
                    controller: controller.pwdEditController,
                    focusNode: controller.pwdFocusNode,
                    decoration: InputDecoration(
                      icon: ImageLoader(
                        'user/icon_login_tips_pwd',
                        width: 24,
                        color: ColorValues.tipsText,
                      ),
                      border: InputBorder.none,
                      hintText: '请输入密码',
                      hintStyle: TextStyle(
                          color: ColorValues.grey_ccc,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    onEditingComplete: () {
                      if (!controller.pwdLoginBtnEnable.value) return;
                      controller.pwdFocusNode.unfocus();
                      if (controller.isAgreeProtocol.isFalse) {
                        controller.showProtocolTips();
                        return;
                      }
                      action.call();
                    },
                    onChanged: (String text) {
                      controller.refreshLoginBtnEnable();
                    },
                  ),
                ),
                IconButton(
                  icon: controller.isObscureText.isTrue
                      ? ImageLoader(
                          'user/icon_pwd_hide',
                          width: 24,
                          height: 24,
                        )
                      : ImageLoader(
                          'user/icon_pwd_show',
                          width: 24,
                          height: 24,
                        ),
                  onPressed: controller.changeObscureText,
                )
              ],
            )),
        Gaps.hLin,
        buildProtocolWidget(controller),
        SizedBox(height: 16),
        Obx(() => CommonBtnWidget.buttonWidget(
              Get.context!,
              YlzString.login,
              () {
                controller.pwdFocusNode.unfocus();
                controller.phoneFocusNode.unfocus();
                if (controller.isAgreeProtocol.isFalse) {
                  controller.showProtocolTips();
                  return;
                }
                action.call();
              },
              enable: controller.pwdLoginBtnEnable.isTrue,
            )),
      ],
    );
  }

  ///
  /// 手机验证码登录widget
  _buildCodeWidget(VoidCallback action) {
    return Column(
      children: [
        /// 手机号码
        CleanSuffixTextField(
          style: TextStyle(
              color: ColorValues.primaryText,
              fontSize: 17,
              fontWeight: FontWeight.bold),
          keyboardType: TextInputType.phone,
          controller: controller.phoneEditController,
          focusNode: controller.phoneFocusNode,
          maxLength: controller.maxPhoneLength,
          buildCounter: (BuildContext context,
              {required int currentLength,
              int? maxLength,
              required bool isFocused}) {
            return null;
          },
          decoration: InputDecoration(
            icon: ImageLoader(
              'user/icon_login_tips_phone',
              width: 24,
              color: ColorValues.tipsText,
            ),
            border: InputBorder.none,
            hintText: '请输入手机号',
            hintStyle: TextStyle(
                color: ColorValues.grey_ccc,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          onEditingComplete: () {
            controller.codeFocusNode.requestFocus();
          },
          onChanged: (String text) {
            controller.getCodeBtnEnable.value = text.length > 0;
          },
        ),
        Gaps.hLin,
        SizedBox(height: 20),

        /// 验证码
        Obx(() => InputRow(
              '',
              maxLength: 4,
              enable: controller.getCodeBtnEnable.isTrue,
              placeholder: '请输入手机验证码',
              controller: controller.codeEditController,
              focusNode: controller.codeFocusNode,
              keyboardType: TextInputType.number,
              actionName: controller.countdownNum <= 0
                  ? '获取验证码'
                  : "${controller.countdownNum}秒可重发",
              onAction: () {
                if (controller.countdownNum <= 0) {
                  controller.getAuthCode();
                }
              },
              titleWidth: 0,
              onEditingComplete: () {
                if (!controller.codeLoginBtnEnable.value) return;
                controller.codeFocusNode.unfocus();
                if (controller.isAgreeProtocol.isFalse) {
                  controller.showProtocolTips();
                  return;
                }
                action.call();
              },
              onChanged: (String text) {
                controller.refreshLoginBtnEnable();
              },
            )),
        Gaps.hLin,
        buildProtocolWidget(controller),
        SizedBox(height: 16),
        Obx(() => CommonBtnWidget.buttonWidget(
              Get.context!,
              YlzString.login,
              () {
                controller.codeFocusNode.unfocus();
                controller.phoneFocusNode.unfocus();
                if (controller.isAgreeProtocol.isFalse) {
                  controller.showProtocolTips();
                  return;
                }
                action.call();
              },
              enable: controller.codeLoginBtnEnable.isTrue,
            )),
      ],
    );
  }
}
