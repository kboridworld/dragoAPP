import 'package:dragoma/application.dart';
import 'package:dragoma/common/const/constant.dart';
import 'package:dragoma/common/stortage_manager.dart';
import 'package:dragoma/pages/base/wrap_bi_controller.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:dragoma/pages/system/viewModel/web_console_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nh_flutter_network/nh_flutter_network.dart';

class DevSettingExtra {
  static const String proxyIp = "proxyIp";
  static const String proxyPort = "proxyPort";
}

class DevSettingController extends WrapBIController {
  TextEditingController ipEditController = TextEditingController(
      text: StorageManager.sharedPre.getString(DevSettingExtra.proxyIp));
  TextEditingController portEditController = TextEditingController(
      text: StorageManager.sharedPre.getString(DevSettingExtra.proxyPort));

  var index = 0.obs;

  // 访问日志查询
  var isWebServerRunning = false.obs;

  String get webServerPath => WebConsoleModel.shared.webServerPath;

  @override
  void onInit() {
    AppEnv env = enumFromString(AppEnv.values, defaultEnv) ?? AppEnv.PROD;
    index.value =
        StorageManager.sharedPre.getInt(Constant.KEY_env) ?? env.index;
    isWebServerRunning.value = WebConsoleModel.shared.isServerRunning;
    super.onInit();
  }

  void change(int? tmp) {
    if (null != tmp) index.value = tmp;
  }

  AppEnv getCuEvn() {
    return AppEnv.values[index.value];
  }

  Future<bool> savePoxyConfig() async {
    var results = await Future.wait([
      StorageManager.sharedPre.setInt(Constant.KEY_env, index.value),
      StorageManager.sharedPre
          .setString(DevSettingExtra.proxyIp, ipEditController.value.text),
      StorageManager.sharedPre
          .setString(DevSettingExtra.proxyPort, portEditController.value.text)
    ]);
    if (results.length == 3) {
      await UserModel.shareInstance.logout();
      await Future.delayed(Duration(seconds: 1), () {
        NetworkManager.shared.reInitialize(AppEnv.values[index.value],
            proxyIP: ipEditController.value.text,
            proxyPort: portEditController.value.text);
      });
      return true;
    }
    return false;
  }

  void startWebServer() {
    WebConsoleModel.shared.start(onStarted: () {
      isWebServerRunning.value = WebConsoleModel.shared.isServerRunning;
    });
  }

  void stopWebServer() async {
    await WebConsoleModel.shared.stop();
    isWebServerRunning.value = WebConsoleModel.shared.isServerRunning;
  }
}
