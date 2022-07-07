import 'package:dragoma/pages/main/tab/one_page.dart';
import 'package:dragoma/pages/main/tab/three_page.dart';
import 'package:dragoma/pages/main/tab/two_page.dart';
import 'package:get/get.dart';

class MainRouter {
  static const String one = '/main/one';
  static const String two = '/main/two';
  static const String three = '/main/three';

  static List<GetPage> getPages = [
    GetPage(
      name: one,
      page: () => OnePage(),
    ),
    GetPage(
      name: two,
      page: () => TwoPage(),
    ),
    GetPage(
      name: three,
      page: () => ThreePage(),
    ),
  ];
}
