import 'dart:ui';

import 'package:dragoma/common/language/language_helper.dart';
import 'package:dragoma/common/language/language_type.dart';
import 'package:dragoma/common/language/messages/messages_zh_tw.dart';
import 'package:dragoma/common/language/messages/messages_en.dart';
import 'package:dragoma/common/language/messages/messages_zh.dart';
import 'package:get/get.dart';

class LanguageImpl extends Translations {
  static Locale? get locale => LanguageHelper.shared.type.locale;

  static List<Locale> get supportedLocales =>
      LanguageType.values.map((e) => e.locale).toList();

  static final fallbackLocale = LanguageType.DEFAULT.locale;

  @override
  Map<String, Map<String, String>> get keys => {
        ...MessagesEn.keys,
        ...MessagesZh.keys,
        ...MessagesZhTW.keys,
      };
}
