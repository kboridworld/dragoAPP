import 'dart:io';

import 'package:dragoma/application.dart';
import 'package:dragoma/utils/database/ylz_consignor_db.dart';
import 'package:dragoma/utils/log/ylz_log.dart';
import 'package:dragoma/utils/log/ylz_log_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:wifi/wifi.dart';

enum WebServerStatus { running, stopped }

class WebConsoleUtils {
  static final WebConsoleUtils _instance = WebConsoleUtils._internal();

  WebConsoleUtils._internal() {
    this.serverStatus = WebServerStatus.stopped;
    this.webServerPath = '';
  }

  factory WebConsoleUtils() => _instance;

  static WebConsoleUtils get shared => _instance;

  WebServerStatus? serverStatus;
  late String webServerPath;
  static const int _serverPort = 4040;
  late YLZLogDao _logDao;
  late HttpServer _server;

  Future<void> start({VoidCallback? onStarted}) async {
    if (this.serverStatus == WebServerStatus.running) return;
    _logDao = YLZLogDao(Application.driverDB);
    String ip = await Wifi.ip;
    this.webServerPath = 'http://$ip:$_serverPort';
    this.serverStatus = WebServerStatus.running;
    debugPrint('web server listen on $webServerPath');
    _server = await HttpServer.bind(
      ip,
      _serverPort,
    );
    if (onStarted != null) {
      onStarted();
    }
    await for (HttpRequest req in _server) {
      try {
        List<YlzLogData> records = await _logDao.getRecentRecords();
        String result = '';
        records.forEach((element) {
          result +=
          '${element.headerTitle()} \n\n ${element.logInfoForWebConsole()}\n\n=====================================\n\n';
        });
        req.response.write(result);
      } catch (e) {
        req.response.write(e.toString());
      }
      await req.response.close();
    }
  }

  Future<void> stop() async {
    if (this.serverStatus == WebServerStatus.stopped) return;
    this.webServerPath = '';
    this.serverStatus = WebServerStatus.stopped;
    _server.close();
  }

  bool get isServerRunning => this.serverStatus == WebServerStatus.running;
}
