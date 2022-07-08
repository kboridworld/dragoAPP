import 'package:dragoma/application.dart';
import 'package:dragoma/pages/base/wrap_bi_controller.dart';
import 'package:dragoma/pages/main/index_manager.dart';
import 'package:dragoma/pages/main/tab/four_page.dart';
import 'package:dragoma/pages/main/tab/one_page.dart';
import 'package:dragoma/pages/main/tab/three_page.dart';
import 'package:dragoma/pages/main/tab/two_page.dart';
import 'package:dragoma/utils/dev_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends WrapBIController {
  var _currentIndex = defaultIndex.obs;

  int get currentIndex => _currentIndex.value;

  var _last = 0.obs;

  int get last => _last.value;

  set last(int value) => _last.value = value;

  late PageController pageController;

  final List tabIcons = [
    ['tab/icon_tab_bar_send_normal', 'tab/icon_tab_bar_send_select'],
    ['tab/icon_tab_bar_order_normal', 'tab/icon_tab_bar_order_select'],
    ['tab/icon_tab_bar_my_normal', 'tab/icon_tab_bar_my_select'],
    ['tab/icon_tab_bar_my_normal', 'tab/icon_tab_bar_my_select'],
  ];
  final List tabLabels = ['首页', '订单', '我的', '页面4'];
  late final List<Widget> tabBodies;

  @override
  void onInit() {
    pageController = PageController(initialPage: _currentIndex.value);
    tabBodies = [OnePage(), TwoPage(), ThreePage(), FourPage()];
    super.onInit();
  }

  @override
  void onReady() {
    if (needDevelopTool) {
      DevUtils.shared.setup(Get.overlayContext);
    }
    super.onReady();
  }

  void changeCurrentIndex(int index) {
    _currentIndex.value = index;
    MainTabBarManager().updateIndex(index);
  }
}
