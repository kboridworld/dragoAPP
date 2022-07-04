import 'package:dio/dio.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';
import 'package:dragoma/common/http/interceptors/error_handler.dart';
import 'package:dragoma/pages/login/login_helper.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:dragoma/utils/toast_utils.dart';

class ResponseInterceptor extends Interceptor {
  static bool isPushing2LoginPage = false;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    HttpResponse httpResponse = HttpResponse.fromJson(response.data);
    if (httpResponse.success) {
      bool noSession = response.requestOptions.extra['noSession'];
      print('${response.requestOptions.uri}, noSession = $noSession}');
      if (!noSession && isPushing2LoginPage) {
        isPushing2LoginPage = false;
      }
      super.onResponse(response, handler);
    } else {
      ErrorHandler.handler(httpResponse.code, httpResponse.msg);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    ProgressHUD.dismissAllHUD();
    if (err.error is UnAuthorizedException) {
      if (!isPushing2LoginPage) {
        isPushing2LoginPage = true;
        ProgressHUD.showToast("账号在其他手机登录，已被迫下线，如非本人操作请尽快修改密码",
            duration: Duration(seconds: 3), onDismiss: () {
          UserModel.shareInstance.cleanToken();
          LoginHelper.login();
        });
      }
    } else if (err.error is UnSuccessException) {
      if (err.requestOptions.extra["showToast"] != false) {
        YLZToastUtils.showToast(err.error.msg ?? "请联系管理员");
      }
    } else {
      if (err.requestOptions.extra["showToast"] != false) {
        var msg = '';
        if (err.response != null) {
          msg = '(${err.response?.statusCode})';
        } else if (err.error is FormatException) {
          var message = err.message;
          var source = (err.error as FormatException).source ?? '';
          msg = '($message) $source';
        }
        YLZToastUtils.showToast("网络异常，请稍后重试$msg");
      }
    }
    super.onError(err, handler);
  }
}

class HttpResponse {
  String code;
  String? msg;
  dynamic data;
  num httpCode;
  String? status;
  String? info;

  bool get success => "0" == code || code == "2000000000" || status == '1';

  HttpResponse(
      {this.code = '200',
      this.msg,
      this.data,
      this.httpCode = 200,
      this.status,
      this.info});

  @override
  String toString() {
    return 'HttpResponse{code: $code, msg: $msg, data: $data, httpCode: $httpCode, status: $status, info: $info}';
  }

  factory HttpResponse.fromJson(Map<String, dynamic> json) {
    return HttpResponse(
        code: json['code'],
        httpCode: json["httpCode"] ?? 200,
        msg: json['msg'],
        data: json['data'],
        status: json['status'],
        info: json['info']);
  }
}
