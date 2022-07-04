// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverLoginInfo _$DriverLoginInfoFromJson(Map<String, dynamic> json) {
  return DriverLoginInfo(
    json['admin'],
    json['clientCode'],
    json['createTime'],
    json['domain'],
    json['id'],
    json['refreshToken'],
    json['tenantId'],
    json['tenantName'],
    json['token'],
    json['userId'],
    json['ext'],
  );
}

Map<String, dynamic> _$DriverLoginInfoToJson(DriverLoginInfo instance) =>
    <String, dynamic>{
      'admin': instance.admin,
      'clientCode': instance.clientCode,
      'createTime': instance.createTime,
      'domain': instance.domain,
      'id': instance.id,
      'refreshToken': instance.refreshToken,
      'tenantId': instance.tenantId,
      'tenantName': instance.tenantName,
      'token': instance.token,
      'userId': instance.userId,
      'ext': instance.ext,
    };
