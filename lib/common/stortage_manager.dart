import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static late SharedPreferences sharedPre;

  static init() async {
    // async 异步操作
    sharedPre = await SharedPreferences.getInstance();
  }
}
