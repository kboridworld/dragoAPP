import 'dart:async';

import 'package:dragoma/pages/base/wrap_bi_controller.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:dragoma/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';
import 'package:lib_ylz_utils_package/extension/text_utils.dart';

abstract class AccountController extends WrapBIController {
  final int maxPhoneLength = 11; //手机号的位数
  final int minPwdLength = 6; //密码至少6位
  final int maxPwdLength = 18; //密码至多18位
  final TextEditingController phoneEditController =
      TextEditingController(text: UserModel.shareInstance.telPhone);
  final TextEditingController codeEditController = TextEditingController();
  final TextEditingController pwdEditController = TextEditingController();

  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode codeFocusNode = FocusNode();
  final FocusNode pwdFocusNode = FocusNode();

  /// 是否同意用户协议和隐私协议
  var isAgreeProtocol = false.obs;

  /// 是否显示明文
  var isObscureText = true.obs;

  /// 获取验证码按钮是否可点击
  var getCodeBtnEnable = false.obs;

  var countdownNum = 0.obs;

  Timer? countdownTimer;

  /// 改变密码明文显示状态
  changeObscureText() {
    isObscureText.toggle();
  }

  /// 改变是否同意协议复选框状态
  changeAgreeProtocol() {
    isAgreeProtocol.toggle();
  }

  ///
  /// 如未勾选同意协议复选框，提示是否确认阅读
  showProtocolTips() {
    YLZToastUtils.showToast('请阅读并同意协议');
  }

  ///
  /// 获取验证码
  Future<void> getAuthCode() async {
    if (getCodeBtnEnable.isFalse || countdownNum.value > 0) return;
    if (phoneEditController.text.isTextEmpty ||
        phoneEditController.text.length != 11) {
      YLZToastUtils.showToast('请输入正确的手机号');
      return;
    }
    if (isAgreeProtocol.isFalse) {
      showProtocolTips();
      return;
    }

    ProgressHUD loading = ProgressHUD.showLoading(text: '获取验证码');
    try {
      await getBizAuthCode().then((value) {
        YLZToastUtils.showToast('验证码已发送');
        FocusScope.of(Get.context!).requestFocus(codeFocusNode);
        countdownNum.value = 60;
        getCodeBtnEnable.value = false;
        if (countdownTimer != null) {
          countdownTimer?.cancel();
          countdownTimer = null;
        }
        countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
          countdownNum--;
          if (countdownNum.value <= 0) {
            countdownTimer?.cancel();
            countdownTimer = null;
            getCodeBtnEnable.value = true;
          }
        });
      });
    } finally {
      loading.dismiss();
    }
  }

  Future<void> getBizAuthCode();

  @override
  void onInit() {
    if (phoneEditController.text.length > 0) getCodeBtnEnable.value = true;
    super.onInit();
  }

  @override
  void onDestroy() {
    countdownTimer?.cancel();
    super.onDestroy();
  }
}
