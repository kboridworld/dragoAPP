import 'package:dragoma/common/service/account_repository.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';
import 'package:lib_ylz_utils_package/extension/text_utils.dart';

import 'account_controller.dart';

///登录类型
/// code、验证码登录
/// pwd、账号密码登录
class LoginType {
  static const TYPE_CODE = 'code';
  static const TYPE_PWD = 'pwd';
}

class LoginController extends AccountController {
  String? loginType = LoginType.TYPE_CODE;

  var pwdLoginBtnEnable = false.obs;

  var codeLoginBtnEnable = false.obs;

  @override
  void onInit() {
    loginType = Get.arguments ?? loginType;
    super.onInit();
  }

  refreshLoginBtnEnable() {
    if (loginType == LoginType.TYPE_PWD)
      pwdLoginBtnEnable.value = phoneEditController.text.isNotTextEmpty &&
          pwdEditController.text.isNotTextEmpty;
    else
      codeLoginBtnEnable.value = phoneEditController.text.isNotTextEmpty &&
          codeEditController.text.isNotTextEmpty;
  }

  changeLoginType() {
    if (loginType == LoginType.TYPE_CODE) {
      loginType = LoginType.TYPE_PWD;
      codeEditController.text = '';
    } else {
      loginType = LoginType.TYPE_CODE;
      pwdEditController.text = '';
    }
    refreshLoginBtnEnable();
    update();
  }

  ///
  /// 账号密码登录
  Future<void> loginByAccount(String phone, String pwd) async {
    ProgressHUD.showLoading(text: '登录中...');
    try {
      await UserModel.shareInstance.login(phone, pwd);
    } finally {
      ProgressHUD.dismissAllHUD();
    }
  }

  ///
  /// 手机验证码登录
  Future<void> loginByCode(String phone, String code) async {
    ProgressHUD.showLoading(text: '登录中...');
    try {
      await UserModel.shareInstance.loginByCode(phone, code);
    } finally {
      ProgressHUD.dismissAllHUD();
    }
  }

  @override
  Future<void> getBizAuthCode() {
    return AccountRepository.getLoginAuthCode(phoneEditController.text);
  }
}
