import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:dragoma/utils/location/amap_location.dart';
import 'package:dragoma/utils/log/ylz_log.dart';

part 'ylz_consignor_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [AMapLocation, YlzLog])
class YLZConsignorDB extends _$YLZConsignorDB {
  YLZConsignorDB() : super(_openConnection());

  @override
  int get schemaVersion => 11;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from < 11) {
          try {
            await m.addColumn(aMapLocation, aMapLocation.errorCode);
            await m.addColumn(aMapLocation, aMapLocation.errorInfo);
          } catch (e) {
            print(e);
          }
        }
      });
}
