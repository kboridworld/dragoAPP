import 'package:dragoma/pages/login/login_router.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// 未登录拦截-中间件
class UnLoginMiddleware extends GetMiddleware {
  @override
  int? priority = 1;

  @override
  RouteSettings? redirect(String? route) {
    debugPrint('=======UnLoginMiddleware.redirect:$route');
    if (!UserModel.shareInstance.isLogin) {
      return RouteSettings(name: LoginRouter.login);
    }
    return super.redirect(route);
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    debugPrint('=======UnLoginMiddleware.onPageCalled:$page');
    return super.onPageCalled(page);
  }
}
