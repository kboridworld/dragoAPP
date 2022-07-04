import 'dart:io';

import 'package:dragoma/common/const/constant.dart';
import 'package:dragoma/common/http/interceptors/common_info_interceptor.dart';
import 'package:dragoma/common/route/app_routes.dart';
import 'package:dragoma/common/stortage_manager.dart';
import 'package:dragoma/pages/base/wrap_bi_controller.dart';
import 'package:dragoma/utils/platform_utils.dart';
import 'package:dragoma/widgets/protocol_dialog.dart';
import 'package:get/get.dart';
import 'package:nh_flutter_native_channel/nh_flutter_native_channel.dart';

class GuideController extends WrapBIController {
  bool _isShowedProtocol = false;

  @override
  void onInit() {
    _isShowedProtocol =
        StorageManager.sharedPre.getBool(Constant.KEY_SHOWED_PROTOCOL_DIALOG) ??
            false;
    super.onInit();
  }

  @override
  void didAppear({bool first = false}) {
    if (first) {
      if (!_isShowedProtocol) {
        ProtocolDialog.show(
            positiveCallback: () {
              StorageManager.sharedPre
                  .setBool(Constant.KEY_SHOWED_PROTOCOL_DIALOG, true);
              _goOn();
            },
            negativeCallback: () => exit(0));
      } else {
        _goOn();
      }
    }
    super.didAppear(first: first);
  }

  _goOn() async {
    await PlatformUtils.instance.setup();
    CommonInfoInterceptor.instance.subscriptLocationInfo();
    CommonInfoInterceptor.instance.subscriptNetworkStatus();
    if (Platform.isAndroid)
      NhFlutterNativeChannel.caller
          .callNative(moduleName: 'AgreedInit', method: 'agreedInit');
    dismiss();
  }

  dismiss() {
    Get.offNamed(AppRoutes.mainPage);
  }
}
