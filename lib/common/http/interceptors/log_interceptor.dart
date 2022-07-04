import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dragoma/utils/log/ylz_log.dart';
import 'package:dragoma/utils/log/ylz_log_util.dart';

class YLZLogInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    RequestOptions requestOptions = response.requestOptions;
    Map<String, dynamic> msg = {
      "path": requestOptions.uri.toString(),
      "method": requestOptions.method,
      "request": (requestOptions.data is FormData)
          ? requestOptions.data?.toString() ?? ''
          : requestOptions.data,
      "response": response.data,
      "headers": requestOptions.headers
    };
    bool isRecord = requestOptions.extra['isRecord'] ?? true;
    if (isRecord) {
      YLZLogUtil.doRecord(jsonEncode(msg),
          print: false,
          source: YLZLogSource.request,
          type: YLZLogType.jsonString);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    RequestOptions requestOptions = err.requestOptions;
    Map<String, dynamic> msg = {
      "path": requestOptions.uri.toString(),
      "method": requestOptions.method,
      "request": requestOptions.data,
      "error": err.toString(),
      "headers": requestOptions.headers,
    };
    bool isRecord = requestOptions.extra['isRecord'] ?? true;
    if (isRecord) {
      YLZLogUtil.doRecord(jsonEncode(msg),
          print: false,
          source: YLZLogSource.request,
          type: YLZLogType.jsonString);
    }
    super.onError(err, handler);
  }
}
