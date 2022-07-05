import 'package:dragoma/pages/login/controller/login_controller.dart';
import 'package:dragoma/pages/login/controller/register_controller.dart';
import 'package:dragoma/pages/login/page/login_page.dart';
import 'package:dragoma/pages/login/page/register_page.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_page_lifecycle/base/binding_lifecycle_page.dart';

///
/// 登录、注册相关路由
class LoginRouter {
  static const String login = '/login';
  static const String register = '/register';

  static List<GetPage> getPages = [
    BindingLifecyclePage(
      name: login,
      page: () => LoginPage(),
      creator: () => LoginController(),
    ),
    BindingLifecyclePage(
      name: register,
      page: () => RegisterPage(),
      creator: () => RegisterController(),
    ),
  ];
}
