class WarningInfo {
  bool? pass;//是否通过 true 通过，false 不通过
  bool? warning;//警告 true 需要预警，false 不需要
  num? proportion;//已使用额度占用总额度的百分比
  num? switchRatio;//卡控比例 默认1
  num? amount;//授信金额

  WarningInfo({this.pass, this.warning, this.proportion,this.switchRatio, this.amount});

  factory WarningInfo.fromJson(Map<String, dynamic> json) {
    return WarningInfo(
      pass: json['pass'],
      warning: json['warning'],
      proportion: json['proportion'],
      switchRatio: json['switchRatio'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'pass': pass,
    'warning': warning,
    'proportion': proportion,
    'switchRatio': switchRatio,
    'amount': amount,
  };
}
