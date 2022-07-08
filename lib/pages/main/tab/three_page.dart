import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/pages/base/wrap_bi_controller.dart';
import 'package:dragoma/pages/login/login_router.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:dragoma/utils/toast_utils.dart';
import 'package:dragoma/widgets/app_bar.dart';
import 'package:dragoma/widgets/comm_btn_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// 页面3
class ThreePage extends GetView<ThreeTabController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorValues.background,
      appBar: CustomAppBar(
        title: 'ThreePage',
        actions: [
          AppBarAction(
            icon: Icon(Icons.logout),
            action: () {
              YLZToastUtils.showToast('click 1');
            },
          ),
          AppBarAction(
            title: '测试2',
            action: () {
              YLZToastUtils.showToast('click 2');
            },
          ),
          // AppBarAction(
          //   title: '测试3',
          //   icon: Icon(
          //     Icons.map,
          //     color: Theme.of(context).primaryColor,
          //   ),
          //   action: () {
          //     YLZToastUtils.showToast('click 2');
          //   },
          // )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '我是大大大大大大',
                  style: TextStyles.textSize22,
                ),
              ),
              Column(
                children: [
                  GetBuilder<UserModel>(
                    init: UserModel.shareInstance,
                    builder: (userModel) => Text('token: ${userModel.token}'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommonBtnWidget.buttonWidget(
                  context,
                  '重新登录',
                  () {
                    UserModel.shareInstance.relogin();
                  },
                  icon: Icon(Icons.build),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommonBtnWidget.buttonWidget(
                  context,
                  '退出登录',
                  () async {
                    await UserModel.shareInstance.logout();
                    Get.offAllNamed(LoginRouter.login);
                  },
                  icon: Icon(Icons.build),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommonBtnWidget.buttonWidget(context, '切换暗夜模式', () {
                  Get.changeTheme(
                      controller.isDark ? ThemeData.light() : ThemeData.dark());
                  controller.toggleLightMode();
                }, icon: Icon(Icons.build)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThreeTabController extends WrapBIController {
  var _isDark = false.obs;

  bool get isDark => _isDark.value;

  toggleLightMode() {
    _isDark.value = !_isDark.value;
  }
}
