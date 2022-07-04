import 'package:dragoma/pages/guide/controller/guide_controller.dart';
import 'package:dragoma/widgets/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// 闪屏页
class GuideScreenPage extends GetView<GuideController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<GuideController>(builder: (controller) {
        return _defaultLauncher();
      }),
    );
  }

  ///
  /// 无广告时，默认显示的启动页
  _defaultLauncher() {
    return ImageLoader(
      'guide/bg_launcher',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
