import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:moor/moor.dart';
import 'package:dragoma/utils/database/ylz_consignor_db.dart';

enum YLZLogSource { request, user, debug }
enum YLZLogType { jsonString, plainText }

extension YLZLogSourceExt on YLZLogSource {
  String get strValue => this.toString().split('.')[1];
}

YLZLogSource? yLZLogSourceFromString(String strValue) => YLZLogSource.values.firstWhereOrNull(
    (element) => element.toString().split('.')[1].toUpperCase() == strValue.toUpperCase());

extension YLZLogTypeExt on YLZLogType {
  String get strValue => this.toString().split('.')[1];
}

YLZLogType? yLZLogTypeFromString(String strValue) => YLZLogType.values.firstWhereOrNull(
    (element) => element.toString().split('.')[1].toUpperCase() == strValue.toUpperCase());

class YlzLog extends Table {
  IntColumn? get logTime => integer().nullable()();
  TextColumn? get logTimeFormat => text().nullable()();
  TextColumn? get userId => text().nullable()();
  TextColumn? get mobile => text().nullable()();
  TextColumn? get appVersion => text().nullable()();
  TextColumn? get buildNumber => text().nullable()();
  TextColumn? get platform => text().nullable()();
  TextColumn? get dfp => text().nullable()();
  TextColumn? get systemVersion => text().nullable()();
  TextColumn? get brand => text().nullable()();
  TextColumn? get deviceName => text().nullable()();
  TextColumn? get fingerprint => text().nullable()();
  TextColumn? get content => text().nullable()(); // 日志内容
  TextColumn? get source => text().nullable()(); // 日志来源：request、用户行为日志、debug日志
  TextColumn? get contentType => text().nullable()(); // 日志内容格式：jsonString、plainText

  @override
  Set<Column>? get primaryKey => {logTime as GeneratedColumn<int>};
}

extension YlzLogDataExt on YlzLogData {
  // 日志列表中的header显示内容
  String headerTitle() {
    if (this.source == YLZLogSource.request.strValue) {
      String path = this.requestContentDic()['path'] ?? '';
      return '【Request ${this.logTimeFormat}】 $path';
    } else if (this.source == YLZLogSource.debug.strValue ||
        this.source == YLZLogSource.user.strValue) {
      return '【Debug ${this.logTimeFormat}】 ${this.content!.substring(0, min(10, this.content!.length))}...';
    } else {
      return '【Default ${this.logTimeFormat}】';
    }
  }

  Map<String, dynamic> requestContentDic() {
    if (this.contentType == YLZLogType.jsonString.strValue && this.content!.length > 0) {
      try {
        return jsonDecode(this.content!) ?? {};
      } catch (_) {
        return {};
      }
    }
    return {};
  }

  String? logInfoForWebConsole() {
    if (this.isContentJsonView) {
      return '${this.logTimeFormat}(${this.logTime}) ====> ${this.content} \n';
    } else {
      return this.content;
    }
  }

  // 详细内容是否可以使用json来展示
  bool get isContentJsonView => this.contentType == YLZLogType.jsonString.strValue;
}
