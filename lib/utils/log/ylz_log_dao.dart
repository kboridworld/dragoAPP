import 'dart:async';

import 'package:moor/moor.dart';
import 'package:dragoma/utils/database/ylz_consignor_db.dart';
import 'package:dragoma/utils/log/ylz_log.dart';

part 'ylz_log_dao.g.dart';

@UseDao(tables: [YlzLog])
class YLZLogDao extends DatabaseAccessor<YLZConsignorDB> with _$YLZLogDaoMixin {
  YLZLogDao(YLZConsignorDB attachedDatabase) : super(attachedDatabase);

  Future<int> count() {
    Completer<int> completer = Completer();
    customSelect('select COUNT(*) as count from ylz_log').get().then((result) {
      if (result.length == 0) {
        completer.complete(0);
      } else {
        QueryRow row = result[0];
        completer.complete(row.data['count'] ?? 0);
      }
    });
    return completer.future;
  }

  Stream<List<YlzLogData>> getLogRecords() {
    return select(ylzLog).watch();
  }

  Future<List<YlzLogData>> getRecentRecords() {
    return (select(ylzLog)
          ..orderBy([
            (u) => OrderingTerm(expression: u.logTime, mode: OrderingMode.desc)
          ]))
        .get();
  }

  Future<int> deleteFirstRecord() {
    Completer<int> completer = Completer();
    customUpdate(
            'delete from ylz_log where rowid in (select rowid from ylz_log limit 1)',
            updates: {ylzLog},
            updateKind: UpdateKind.delete)
        .then((result) {
      completer.complete(result);
    });
    return completer.future;
  }

  Future<int> clearLogRecords() {
    return delete(ylzLog).go();
  }

  Future<int> insertRecord(YlzLogData entity) {
    return into(ylzLog).insert(entity);
  }
}
