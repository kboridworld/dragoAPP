import 'package:dragoma/pages/base/wrap_bi_controller.dart';
import 'package:dragoma/pages/system/controller/update_controller.dart';
import 'package:dragoma/utils/platform_utils.dart';
import 'package:get/get.dart';

class SystemInfoController extends WrapBIController {
  String version = '';
  String buildNumber = '';
  String deviceName = '';
  String systemVersion = '';
  String deviceID = '';
  bool needUpdate = false;
  bool hasNotificationPermission = false;
  String fingerprint = '';
  String manufacturer = '';

  String get appDisplayVersion {
    return 'v$version($buildNumber)';
  }

  late UpdateController updateController;

  @override
  void onInit() {
    updateController = Get.find();
    _fetchSystemInfo();
    super.onInit();
  }

  Future<void> _fetchSystemInfo() async {
    PlatformUtils platformUtils = PlatformUtils.instance;
    version = platformUtils.appVersion;
    buildNumber = platformUtils.buildNum;
    deviceName = platformUtils.brand + " " + platformUtils.deviceName;
    systemVersion = '${platformUtils.systemVersion}';
    if (Platform.isAndroid) {
      systemVersion += '- ${platformUtils.androidDeviceInfo.hardware}';
      fingerprint = platformUtils.androidDeviceInfo.display ?? '';
    }
    deviceID = platformUtils.deviceId;
    manufacturer = platformUtils.manufacturer;
    needUpdate =
        updateController.upgradeViewModel.upgradeModel?.hasUpgrade ?? false;
    update();
  }
}
