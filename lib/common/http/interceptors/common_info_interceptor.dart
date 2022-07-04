import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dragoma/application.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:dragoma/utils/database/ylz_consignor_db.dart';
import 'package:dragoma/utils/location/location_dao.dart';
import 'package:dragoma/utils/platform_utils.dart';
import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';

class CommonInfoInterceptor extends Interceptor {
  late LocationDao locationDao;
  AMapLocationData? latestLocation;
  ConnectivityDetail? networkInfo;

  static final CommonInfoInterceptor _instance =
      CommonInfoInterceptor._internal();

  CommonInfoInterceptor._internal() {
    this.subscriptLocationInfo();
    this.subscriptNetworkStatus();
  }

  factory CommonInfoInterceptor() => _instance;

  static CommonInfoInterceptor get instance => _instance;

  bool get isValidLocation =>
      this.latestLocation != null &&
      this.latestLocation!.latitude.isNotTextEmpty &&
      this.latestLocation!.longitude.isNotTextEmpty;

  void subscriptLocationInfo() {
// 监听定位信息更新
    try {
      locationDao = LocationDao(Application.driverDB);
      locationDao.getLocationRecords().listen((records) {
        if (!records.isEmptyNullList) {
          latestLocation = records.last;
        }
      });
    } catch (e) {
      latestLocation = null;
    }
  }

  void subscriptNetworkStatus() {
    final Connectivity _connectivity = Connectivity();
    // 首次进入先获取当前网络状态
    _connectivity.checkConnectivityInfo().then((result) async {
      this.networkInfo = result;
    });
//    // 监听网络状态变化
    _connectivity.onConnectivityInfoChanged
        ?.listen((ConnectivityDetail result) async {
      this.networkInfo = result;
    });
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.connectTimeout = 1000 * 120;
    options.receiveTimeout = 1000 * 120;
    PlatformUtils platformUtils = PlatformUtils.instance;
    var customHeader = {};
    customHeader['_appVersion_'] = platformUtils.appVersion;
    customHeader['_platform_'] = Platform.operatingSystem;
    customHeader['_buildNumber_'] = platformUtils.buildNum;
    customHeader['_packageName_'] = platformUtils.packageInfo.packageName;
    customHeader['_dfp_'] = platformUtils.deviceId;
    customHeader['_systemVersion_'] = platformUtils.systemVersion;
    customHeader['_brand_'] = platformUtils.brand;
    customHeader['_deviceName_'] = platformUtils.deviceName;
    customHeader['_fingerprint_'] =
        platformUtils.androidDeviceInfo?.fingerprint ?? '';
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    customHeader['_t_'] = timestamp;
    if (this.isValidLocation) {
      customHeader['_locationTime_'] = this.latestLocation!.locationTime;
      customHeader['_latitude_'] = this.latestLocation!.latitude;
      customHeader['_longitude_'] = this.latestLocation!.longitude;
    }
    if (this.networkInfo == null) {
      customHeader['_networkType_'] = 'UNKNOWN';
    } else {
      if (this.networkInfo!.type == NetworkType.wifi) {
        customHeader['_networkType_'] = NetworkType.wifi.name;
        customHeader['_wifiBSSID_'] = this.networkInfo!.wifiBSSID ?? '';
        customHeader['_wifiName_'] = this.networkInfo!.wifiName ?? '';
      } else if (this.networkInfo!.type == NetworkType.mobile) {
        customHeader['_networkType_'] = this.networkInfo!.subtype.name;
        customHeader['_carrier_'] = this.networkInfo!.provider.strValue;
      } else {
        customHeader['_networkType_'] = 'NONE';
      }
    }
    customHeader['_phone_'] = UserModel.shareInstance.telPhone;
    customHeader["_id_"] = UserModel.shareInstance.userId;
    customHeader.removeWhere((key, value) => value == null);
    options.headers.addAll(customHeader
        .map((key, value) => MapEntry(key, Uri.encodeQueryComponent(value))));
    if (options.extra['noSession'] != true) {
      options.headers['token'] = UserModel.shareInstance.token;
      options.headers["Authorization"] =
          "Bearer ${UserModel.shareInstance.token}";
    }
    super.onRequest(options, handler);
  }
}
