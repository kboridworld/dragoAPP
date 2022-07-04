import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';

extension StringUtils on String {
  ///
  /// 隐藏手机号中间4位
  String hidePhoneNum(
      {int start = 3, int end = 7, String replacement = '****'}) {
    if (this.isEmpty) return '';
    if (this.length < 7) return this;
    return this.replaceRange(start, end, replacement);
  }

  ///
  /// 隐藏身份证号码中间几位，只展示首尾4位
  String hideIDCardNumber({String replacement = '**********'}) {
    if (this.isTextEmpty) return '';
    if (this.length <= 8) return this;
    return this.replaceRange(4, this.length - 4, replacement);
  }

  /// 强换行
  String get breakWord => this.isTextEmpty
      ? this
      : runes
          .map((e) => String.fromCharCode(e))
          .reduce((value, element) => value + element + '\u200B');
}
