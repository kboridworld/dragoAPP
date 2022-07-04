import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class DriverLoginInfo {
  bool? admin;
  String? clientCode;
  int? createTime;
  String? domain;
  int? id;
  String? refreshToken;
  String? tenantId;
  String? tenantName;
  String? token;
  String? userId;
  dynamic ext;

  DriverLoginInfo(
      this.admin,
      this.clientCode,
      this.createTime,
      this.domain,
      this.id,
      this.refreshToken,
      this.tenantId,
      this.tenantName,
      this.token,
      this.userId,
      this.ext);

  factory DriverLoginInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$DriverLoginInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DriverLoginInfoToJson(this);
}
