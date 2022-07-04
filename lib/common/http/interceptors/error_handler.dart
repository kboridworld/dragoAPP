class ErrorHandler {
  static handler(String? code, message) {
    switch (code) {
      case CommonErrorCode.tokenExpired:
      case CommonErrorCode.sessionExpired:
      case CommonErrorCode.sessionNotExist:
        throw UnAuthorizedException();
      default:
        {
          if (code?.contains(CommonErrorCode.tokenExpired) ?? false) {
            throw UnAuthorizedException();
          }
          throw UnSuccessException(message, code: code);
        }
    }
  }
}

class CommonErrorCode {
  // 以下错误码能尝试重新登录
  static const String tokenExpired = "-1000";
  static const String sessionExpired = '4000100801';
  static const String sessionNotSupport = '4000100803';
  static const String sessionNotExist = '4000100804';

  // 以下错误码不能尝试重新登录，需要用户手动登录
  static const String userKickOut = '4000100802';
  static const String refreshTokenInvalid = '4000100805';

  static const String loginByMobileNotExist = '4000100907'; // 一键登录手机号码不存在
}

// token 过期需要重新登录
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}

//非正常 -未知异常
class UnSuccessException implements Exception {
  String? msg;
  String? code;

  UnSuccessException(this.msg, {this.code});

  @override
  String toString() => "UnSuccessException:$msg";
}
