import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';
import 'package:nh_flutter_network/nh_flutter_network.dart';
import 'package:dragoma/common/res/dimens.dart';
import 'package:dragoma/common/res/gaps.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/common/route/app_routes.dart';
import 'package:dragoma/widgets/app_bar.dart';
import 'package:dragoma/pages/system/controller/dev_setting_controller.dart';

///
/// 开发设置页面
class DevSettingPage extends GetView<DevSettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '开发服务配置',
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          child: Column(
            children: <Widget>[
              Material(
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('环境选择'),
                      Obx(() => Text(controller.getCuEvn().name))
                    ],
                  ),
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: AppEnv.values.length,
                        itemBuilder: (context, index) {
                          return Obx(() => RadioListTile(
                                value: AppEnv.values[index].index,
                                onChanged: (int? index) {
                                  controller.change(index);
                                },
                                groupValue: controller.index.value,
                                title: Text(AppEnv.values[index].name),
                              ));
                        })
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('代理设置'),
                    ),
                    Gaps.hLin,
                    TextField(
                      controller: controller.ipEditController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      buildCounter: (
                        BuildContext context, {
                        required int currentLength,
                        int? maxLength,
                        required bool isFocused,
                      }) {
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(width: 1)),
                        hintText: '请输入IP地址',
                        hintStyle:
                            TextStyle(color: Color(0xFFA1A7B3), fontSize: 15),
                      ),
                    ),
                    TextField(
                      controller: controller.portEditController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      buildCounter: (
                        BuildContext context, {
                        required int currentLength,
                        int? maxLength,
                        required bool isFocused,
                      }) {
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(width: 1)),
                        hintText: '请输入端口',
                        hintStyle:
                            TextStyle(color: Color(0xFFA1A7B3), fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: FButton(
                  height: Dimens.button_normal_height,
                  text: '设置',
                  alignment: Alignment.center,
                  style: TextStyle(
                    fontSize: Dimens.font_sp18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  shadowColor: Colors.grey[500]!,
                  shadowBlur: 10,
                  shadowOffset: Offset(3, 5),
                  gradient: ViewStyles.linear,
                  onPressed: () async {
                    ProgressHUD.showLoading(text: '正在切换');
                    await controller.savePoxyConfig().then((value) {
                      ProgressHUD.dismissAllHUD();
                      Get.until(
                          (route) => Get.currentRoute == AppRoutes.mainPage);
                    });
                  },
                  clickEffect: true,
                  corner: FCorner.all(48),
                ),
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 50),
                    child: FButton(
                      height: Dimens.button_normal_height,
                      text: controller.isWebServerRunning.isTrue
                          ? controller.webServerPath
                          : '点击开启浏览器日志查询',
                      alignment: Alignment.center,
                      style:
                          TextStyles.textSize18.copyWith(color: Colors.white),
                      shadowColor: Colors.grey[500]!,
                      shadowBlur: 10,
                      shadowOffset: Offset(3, 5),
                      gradient: LinearGradient(colors: [
                        Color(0xffF0C27B),
                        Color(0xff4B124B),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      onPressed: () {
                        controller.isWebServerRunning.isTrue
                            ? controller.stopWebServer()
                            : controller.startWebServer();
                      },
                      clickEffect: true,
                      corner: FCorner.all(48),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
