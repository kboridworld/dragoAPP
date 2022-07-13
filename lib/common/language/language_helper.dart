import 'dart:ui';

import 'package:dragoma/application.dart';
import 'package:dragoma/common/const/constant.dart';
import 'package:dragoma/common/language/language_type.dart';
import 'package:dragoma/common/stortage_manager.dart';
import 'package:dragoma/event/change_language_event.dart';
import 'package:get/get.dart';

class LanguageHelper {
  static final LanguageHelper _instance = LanguageHelper._internal();

  factory LanguageHelper() => _instance;

  static LanguageHelper get shared => _instance;

  late LanguageType _type;
  late int _currentIndex;

  LanguageType get type => _type;

  LanguageHelper._internal() {
    _currentIndex = StorageManager.sharedPre.getInt(Constant.KEY_Language) ??
        LanguageType.DEFAULT.index;
    _type = LanguageType.values[_currentIndex];
  }

  ///
  /// 切换语言
  changeLanguage(LanguageType type) async {
    if (_type == type) return;
    _type = type;
    _currentIndex =
        indexFromEnum(LanguageType.values, _type, LanguageType.DEFAULT);
    await Get.updateLocale(type.locale).then((value) {
      StorageManager.sharedPre.setInt(Constant.KEY_Language, _currentIndex);
      Application.eventBus.fire(ChangeLanguageEvent());
    });
  }

  ///
  /// 列出支持的语言
  List<LanguageType> listSupportLanguage() {
    return LanguageType.values;
  }

  ///App打开或者语言配置发生变化（在手机的设置里更改语言，app代码更改等）的时候会触发这个回调
  Locale? Function(Locale?, Iterable<Locale>)? get localeResolutionCallback =>
      (locale, locales) {};
}
