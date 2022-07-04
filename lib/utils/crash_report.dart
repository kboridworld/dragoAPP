import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:nh_flutter_native_channel/nh_flutter_native_channel.dart';
import 'package:dragoma/application.dart' show inProduction;

class CrashReporter {
  static report(dynamic error, dynamic stackTrace,
      {FlutterErrorDetails? errorDetails}) {
    if (inProduction) {
      NhFlutterNativeChannel.caller
          .callNative(moduleName: 'CrashReport', method: 'report', args: [
        error.toString(),
        error is DioError
            ? error.dioErrorDetail() + '\n' + stackTrace.toString()
            : stackTrace.toString()
      ]);
    }
  }
}

extension on DioError {
  String dioErrorDetail() {
    String errorContext = "";
    RequestOptions request = this.requestOptions;
    Response? response = this.response;
    errorContext += '请求信息:';
    errorContext += '\n请求地址: ${request.baseUrl}${request.path}';
    errorContext += '\n请求入参: ${request.data?.toString() ?? '无请求数据'}';
    errorContext += '\n................................................';
    errorContext += '\n${StackTrace.current.toString()}';
    errorContext += '\n................................................';
    if (response != null) {
      errorContext += '\n响应信息:';
      errorContext += '\n${response.statusCode?.toString() ?? 'statusCode为空'}';
      errorContext += '\n${response.statusMessage ?? 'statusMessage为空'}';
      errorContext += '\n${response.data ?? ''}';
      errorContext += '\n................................................';
    }
    return errorContext;
  }
}
