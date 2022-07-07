import 'dart:async';
import 'dart:io';

import 'package:dragoma/common/http/host/bfs_user_host_provider.dart';
import 'package:dragoma/common/http/host/mock_provider.dart';
import 'package:dragoma/common/http/host/sso_host_provider.dart';
import 'package:dragoma/common/http/interceptors/common_info_interceptor.dart';
import 'package:dragoma/common/http/interceptors/log_interceptor.dart';
import 'package:dragoma/common/http/interceptors/response_interceptor.dart';
import 'package:dragoma/common/route/app_routes.dart';
import 'package:dragoma/common/stortage_manager.dart';
import 'package:dragoma/utils/database/ylz_consignor_db.dart';
import 'package:dragoma/utils/env_util.dart';
import 'package:dragoma/utils/location/amap_location_model.dart';
import 'package:dragoma/utils/log/ylz_log_util.dart';
import 'package:dragoma/utils/platform_utils.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nh_flutter_network/network/nh_network_manager.dart';
import 'package:nh_flutter_network/nh_flutter_network.dart';

const bool inProduction = const bool.fromEnvironment("dart.vm.product");

///
/// 来自于打包命令
const bool needDevelopTool =
    bool.fromEnvironment('devTool', defaultValue: false);
const String defaultEnv = String.fromEnvironment('env', defaultValue: 'PROD');

class Application {
  static final EventBus eventBus = EventBus();
  static final YLZConsignorDB driverDB = YLZConsignorDB();

  // ignore: close_sinks
  static StreamController<bool> appStreamController =
      StreamController.broadcast();

  // app是否在前台
  static bool isForegroundApp = true;

  static Future<Null> appInitializer() async {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ));
    }
    await setupModules();
  }

  static Future<Null> setupModules() async {
    //初始化存储
    await StorageManager.init();
    if (needDevelopTool) {
      YLZLogUtil.instance.setup();
    }
    AppRoutes.configureRoutes();
    // 网络库初始化
    setupNetworkManager();
    LocationUtils.shared.setup();
  }

  static setupNetworkManager() {
    NetworkManager.shared.initialize(EnvUtil.getCurrentEnv(), [
      SSOHostProvider(),
      BfsUserHostProvider(),
      MockProvider(),
    ], interceptors: [
      CommonInfoInterceptor(),
      ResponseInterceptor(),
      YLZLogInterceptor()
    ]);
  }

  ///
  /// 更新app前后台状态
  static updateAppFrontStatus(bool inFront) {
    isForegroundApp = inFront;
    appStreamController.sink.add(inFront);
  }
}
