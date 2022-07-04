import 'package:get/get.dart';
import 'package:dragoma/pages/login/controller/login_controller.dart';
import 'package:dragoma/pages/login/login_router.dart';

///
/// 登录、注册页面跳转逻辑控制
class LoginHelper {
  ///
  /// 跳转登录页面（不可唤起友盟一键登录）
  static login({String? loginType = LoginType.TYPE_CODE}) {
    if (Get.currentRoute == LoginRouter.register)
      Get.offNamed(LoginRouter.login, arguments: loginType);
    else
      Get.toNamed(LoginRouter.login, arguments: loginType);
  }

  ///
  /// 跳转注册页面
  static register() {
    if (Get.currentRoute == LoginRouter.login)
      Get.offNamed(LoginRouter.register);
    else
      Get.toNamed(LoginRouter.register);
  }
}
