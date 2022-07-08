import 'dart:async';

///
/// 主页tab栏管理类
const int defaultIndex = MainTabBarManager.TAB_INDEX_THREE;

class MainTabBarManager {
  static const int TAB_INDEX_ONE = 0;
  static const int TAB_INDEX_TWO = 1;
  static const int TAB_INDEX_THREE = 2;

  static final MainTabBarManager _instance = MainTabBarManager._();

  factory MainTabBarManager() => MainTabBarManager._instance;

  MainTabBarManager._();

  // ignore: close_sinks
  static StreamController<int> streamController = StreamController.broadcast();

  //当前index
  int currentIndex = defaultIndex;

  //更新
  void updateIndex(int num) {
    if (currentIndex != num) {
      currentIndex = num;
      streamController.sink.add(num);
    }
  }
}
