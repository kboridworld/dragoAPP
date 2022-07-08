import 'dart:convert';

import 'package:dragoma/common/const/constant.dart';
import 'package:dragoma/common/route/app_routes.dart';
import 'package:dragoma/common/service/account_repository.dart';
import 'package:dragoma/common/stortage_manager.dart';
import 'package:dragoma/pages/base/wrap_bi_controller.dart';
import 'package:dragoma/pages/login/model/user_info.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';

class UserModel extends WrapBIController {
  ///当前账户信息
  DriverLoginInfo? _driverLoginInfo;

  String get token => _driverLoginInfo?.token ?? '';

  String get userId => _driverLoginInfo?.userId ?? '';

  /// 当前是否登录
  bool get isLogin => token.isNotTextEmpty;

  ///当前货主信息
  String get realName => _pickExtValueByKey('realName');

  String get accountName => _pickExtValueByKey('accountName');

  String get telPhone => _pickExtValueByKey('mobile');

  ///
  /// 初始化缓存数据
  static init() async {
    Get.lazyPut(() => UserModel());
    var userJson = StorageManager.sharedPre.getString(Constant.KEY_userSSOV1);
    if (userJson != null) {
      shareInstance._driverLoginInfo = DriverLoginInfo.fromJson(jsonDecode(userJson));
    }
  }

  static UserModel get shareInstance => Get.find();

  _pickExtValueByKey(String key) {
    try {
      return _driverLoginInfo?.ext[key] ?? '';
    } catch (e) {
      return '';
    }
  }

  _resetExtValueByKeys(List<String> keys) {
    try {
      keys.forEach((key) {
        _driverLoginInfo?.ext[key] = '';
      });
    } catch (e) {
      // ignore
    }
  }

  Future<void> relogin() async {
    await _dealLogin({'token': 'tt'});
  }

  Future<void> login(String phone, String password) async {
    await _dealLogin(await AccountRepository.login(phone, password));
    _redirectRouteGoto();
  }

  Future<void> loginByCode(String phone, String code) async {
    await _dealLogin(await AccountRepository.loginByCode(phone, code));
    _redirectRouteGoto();
  }

  _dealLogin(loginInfo) async {
    _driverLoginInfo = DriverLoginInfo.fromJson(loginInfo);
    StorageManager.sharedPre
        .setString(Constant.KEY_userSSOV1, jsonEncode(_driverLoginInfo));
    update();
  }

  ///
  /// 登录成功时，是否显示切换货主页面判断
  _redirectRouteGoto() {
    Get.offNamed(AppRoutes.mainPage);
  }

  ///
  /// 退出登录
  logout() async {
    await cleanToken();
  }

  ///
  /// 清空token
  Future<void> cleanToken() async {
    _driverLoginInfo?.token = null;
    _driverLoginInfo?.userId = null;
    _resetExtValueByKeys(['realName', 'customerId', 'customerCode']);
    if (_driverLoginInfo != null) {
      StorageManager.sharedPre
          .setString(Constant.KEY_userSSOV1, jsonEncode(_driverLoginInfo));
    }
    update();
  }
}
