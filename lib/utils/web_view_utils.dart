import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:dragoma/common/res/strings.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:dragoma/pages/system/system_router.dart';
import 'package:dragoma/utils/platform_utils.dart';

///
/// webview跳转utils
class WebViewUtils {
  static void gotoUserProtocol({required BuildContext context}) {
    _viewWebView(
        url: YlzString.user_protocol_url,
        title: YlzString.title_ylz_user_protocol);
  }

  static void gotoPrivateProtocol({required BuildContext context}) {
    _viewWebView(
        url: YlzString.private_protocol_url,
        title: YlzString.title_ylz_private_protocol);
  }

  static void gotoAboutYlz({required BuildContext context}) {
    _viewWebView(url: YlzString.about_url, title: YlzString.title_about_ylz);
  }

  static void gotoFeedback({required BuildContext context}) {
    String? brand;
    String? model;
    if (Platform.isAndroid) {
      AndroidDeviceInfo? deviceInfo = PlatformUtils.instance.androidDeviceInfo;
      brand = deviceInfo?.brand;
      model = deviceInfo?.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo? deviceInfo = PlatformUtils.instance.iosDeviceInfo;
      model = deviceInfo?.model;
    }
    PackageInfo packageInfo = PlatformUtils.instance.packageInfo;
    String openUid = UserModel.shareInstance.userId +
        '_' +
        UserModel.shareInstance.telPhone +
        '_' +
        (brand ?? '') +
        (model ?? '') +
        '_' +
        packageInfo.buildNumber;
    String avatar = "https://s1.ax1x.com/2020/07/20/UfsYK1.png";
    String userName =
        Uri.encodeQueryComponent(UserModel.shareInstance.realName);

    var url =
        'https://support.qq.com/embed/phone/320796/?openid=$openUid&nickname=$userName&avatar=$avatar';
    _viewWebView(url: url, title: '问题反馈');
  }

  static void gotoCommonWebView({required String url, String? title}) {
    _viewWebView(url: url, title: title);
  }

  static void _viewWebView({required String url, String? title}) {
    Get.toNamed(SystemRouter.commonWeb,
        arguments: {'title': title ?? '', 'url': url});
  }
}
