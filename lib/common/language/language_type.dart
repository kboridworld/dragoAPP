import 'dart:ui';

enum LanguageType {
  DEFAULT,
  CHINA,
  ENGLISH,
  CHINA_TW,
}

extension LanguageTypeExt on LanguageType {
  String get label {
    switch (this) {
      case LanguageType.DEFAULT:
        return '跟随系统';
      case LanguageType.CHINA:
        return '简体中文';
      case LanguageType.ENGLISH:
        return '英文';
      case LanguageType.CHINA_TW:
        return '繁体中文';
    }
  }

  Locale get locale {
    switch (this) {
      case LanguageType.DEFAULT:
        return window.locale;
      case LanguageType.CHINA:
        return Locale('zh', 'CN');
      case LanguageType.ENGLISH:
        return Locale('en', 'US');
      case LanguageType.CHINA_TW:
        return Locale('zh', 'TW');
    }
  }
}

int indexFromEnum<T>(List<T> values, T value, T defValue) {
  var index = values.indexOf(value);
  if (index == -1) return values.indexOf(defValue);
  return index;
}
