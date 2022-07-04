import 'package:flutter/material.dart';
import 'package:dragoma/application.dart';
import 'package:dragoma/common/res/dimens.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/widgets/image_loader.dart';
import 'package:dragoma/common/ylz_page.dart';
import 'package:dragoma/pages/main/index_manager.dart';
import 'package:dragoma/pages/main/tab/one_page.dart';
import 'package:dragoma/pages/main/tab/three_page.dart';
import 'package:dragoma/pages/main/tab/two_page.dart';
import 'package:dragoma/pages/system/viewModel/system_info_model.dart';
import 'package:dragoma/utils/dev_utils.dart';
import 'package:dragoma/utils/toast_utils.dart';

///
/// 主页面入口
class MainPage extends YLZPage {
  final String? index;

  MainPage({this.index});

  @override
  YLZState<YLZPage> createYLZState() => _MainPageState();
}

class _MainPageState extends YLZState<MainPage> with WidgetsBindingObserver {
  final List _tabIcons = [
    ['tab/icon_tab_bar_send_normal', 'tab/icon_tab_bar_send_select'],
    ['tab/icon_tab_bar_order_normal', 'tab/icon_tab_bar_order_select'],
    ['tab/icon_tab_bar_my_normal', 'tab/icon_tab_bar_my_select'],
  ];
  final List _tabLabels = ['首页', '订单', '我的'];
  final List<Widget> _tabBodies = [OnePage(), TwoPage(), ThreePage()];

  int _currentIndex = defaultIndex;
  SystemInfoModel? _systemInfoModel;

  @override
  void initState() {
    _systemInfoModel = SystemInfoModel(context);
    if (needDevelopTool) {
      DevUtils.shared.setup(context);
    }
    MainTabBarManager.streamController.stream.listen((data) {
      if (!mounted) return;
      setState(() {
        _currentIndex = data;
      });
    });
    super.initState();
  }

  @override
  void didAppear(bool firstLoad) {
    _systemInfoModel?.checkUpdate();
    super.didAppear(firstLoad);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _tabBodies,
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: _buildNavigationBarItems(),
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedFontSize: Dimens.font_sp12,
            unselectedFontSize: Dimens.font_sp12,
            selectedItemColor: ColorValues.primaryColor,
            onTap: (index) {
              MainTabBarManager().updateIndex(index);
            },
          ),
        ),
      ),
    );
  }

  int last = 0;

  Future<bool> _onWillPop() {
    //计算两次时间间隔
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - last > 2000) {
      last = DateTime.now().millisecondsSinceEpoch;
      YLZToastUtils.showToast('再次点击返回退出应用');
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  _buildNavigationBarItems() {
    return _tabLabels.map((label) {
      int index = _tabLabels.indexOf(label);
      return BottomNavigationBarItem(
        icon: ImageLoader(_tabIcons[index][0], width: 24),
        activeIcon: ImageLoader(_tabIcons[index][1], width: 24),
        label: label,
        tooltip: '',
      );
    }).toList();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
        Application.updateAppFrontStatus(true);
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        Application.updateAppFrontStatus(false);
        break;
      case AppLifecycleState.detached: // APP结束时调用
        break;
    }
  }
}
