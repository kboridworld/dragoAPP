import 'package:flutter/material.dart';
import 'package:lib_ylz_page_lifecycle/base/page_lifecycle_controller.dart';

///
/// bi lifecycle controller wrap
abstract class WrapBIController<T extends StatelessWidget>
    extends PageLifeCycleController {
  String get pageName => 'V-Page-${this.runtimeType.toString()}';

  var startTime = 0;

  @override
  void didAppear({bool first = false}) {
    debugPrint('-[WrapGetXController]---->${reportName()} didAppear');
    startTime = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  void didDisappear({bool causeByDialog = false}) {
    debugPrint('-[WrapGetXController]---->${reportName()} didDisappear');
    var duration = (DateTime.now().millisecondsSinceEpoch - startTime) ~/ 1000;
    print(
        '-[WrapGetXController]-PV事件---->${reportName()} --持续时间-->$duration 秒');
  }

  ///获取中文页面名称
  String reportName() {
    return pageName;
  }

  @override
  void onDestroy() {
    debugPrint('-[WrapGetXController]---->${reportName()} onDestroy');
  }

  @override
  void onClose() {
    debugPrint('-[WrapGetXController]---->${reportName()} onClose');
    super.onClose();
  }

  @override
  void onReady() {
    debugPrint('-[WrapGetXController]---->${reportName()} onReady');
    super.onReady();
  }

  @override
  void onInit() {
    debugPrint('-[WrapGetXController]---->${reportName()} onInit');
    super.onInit();
  }
}
