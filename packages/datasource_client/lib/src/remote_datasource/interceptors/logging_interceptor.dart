import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final httpMethod = options.method.toUpperCase();
    final url = options.baseUrl + options.path;

    debugPrint('API SERVICE --> $httpMethod $url');
    debugPrint('\tHeaders: ');
    options.headers.forEach((key, value) => debugPrint('\t\t$key: $value'));

    if (options.queryParameters.isNotEmpty) {
      debugPrint('\tqueryParameters:');
      options.queryParameters
          .forEach((key, value) => debugPrint('\t\t$key: $value'));
    }

    if (options.data != null) {
      debugPrint('\tBody: ${options.data}');
    }

    debugPrint('API SERVICE --> END $httpMethod');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('API SERVICE <-- RESPONSE');

    debugPrint('\tStatus code: ${response.statusCode}');

    if (response.statusCode == 304) {
      debugPrint('\tSource: 304');
    } else {
      debugPrint('\tSource: Network');
    }

    debugPrint('\tResponse: ${response.data}');

    debugPrint('API SERVICE <-- END HTTP');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('\tAPI SERVICE --> ERROR');
    final httpMethod = err.requestOptions.method.toUpperCase();
    final url = err.requestOptions.baseUrl + err.requestOptions.path;
    debugPrint('\tMETHOD: $httpMethod');
    debugPrint('\tURL: $url');
    debugPrint('Error ---> $err');
    if (err.response != null) {
      debugPrint('\tStatus code: ${err.response!.statusCode}');
      if (err.response!.data != null) {
        debugPrint('\tResponse: ${err.response}');
      }
    } else if (err.error is SocketException) {
      debugPrint('\tException: FetchException');
      debugPrint('\tMessage: No internet connection');
    } else {
      debugPrint('\tUnknown Error');
    }

    debugPrint('\tAPI SERVICE --> END ERROR');

    return super.onError(err, handler);
  }
}
