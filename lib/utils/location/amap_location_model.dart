import 'dart:async';
import 'dart:math';

import 'package:dragoma/application.dart';
import 'package:dragoma/utils/database/ylz_consignor_db.dart';
import 'package:dragoma/utils/location/amap_location_entity.dart';
import 'package:dragoma/utils/location/location_dao.dart';
import 'package:dragoma/utils/log/ylz_log.dart';
import 'package:dragoma/utils/log/ylz_log_util.dart';
import 'package:dragoma/utils/platform_utils.dart';
import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';
import 'package:nh_flutter_native_channel/nh_flutter_native_channel.dart';

typedef void LocationUtilsOnResult(AMapLocationEntity locEntity);

const int MillisecondsOfDay =
    24 * 60 * 60 * 1000; // Android端默认定位更新间隔时间：避免重复定位(通过timer控制定位间隔)
const double DefaultDistanceFilter = -1; // iOS端默认定位更新间隔距离：避免重复定位(通过timer控制定位间隔)

const int DefaultExpireDays = 3; // 定位数据存储有效时长默认为 3d

/// 定位精度权限：iOS14新增模糊定位权限，需要进行区分
enum LocationAccuracy { FullAccuracy, ReducedAccuracy }

LocationAccuracy decodeLocationAccuracy(int accuracyValue) {
  try {
    return LocationAccuracy.values[accuracyValue];
  } catch (e) {
    return LocationAccuracy.FullAccuracy;
  }
}

///
/// 定位模块功能：
/// a. 单次定位
///    *** 定位表数据未删除
///
class LocationUtils {
  static final LocationUtils _instance = LocationUtils._internal();

  static final String tag = 'LocationUtils';

  LocationUtils._internal() {
    _locationDao = LocationDao(Application.driverDB);
    _locationDao.clearExpireLocations(DefaultExpireDays);
  }

  factory LocationUtils() => _instance;

  static LocationUtils get shared => _instance;

  late LocationDao _locationDao;

  void setup() {
  }

  ///
  /// 获取最近的一条定位数据
  Future<AMapLocationData?> getLatestRecords() async {
    return await _locationDao.getLatestRecord();
  }

  ///
  /// 定位信息*唯一*收口记录方法
  void _recordLocation(AMapLocationData? data) {
    bool isValid = isValidLocationData(data);
    if (isValid) {
      /// 定位数据库表插入
      _locationDao.insertRecord(data!);
    }

    /// 日志记录
    String _locationLog = isValid
        ? '${data!.callbackTime} ==> (${data.longitude}, ${data.latitude}) ==> ${data.address}'
        : '==本次定位失败==';
    YLZLogUtil.doRecord('定位信息更新:$_locationLog',
        print: false, type: YLZLogType.plainText, source: YLZLogSource.debug);
  }

  ///
  /// 判断是否是一条有效的定位数据
  bool isValidLocationData(AMapLocationData? data) {
    if (null == data) return false;
    if (data.latitude.isTextEmpty || data.longitude.isTextEmpty) return false;
    if (data.latitude == '0.0' || data.longitude == '0.0') return false;
    return true;
  }
}

extension Distance on LocationUtils {
  ///
  /// 计算两点之间的距离，单位：米
  num computeDistanceBetween(num fromLatitude, num fromLongitude,
          num toLatitude, num toLongitude) =>
      _computeAngleBetween(
          fromLatitude, fromLongitude, toLatitude, toLongitude) *
      6378137;

  num _computeAngleBetween(num fromLatitude, num fromLongitude, num toLatitude,
          num toLongitude) =>
      _distanceRadians(_toRadians(fromLatitude), _toRadians(fromLongitude),
          _toRadians(toLatitude), _toRadians(toLongitude));

  num _distanceRadians(num lat1, num lng1, num lat2, num lng2) =>
      _arcHav(havDistance(lat1, lat2, lng1 - lng2));

  num havDistance(num lat1, num lat2, num dLng) =>
      _hav(lat1 - lat2) + _hav(dLng) * cos(lat1) * cos(lat2);

  num _arcHav(num x) => 2 * asin(sqrt(x));

  num _toRadians(num degrees) => degrees / 180.0 * pi;

  num _hav(num x) => sin(x * 0.5) * sin(x * 0.5);
}

extension Accuracy on LocationUtils {
  Future<LocationAccuracy> get locationAccuracy async {
    if (Platform.isIOS) {
      int accuracy = await NhFlutterNativeChannel.caller
          .callNative(moduleName: 'LocationUtils', method: 'locationAccuracy');
      return decodeLocationAccuracy(accuracy);
    }
    return LocationAccuracy.FullAccuracy;
  }
}
