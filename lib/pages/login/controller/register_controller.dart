import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dragoma/common/service/account_repository.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';
import 'package:lib_ylz_utils_package/extension/text_utils.dart';

import 'account_controller.dart';

class RegisterController extends AccountController {
  // 注册按钮是否可点击
  var registerBtnEnable = false.obs;

  refreshRegisterBtnStatus() {
    registerBtnEnable.value = phoneEditController.text.isNotTextEmpty &&
        codeEditController.text.isNotTextEmpty &&
        pwdEditController.text.isNotTextEmpty &&
        pwdEditController.text.length >= minPwdLength &&
        pwdEditController.text.length <= maxPwdLength;
  }

  ///
  /// 账号密码验证码注册
  Future<void> registerByAccount(String phone, String pwd, String code) async {
    ProgressHUD.showLoading(text: '注册中...');

    var result =
        await AccountRepository.registerAccounts(phone, generateMD5(pwd), code);

    ///注册成功 自动登录
    try {
      await UserModel.shareInstance.login(phone, pwd);
    } finally {
      ProgressHUD.dismissAllHUD();
    }
    return result;
  }

  // md5 加密
  String generateMD5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  bool checkPassword(String input) {
    RegExp mobile = new RegExp(r'^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$');
    return mobile.hasMatch(input);
  }

  @override
  Future<void> getBizAuthCode() {
    return AccountRepository.getRegisterAuthCode(phoneEditController.text);
  }
}
