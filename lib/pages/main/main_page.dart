import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:dragoma/pages/main/controller/main_controller.dart';
import 'package:dragoma/utils/toast_utils.dart';
import 'package:dragoma/widgets/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// 主页面入口
class MainPage extends GetView<MainController> {
  Future<bool> _onWillPop() {
    //计算两次时间间隔
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - controller.last > 2000) {
      controller.last = DateTime.now().millisecondsSinceEpoch;
      YLZToastUtils.showToast('再次点击返回退出应用');
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: controller.pageController,
              children: controller.tabBodies,
              onPageChanged: _onPageChanged,
              // physics: NeverScrollableScrollPhysics(), // 禁止滑动
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0) +
                  EdgeInsets.only(bottom: 30),
              child: Obx(() => _buildFloatingBar()),
            ),
          ],
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    controller.changeCurrentIndex(index);
  }

  Widget _buildFloatingBar() {
    return CustomNavigationBar(
      strokeColor: Colors.transparent,
      unSelectedColor: Colors.grey[600],
      backgroundColor: Colors.white,
      borderRadius: Radius.circular(30.0),
      items: _buildNavigationBarItems(),
      currentIndex: controller.currentIndex,
      onTap: (index) {
        controller.changeCurrentIndex(index);
        controller.pageController.jumpToPage(index);
      },
      isFloating: true,
    );
  }

  List<CustomNavigationBarItem> _buildNavigationBarItems() {
    return controller.tabLabels.map((label) {
      int index = controller.tabLabels.indexOf(label);
      return CustomNavigationBarItem(
        icon: ImageLoader(controller.tabIcons[index][0], width: 24),
        selectedIcon: ImageLoader(controller.tabIcons[index][1], width: 24),
        title: Text(label),
      );
    }).toList();
  }
}
