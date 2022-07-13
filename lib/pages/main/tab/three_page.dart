import 'package:dragoma/common/language/language_helper.dart';
import 'package:dragoma/common/language/language_type.dart';
import 'package:dragoma/common/language/messages/messages_const.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/pages/base/wrap_bi_controller.dart';
import 'package:dragoma/pages/login/login_router.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:dragoma/widgets/app_bar.dart';
import 'package:dragoma/widgets/comm_btn_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';

///
/// 页面3
class ThreePage extends GetView<ThreeTabController> {
  @override
  Widget build(BuildContext context) {
    RefreshString strings =
        RefreshLocalizations.of(context)?.currentLocalization ??
            EnRefreshString();
    return Scaffold(
      backgroundColor: ColorValues.background,
      appBar: CustomAppBar(
        title: MessagesConst.title_page_three.tr,
        bgColor: Colors.blue,
        isBack: true,
        actions: LanguageHelper.shared
            .listSupportLanguage()
            .map(
              (e) => AppBarAction(
                title: e.label,
                action: () {
                  controller.updateLocale(e);
                },
              ),
            )
            .toList(),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '我是大大大大大大, ${MessagesConst.hello.tr}',
                  style: TextStyles.textSize22,
                ),
              ),
              GetBuilder<UserModel>(
                init: UserModel.shareInstance,
                builder: (controller) {
                  return Text('token: ${controller.token}');
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommonBtnWidget.buttonWidget(
                  context,
                  MessagesConst.retry.tr,
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
                  MessagesConst.exit.tr,
                  () async {
                    await UserModel.shareInstance.logout();
                    Get.offAllNamed(LoginRouter.login);
                  },
                  icon: Icon(Icons.build),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommonBtnWidget.buttonWidget(
                    context, strings.canTwoLevelText ?? '', null),
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

  updateLocale(LanguageType type) {
    LanguageHelper.shared.changeLanguage(type);
  }
}
