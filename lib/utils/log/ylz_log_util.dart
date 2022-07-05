import 'dart:math';

import 'package:dragoma/application.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:dragoma/utils/database/ylz_consignor_db.dart';
import 'package:dragoma/utils/log/ylz_log.dart';
import 'package:dragoma/utils/log/ylz_log_dao.dart';
import 'package:dragoma/utils/platform_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const int kMaxCacheLogRecordCount = 100; // 最大本地缓存数量（超过则立即上报）
const int kAndroidConsoleMaxLength = 800; // android studio会将log截断

class YLZLogUtil {
  static final YLZLogUtil _instance = YLZLogUtil._internal();

  YLZLogUtil._internal();

  factory YLZLogUtil() => _instance;

  static YLZLogUtil get instance => _instance;

  late YLZLogDao _logDao;

  setup() {
    _logDao = YLZLogDao(Application.driverDB);
    // 为了避免异常情况，当日志条数超过最大缓存数量2倍时强制清空
    _logDao.getLogRecords().listen((records) {
      if (records.length >= kMaxCacheLogRecordCount * 2) {
        _logDao.clearLogRecords();
      }
    });
  }

  ///
  /// 日志输出+保存日志记录
  static doRecord(String? msg,
      {bool print = true,
      YLZLogSource source = YLZLogSource.debug,
      YLZLogType type = YLZLogType.plainText}) async {
    if (null == msg || msg.length == 0) return;
    if (print) {
      if (Platform.isAndroid && msg.length > kAndroidConsoleMaxLength) {
        int contentLength = msg.length;
        int lines = (contentLength / kAndroidConsoleMaxLength).ceil();
        for (int i = 0; i < lines; ++i) {
          debugPrint(msg.substring(i * kAndroidConsoleMaxLength,
              min<int>((i + 1) * kAndroidConsoleMaxLength, contentLength)));
        }
      } else {
        debugPrint(msg);
      }
    }
    if (needDevelopTool) {
      YlzLogData log = YLZLogUtil.instance._assembleLogData(msg, source, type);
      int recordsCount = await YLZLogUtil.instance._logDao.count();
      if (recordsCount >= kMaxCacheLogRecordCount) {
        await YLZLogUtil.instance._logDao.deleteFirstRecord();
      }
      await YLZLogUtil.instance._logDao.insertRecord(log);
    }
  }

  YlzLogData _assembleLogData(
      String logContent, YLZLogSource source, YLZLogType type) {
    DateTime now = DateTime.now();
    int logTime = now.millisecondsSinceEpoch;
    String logTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    UserModel user = UserModel.shareInstance;
    PlatformUtils platformUtils = PlatformUtils.instance;
    return YlzLogData(
        logTime: logTime,
        logTimeFormat: logTimeFormat,
        userId: user.userId,
        mobile: user.telPhone,
        appVersion: platformUtils.appVersion,
        buildNumber: platformUtils.buildNum,
        dfp: platformUtils.deviceId,
        systemVersion: platformUtils.systemVersion,
        brand: platformUtils.brand,
        deviceName: platformUtils.deviceName,
        fingerprint: platformUtils.androidDeviceInfo.fingerprint,
        platform: platformUtils.platform,
        content: logContent,
        source: source.strValue,
        contentType: type.strValue);
  }
}
