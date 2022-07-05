import 'dart:convert';

import 'package:dragoma/common/const/constant.dart';
import 'package:dragoma/common/http/host/constants_host.dart';
import 'package:dragoma/common/stortage_manager.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:dragoma/pages/upgrade/app_upgrade_dialog_widget.dart';
import 'package:dragoma/utils/platform_utils.dart';
import 'package:flutter/material.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';
import 'package:lib_ylz_upgrade_package/lib_ylz_upgrade_package.dart';
import 'package:lib_ylz_utils_package/extension/text_utils.dart';
import 'package:provider/provider.dart';

class SystemInfoModel extends BasicStateModel {
  static const int checkUpdateExpiredTime = 1 * 60 * 60 * 1000; //1小时

  final BuildContext _context;

  String version = '';
  String buildNumber = '';
  String deviceName = '';
  String systemVersion = '';
  String deviceID = '';
  bool showDetailContent = UserModel.shareInstance.telPhone != '19900000000';
  bool needUpdate = false;
  bool hasNotificationPermission = false;
  String fingerprint = '';
  String manufacturer = '';
  bool _didShowUpdateAlert = false;

  late UpgradeViewModel _upgradeViewModel;

  SystemInfoModel(this._context) {
    _upgradeViewModel = Provider.of<UpgradeViewModel>(_context, listen: false);
  }

  String get appDisplayVersion {
    return 'v${this.version}(${this.buildNumber})';
  }

  Future<void> fetchSystemInfo() async {
    PlatformUtils platformUtils = PlatformUtils.instance;
    version = platformUtils.appVersion;
    buildNumber = platformUtils.buildNum;
    deviceName = platformUtils.brand + " " + platformUtils.deviceName;
    systemVersion = '${platformUtils.systemVersion}';
    if (Platform.isAndroid) {
      systemVersion += '- ${platformUtils.androidDeviceInfo.hardware}';
      fingerprint = platformUtils.androidDeviceInfo.display ?? '';
    }
    deviceID = platformUtils.deviceId;
    needUpdate = _upgradeViewModel.upgradeModel?.hasUpgrade ?? false;
    manufacturer = platformUtils.manufacturer;
    notifyListeners();
  }

  Future<void> updateDownload() async {
    if (_upgradeViewModel.upgradeModel?.hasUpgrade ?? false) {
      checkUpdate(showLoading: true);
    }
  }

  /// 检查App是否需要升级
  checkUpdate({bool showLoading = false}) async {
    if (_didShowUpdateAlert) return;
    if (!_isStorageExpired(checkUpdateExpiredTime)) return;
    UpgradeUtil.checkUpdate(
        context: _context,
        widget: AppUpgradeDialogWidget(),
        hostAlias: Host.BfsUser,
        clientCode: PlatformUtils.instance.clientCode,
        currentVersion: PlatformUtils.instance.appVersionInteger,
        onCheckUpgradeStart: () {
          if (showLoading) ProgressHUD.showLoading(text: '检查更新');
        },
        onCheckUpgradeFinish: (value) {
          if (showLoading) ProgressHUD.dismissAllHUD();
        });
    //更新检查升级时间
    _updateStorageCheckTime(DateTime.now().millisecondsSinceEpoch);
  }

  /// 检查本地缓存的信息是否过期（App升级检查、合同服务检查需要设定间隔时间）
  //  /// 本地缓存格式：{storageKey:{userId1: 上次检查时间戳, userId2: 上次检查时间}}
  bool _isStorageExpired(int expiredInterval) {
    if (!UserModel.shareInstance.isLogin) {
      return false;
    }
    var jsonStr =
        StorageManager.sharedPre.getString(Constant.KEY_UPDATE_CHECK_TIMESTAMP);
    if (jsonStr.isTextEmpty) return true;
    Map<String, dynamic> lastCheckTimeRecords = jsonDecode(jsonStr!);
    var userId = UserModel.shareInstance.userId;
    if (!lastCheckTimeRecords.containsKey(userId)) return true;
    int lastCheckTime = lastCheckTimeRecords[userId];
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastCheckTime > expiredInterval) return true;
    return false;
  }

  cleanLocalStorageCheckTime() {
    _updateStorageCheckTime(0);
  }

  /// 更新本地缓存记录时间
  /// 如：当用户当前不需要升级时，需要更新检查记录：接下来指定的时间段内不会重复检查
  _updateStorageCheckTime(int time) {
    var jsonStr =
        StorageManager.sharedPre.getString(Constant.KEY_UPDATE_CHECK_TIMESTAMP);
    dynamic records = {};
    if (jsonStr.isNotTextEmpty) {
      records = jsonDecode(jsonStr!);
    }
    var userId = UserModel.shareInstance.userId;
    if (userId.isTextEmpty) return;
    records[userId] = time;
    StorageManager.sharedPre
        .setString(Constant.KEY_UPDATE_CHECK_TIMESTAMP, jsonEncode(records));
  }
}
