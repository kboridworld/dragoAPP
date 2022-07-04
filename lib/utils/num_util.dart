import 'package:decimal/decimal.dart';
import 'package:lib_ylz_utils_package/extension/text_utils.dart';

enum DecimalType {
  DecimalTypeAmount, //钱-保留4位小数
  DecimalTypeKG, //kg-保留三位小数
  DecimalTypeTon, //吨-保留三位小数
  DecimalTypeCube, //方-保留三位小数
  DecimalTypePiece, //件-保留三位小数
  DecimalTypeKM, //公里-保留三位小数
  DecimalTypePercent, //百分比-保留2位小数
}

class NumUtil {
  /// The parameter [fractionDigits] must be an integer satisfying: `0 <= fractionDigits <= 20`.
  static num? getNumByValueStr(String valueStr, {int? fractionDigits}) {
    double? value = double.tryParse(valueStr);
    return fractionDigits == null
        ? value
        : getNumByValueDouble(value, fractionDigits);
  }

  /// The parameter [fractionDigits] must be an integer satisfying: `0 <= fractionDigits <= 20`.
  static num? getNumByValueDouble(double? value, int fractionDigits) {
    if (value == null) return null;
    String valueStr = value.toStringAsFixed(fractionDigits);
    return fractionDigits == 0
        ? int.tryParse(valueStr)
        : double.tryParse(valueStr);
  }

  /// get int by value str.
  static int getIntByValueStr(String valueStr, {int defValue = 0}) {
    return int.tryParse(valueStr) ?? defValue;
  }

  /// get double by value str.
  static double getDoubleByValueStr(String valueStr, {double defValue = 0}) {
    return double.tryParse(valueStr) ?? defValue;
  }

  ///isZero
  static bool isZero(num? value) {
    return value == null || value == 0;
  }

  /// 加 (精确相加,防止精度丢失).
  /// add (without loosing precision).
  static double add(num a, num b) {
    return addDec(a, b).toDouble();
  }

  /// 减 (精确相减,防止精度丢失).
  /// subtract (without loosing precision).
  static double subtract(num a, num b) {
    return subtractDec(a, b).toDouble();
  }

  /// 乘 (精确相乘,防止精度丢失).
  /// multiply (without loosing precision).
  static double multiply(num a, num b) {
    return multiplyDec(a, b).toDouble();
  }

  /// 除 (精确相除,防止精度丢失).
  /// divide (without loosing precision).
  static double divide(num a, num b) {
    return divideDec(a, b).toDouble();
  }

  /// 加 (精确相加,防止精度丢失).
  /// add (without loosing precision).
  static Decimal addDec(num a, num b) {
    return addDecStr(a.toString(), b.toString());
  }

  /// 减 (精确相减,防止精度丢失).
  /// subtract (without loosing precision).
  static Decimal subtractDec(num a, num b) {
    return subtractDecStr(a.toString(), b.toString());
  }

  /// 乘 (精确相乘,防止精度丢失).
  /// multiply (without loosing precision).
  static Decimal multiplyDec(num a, num b) {
    return multiplyDecStr(a.toString(), b.toString());
  }

  /// 除 (精确相除,防止精度丢失).
  /// divide (without loosing precision).
  static Decimal divideDec(num a, num b) {
    return divideDecStr(a.toString(), b.toString());
  }

  /// 余数
  static Decimal remainder(num a, num b) {
    return remainderDecStr(a.toString(), b.toString());
  }

  /// Relational less than operator.
  static bool lessThan(num a, num b) {
    return lessThanDecStr(a.toString(), b.toString());
  }

  /// Relational less than or equal operator.
  static bool thanOrEqual(num a, num b) {
    return thanOrEqualDecStr(a.toString(), b.toString());
  }

  /// Relational greater than operator.
  static bool greaterThan(num a, num b) {
    return greaterThanDecStr(a.toString(), b.toString());
  }

  /// Relational greater than or equal operator.
  static bool greaterOrEqual(num a, num b) {
    return greaterOrEqualDecStr(a.toString(), b.toString());
  }

  /// 加
  static Decimal addDecStr(String a, String b) {
    return Decimal.parse(a) + Decimal.parse(b);
  }

  /// 减
  static Decimal subtractDecStr(String a, String b) {
    return Decimal.parse(a) - Decimal.parse(b);
  }

  /// 乘
  static Decimal multiplyDecStr(String a, String b) {
    return Decimal.parse(a) * Decimal.parse(b);
  }

  /// 除
  static Decimal divideDecStr(String a, String b) {
    return Decimal.parse(a) / Decimal.parse(b);
  }

  /// 余数
  static Decimal remainderDecStr(String a, String b) {
    return Decimal.parse(a) % Decimal.parse(b);
  }

  /// Relational less than operator.
  static bool lessThanDecStr(String a, String b) {
    return Decimal.parse(a) < Decimal.parse(b);
  }

  /// Relational less than or equal operator.
  static bool thanOrEqualDecStr(String a, String b) {
    return Decimal.parse(a) <= Decimal.parse(b);
  }

  /// Relational greater than operator.
  static bool greaterThanDecStr(String a, String b) {
    return Decimal.parse(a) > Decimal.parse(b);
  }

  /// Relational greater than or equal operator.
  static bool greaterOrEqualDecStr(String a, String b) {
    return Decimal.parse(a) >= Decimal.parse(b);
  }

  ///当小数点后为0时不显示小数点和后面的0
  ///当小数点后有数值时正常显示

  static String doubleToDigitStr(double a, {int n = 2}) {
    num? res = getNumByValueDouble(a, n);
    return '${res.toDecimalOne()}';
  }

  static String doubleMultiplyStr(double a, double b) {
    double s = multiply(a, b);
    return doubleToDigitStr(s);
  }

  static String doubleTruncate(num? x) {
    try {
      if (x == null) return "";
      int i = x.truncate();
      if (x == i) {
        return i.toString();
      }
      return x.toString();
    } catch (e) {
      return "";
    }
  }

  /// 返回带单位不同类型的小数位
  static String numNormalStr(var k, {DecimalType? type}) {
    if (k == null || k == 0) {
      return '0';
    } else {
      int number = type == DecimalType.DecimalTypeAmount
          ? 4
          : type == DecimalType.DecimalTypePercent
              ? 2
              : 3;

      num? res;
      if (k is String) {
        res = getNumByValueStr(k, fractionDigits: number);
      } else if (k is double) {
        res = getNumByValueDouble(k, number);
      } else {
        res = getNumByValueStr(k.toString());
      }
      return res != null ? '${res.toDecimalOne()}' : '0';
    }
  }
}

extension NumExt on num? {
  Decimal toDecimal() {
    try {
      if (this == null || this!.isNaN) return Decimal.zero;
      return Decimal.parse(this.toString());
    } catch (_) {
      return Decimal.zero;
    }
  }

  Decimal toDecimalOne() {
    if (this == null || this!.isNaN || this == 0) return Decimal.zero;
    return Decimal.parse(this.toString());
  }
}

extension DecimalExt on Decimal {
  num? toNumFractionDigits({int fractionDigits = 3}) {
    return NumUtil.getNumByValueDouble(this.toDouble(), fractionDigits);
  }

  String toStringFractionDigits({int fractionDigits = 3}) {
    return NumUtil.doubleTruncate(
        this.toNumFractionDigits(fractionDigits: fractionDigits));
  }
}

extension StringExt on String {
  Decimal toDecimal() {
    if (this.isTextEmpty) return Decimal.zero;
    return Decimal.parse(this);
  }
}
