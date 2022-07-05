import 'package:dragoma/common/res/strings.dart';
import 'package:dragoma/pages/system/system_router.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

///
/// WebView跳转utils
class WebViewUtils {
  ///
  /// 用户协议
  static void gotoUserProtocol({bool outsideApp = false}) {
    String _url = YlzString.user_protocol_url;
    if (outsideApp) {
      gotoOutAppWebView(url: _url);
      return;
    }
    _inAppWebView(url: _url, title: YlzString.title_ylz_user_protocol);
  }

  ///
  /// 隐私协议
  static void gotoPrivateProtocol({bool outsideApp = false}) {
    String _url = YlzString.private_protocol_url;
    if (outsideApp) {
      gotoOutAppWebView(url: _url);
      return;
    }
    _inAppWebView(url: _url, title: YlzString.title_ylz_private_protocol);
  }

  ///
  /// app内打开
  static void gotoInAppWebView({required String url, String? title}) {
    _inAppWebView(url: url, title: title);
  }

  ///
  /// app外打开
  static void gotoOutAppWebView({required String url}) async {
    if (await canLaunchUrlString(url)) {
      launchUrlString(url, mode: LaunchMode.externalApplication);
    }
  }

  static void _inAppWebView({required String url, String? title}) {
    Get.toNamed(SystemRouter.commonWeb,
        arguments: {'title': title ?? '', 'url': url});
  }
}
