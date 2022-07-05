import 'package:dragoma/common/middleware/unlogin_middleware.dart';
import 'package:dragoma/pages/guide/controller/guide_controller.dart';
import 'package:dragoma/pages/guide/page/guide_screen_page.dart';
import 'package:dragoma/pages/login/login_router.dart';
import 'package:dragoma/pages/main/main_page.dart';
import 'package:dragoma/pages/system/system_router.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_page_lifecycle/base/binding_lifecycle_page.dart';
import 'package:lib_ylz_router_package/page/not_found_page.dart';

class AppRoutes {
  static final rootPage = '/'; //根

  static final mainPage = '/mainPage'; //主页

  static void configureRoutes() {
    getPages
      ..addAll(SystemRouter.getPages)
      ..addAll(LoginRouter.getPages);
  }

  static final notFoundPage = GetPage(
    name: '/notFoundPage',
    page: () => NotFoundWidget(),
  );

  static final getPages = [
    BindingLifecyclePage(
      name: rootPage,
      page: () => GuideScreenPage(),
      creator: () => GuideController(),
    ),
    GetPage(
      name: mainPage,
      page: () => MainPage(index: Get.arguments),
      middlewares: [UnLoginMiddleware()],
    ),
  ];
}
