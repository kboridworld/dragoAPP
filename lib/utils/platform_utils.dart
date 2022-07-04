import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';
import 'package:nh_flutter_native_channel/nh_flutter_native_channel.dart';
import 'package:package_info/package_info.dart';

export 'dart:io';

class PlatformUtils {
  static final PlatformUtils _instance = PlatformUtils._internal();

  PlatformUtils._internal();

  factory PlatformUtils() => _instance;

  static PlatformUtils get instance => _instance;

  late PackageInfo packageInfo;
  String appVersion = '';
  String buildNum = '';
  AndroidDeviceInfo? androidDeviceInfo;
  IosDeviceInfo? iosDeviceInfo;
  String deviceName = '';
  String brand = '';
  String systemVersion = '';
  String deviceId = '';
  String manufacturer = "";

  ///
  /// 运荔枝平台货主app id
  get ylzAppId {
    if (Platform.isIOS) {
      return 'hz-ios';
    }
    return 'hz-ad';
  }

  ///
  /// 运荔枝平台货主app secret
  get ylzAppSecret {
    if (Platform.isIOS) {
      return '50a5123c776490288befec5c918d32f9';
    }
    return '3738085dcbf5f65f9c4296a922855c3b';
  }

  String get platform {
    if (Platform.isIOS) {
      return 'IOS';
    }
    return 'ANDROID';
  }

  String get clientCode {
    if (Platform.isIOS) {
      return 'customer_app_ios';
    }
    return 'customer_app_android';
  }

  int get appVersionInteger {
    if (appVersion.isNotTextEmpty && appVersion.split(".").length > 2) {
      var versionSplits = appVersion.split('.');
      return (int.tryParse(versionSplits[0]) ?? 0) * 10000 +
          (int.tryParse(versionSplits[1]) ?? 0) * 100 +
          (int.tryParse(versionSplits[2]) ?? 0) * 1;
    } else {
      return 0;
    }
  }

  Future<bool> setup() async {
    DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
    packageInfo = await PackageInfo.fromPlatform();
    appVersion = await _getAppVersionName(packageInfo);
    buildNum = await _getAppVersionNumber(packageInfo);
    if (Platform.isAndroid) {
      androidDeviceInfo = await _deviceInfoPlugin.androidInfo;
      systemVersion = androidDeviceInfo!.version.release;
      manufacturer = androidDeviceInfo!.manufacturer;
      deviceName = androidDeviceInfo!.model;
      brand = androidDeviceInfo!.brand;
    } else {
      iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
      systemVersion =
          iosDeviceInfo!.systemName + " " + iosDeviceInfo!.systemVersion;
      deviceName = iosDeviceInfo!.utsname.machine;
      manufacturer = "Apple";
      brand = 'Apple';
    }
    deviceId = await NhFlutterNativeChannel.caller
        .callNative(moduleName: 'DeviceInfo', method: 'getDeviceId');
    return true;
  }

  // format  2.2.2.2020200_0826-19-39-31 to 2.2.2
  Future<String> _getAppVersionName(PackageInfo packageInfo) async {
    if (Platform.isIOS) {
      return packageInfo.version;
    }
    return packageInfo.version;
  }

  /// format 2.2.2.2020200_0826-19-39-31 to 2020200
  Future<String> _getAppVersionNumber(PackageInfo packageInfo) async {
    if (Platform.isIOS) {
      return packageInfo.buildNumber;
    }
    return packageInfo.buildNumber;
  }
}
