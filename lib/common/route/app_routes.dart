import 'package:dragoma/common/middleware/unlogin_middleware.dart';
import 'package:dragoma/pages/guide/controller/guide_controller.dart';
import 'package:dragoma/pages/guide/page/guide_screen_page.dart';
import 'package:dragoma/pages/login/login_router.dart';
import 'package:dragoma/pages/main/controller/main_controller.dart';
import 'package:dragoma/pages/main/main_page.dart';
import 'package:dragoma/pages/main/tab/four_page.dart';
import 'package:dragoma/pages/main/tab/three_page.dart';
import 'package:dragoma/pages/main/tab/two_page.dart';
import 'package:dragoma/pages/system/page/not_found_page.dart';
import 'package:dragoma/pages/system/system_router.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_page_lifecycle/base/binding_lifecycle_page.dart';

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
    page: () => NotFoundPage(),
  );

  static final List<GetPage> getPages = [
    BindingLifecyclePage(
      name: rootPage,
      page: () => GuideScreenPage(),
      creator: () => GuideController(),
    ),
    BindingLifecyclePage(
      name: mainPage,
      page: () => MainPage(),
      creator: () => MainController(),
      bindings: [
        BindingsBuilder(() {
          Get.lazyPut(() => TwoTabController());
        }),
        BindingsBuilder(() {
          Get.lazyPut(() => ThreeTabController());
        }),
        BindingsBuilder(() {
          Get.lazyPut(() => FourTabController());
        }),
      ],
      middlewares: [UnLoginMiddleware()],
      transition: Transition.noTransition,
    ),
  ];
}
