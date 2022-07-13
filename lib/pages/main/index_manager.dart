import 'dart:async';

///
/// 主页tab栏管理类
const int defaultIndex = 2;

class MainTabBarManager {
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
