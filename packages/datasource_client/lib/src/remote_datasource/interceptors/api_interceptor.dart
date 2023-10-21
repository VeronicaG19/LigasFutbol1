import 'dart:io';

import 'package:dio/dio.dart';

import '../../constants.dart';
import '../../local_datasource/key_value_storage_service.dart';

class ApiInterceptor extends QueuedInterceptor {
  final KeyValueStorageService _kVService;
  ApiInterceptor(this._kVService) : super();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra.containsKey(kRequiresAuthToken)) {
      if (options.extra[kRequiresAuthToken] == true) {
        final token = await _kVService.getAuthToken();
        options.headers.addAll(
          <String, Object?>{
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );
      }
      options.extra.remove(kRequiresAuthToken);
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final success = response.statusCode == 200 || response.statusCode == 201;
    if (success) return handler.next(response);

    return handler.reject(
        DioError(requestOptions: response.requestOptions, response: response));
    //super.onResponse(response, handler);
  }
}
