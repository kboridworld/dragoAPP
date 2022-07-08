import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/pages/base/wrap_bi_controller.dart';
import 'package:dragoma/widgets/app_bar.dart';
import 'package:dragoma/widgets/comm_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// 页面4
class FourPage extends GetView<FourTabController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorValues.background,
      appBar: CustomAppBar(
        title: 'FourPage',
      ),
      body: SafeArea(
        child: Center(
          child: Obx(
            () => CommonBtnWidget.buttonWidget(
              context,
              '${controller.count.value}',
              controller.inst,
            ),
          ),
        ),
      ),
    );
  }
}

class FourTabController extends WrapBIController {
  var count = 0.obs;

  void inst() {
    count.value++;
  }
}
