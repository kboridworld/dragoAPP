import 'package:get/get.dart';
import 'package:lib_ylz_page_lifecycle/base/binding_lifecycle_page.dart';
import 'package:dragoma/pages/system/controller/console_controller.dart';
import 'package:dragoma/pages/system/controller/dev_setting_controller.dart';
import 'package:dragoma/pages/system/controller/webview_controller.dart';
import 'package:dragoma/pages/system/page/console_page.dart';
import 'package:dragoma/pages/system/page/dev_setting_page.dart';
import 'package:dragoma/pages/system/page/system_info_page.dart';
import 'package:dragoma/pages/system/page/webview_page.dart';

class SystemRouter {
  static final commonWeb = '/webViewPage'; //网页
  static const String systemInfo = '/mine/system_info';
  static const String consolePage = '/mine/console_log';
  static const String devSetting = "/mine/dev/setting"; //调试页

  static List<GetPage> getPages = [
    GetPage(
      name: systemInfo,
      page: () => SystemInfoPage(),
    ),
    BindingLifecyclePage(
      name: devSetting,
      page: () => DevSettingPage(),
      creator: () => DevSettingController(),
    ),
    BindingLifecyclePage(
      name: consolePage,
      page: () => ConsolePage(),
      creator: ()=> ConsoleController(),
    ),
    // 当url中存在query:auth=1,则代表需要token信息
    // 打开前会在url中新增query:xxxxxx
    // 格式：id=aaa&token=ccc&idcard=ddd&name=eee&tokenv2=fff,
    // commonWeb?url=https://www.baidu.com?auto=1&title=123
    BindingLifecyclePage(
      name: commonWeb,
      page: () => WebViewPage(),
      creator: () => WebViewerController(),
    ),
  ];
}
