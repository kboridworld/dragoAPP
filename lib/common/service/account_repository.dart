import 'package:dio/dio.dart';
import 'package:nh_flutter_network/network/client/nh_http_request.dart';
import 'package:dragoma/common/http/host/constants_host.dart';
import 'package:dragoma/pages/login/model/user_info.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:dragoma/utils/platform_utils.dart';

class AccountRepository {
  ///登录
  static Future login(String phone, String password) async {
    return {'token':'test'};
    var response = await NHRequest.post(Host.SSO, '/login_by_password',
        params: {
          'userName': phone,
          'password': password,
          'clientCode': PlatformUtils.instance.clientCode,
          'fingerprint': PlatformUtils.instance.deviceId,
          'version': PlatformUtils.instance.appVersion,
          'versionCode': PlatformUtils.instance.appVersionInteger,
          'device': PlatformUtils.instance.deviceName
        },
        noSession: true);

    return response.data['data'];
  }

  ///验证码登录
  static Future loginByCode(String phone, String code) async {
    return {'token':'test'};
    var response = await NHRequest.post(Host.SSO, '/login_by_mobile',
        params: {
          'mobile': phone,
          'smsCode': code,
          'clientCode': PlatformUtils.instance.clientCode,
          'fingerprint': PlatformUtils.instance.deviceId,
          'version': PlatformUtils.instance.appVersion,
          'versionCode': PlatformUtils.instance.appVersionInteger,
          'device': PlatformUtils.instance.deviceName
        },
        noSession: true);

    return response.data['data'];
  }

  /// 获取登录时的验证码
  static Future<void> getLoginAuthCode(String phone) async {
    await NHRequest.post(Host.SSO, "/login/sms_code/send", params: {
      "mobile": phone,
      "smsType": 'CUSTOMER_ACCOUNT_LOGIN',
      'clientCode': PlatformUtils.instance.clientCode,
    });
    return null;
  }

  /// 获取注册时的验证码
  static Future getRegisterAuthCode(String phone) async {
    await NHRequest.post(
        Host.BfsUser, "/bfs-user/customer_account/send_sms_captcha",
        params: {
          "mobile": phone,
          "smsType": 'CUSTOMER_ACCOUNT_REGISTER',
          'needPic': false,
        });
    return null;
  }

  /// 货主账号注册（只注册账号，不关联货主）
  static Future registerAccounts(String phone, String pwd, String code) async {
    var response = await NHRequest.post(
        Host.BfsUser, "/bfs-user/customer_account/register",
        params: {
          "mobile": phone,
          'password': pwd,
          "smsCaptcha": code,
          'channel': 'APP_REGISTER',
        });
    return response;
  }

  ///修改密码
  static Future<void> modifyPassword(String accountId, String oldPassword,
      String newPassword, String confirmedNewPassword) async {
    await NHRequest.post(
        Host.BfsUser, '/bfs-user/customer_account/password/modify',
        params: {
          'accountId': accountId,
          "oldPassword": oldPassword,
          "newPassword": newPassword,
          "confirmedNewPassword": confirmedNewPassword,
        });
    return null;
  }

  ///发送联系人验证码
  static Future<void> getCompanyAuthCode(String phone) async {
    await NHRequest.post(Host.BfsUser, "/customer/apply/send_msg", params: {
      "mobile": phone,
      // "smsType": 'CUSTOMER_ACCOUNT_LOGIN',
      // 'clientCode': PlatformUtils.instance.clientCode,
    });
    return null;
  }

  ///图片上传
  ///获取临时图片地址，地址有效期默认为10分钟，含有隐私信息的图片优先使用这个接口上传
  ///上报给后端的临时图片地址，需要后端转换成永久有效地址
  static Future<String> uploadImage(String imagePath) async {
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromFileSync(
        imagePath,
      ),
      'fileExtension': 'png',
    });

    var res =
        await NHRequest.post(Host.BfsUser, "/bfs_oss/upload", params: formData);
    List data = res.data['data'];
    if (data is List)
      return data.first['url'];
    else
      return res.data['data']['url'];
  }
}
