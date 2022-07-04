import 'dart:async';

import 'package:intl/intl.dart';
import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';
import 'package:moor/moor.dart';
import 'package:dragoma/utils/database/ylz_consignor_db.dart';
import 'package:dragoma/utils/location/amap_location.dart';

part 'location_dao.g.dart';

@UseDao(tables: [AMapLocation])
class LocationDao extends DatabaseAccessor<YLZConsignorDB>
    with _$LocationDaoMixin {
  LocationDao(YLZConsignorDB db) : super(db);

  Future<AMapLocationData?> getLatestRecord() {
    Completer<AMapLocationData?> completer = Completer();
    select(aMapLocation).get().then((records) {
      if (records.isEmptyList) {
        completer.complete(null);
      } else {
        completer.complete(records.last);
      }
    });
    return completer.future;
  }

  Stream<List<AMapLocationData>> getLocationRecords() {
    return select(aMapLocation).watch();
  }

  Future<int> clearLocations() {
    return delete(aMapLocation).go();
  }

  Future<int> clearExpireLocations(int defaultExpireDays) {
    DateTime now = DateTime.now();
    DateTime expireData = now.subtract(new Duration(days: defaultExpireDays));
    //2022-04-20 10:29:08
    String expireDataStr = DateFormat("yyyy-MM-dd HH:mm:ss").format(expireData);
    return (delete(aMapLocation)
      ..where((t) => t.callbackTime.isSmallerThanValue(expireDataStr)))
        .go();
  }

  Future<int> insertRecord(AMapLocationData entity) {
    return into(aMapLocation).insert(entity);
  }
}
