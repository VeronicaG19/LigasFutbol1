import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constants.dart';
import '../../local_datasource/key_value_storage_service.dart';
import '../../typedefs/typedefs.dart';

class RefreshTokenInterceptor extends QueuedInterceptor {
  final Dio _dio;
  final KeyValueStorageService _kVService;
  final String _refreshTokenURL;

  RefreshTokenInterceptor(
      {required Dio dioClient,
      required kVService,
      required String refreshTokenURL})
      : _dio = dioClient,
        _kVService = kVService,
        _refreshTokenURL = refreshTokenURL;

  String get tokenExpirationException => 'TokenExpirationException';

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    debugPrint('\tENTERING REFRESH TOKEN INTERCEPTOR');
    if (err.response != null) {
      if (err.response!.data != null) {
        debugPrint('\tREFRESH TOKEN INTERCEPTOR: ${err.response!.statusCode}');
        if (err.response!.statusCode == 401) {
          final tokenDio = Dio()..options = _dio.options;
          final token = await _kVService.getAuthToken();
          if (token.isNotEmpty) {
            final data = {
              'grant_type': 'password',
              'username': await _kVService.getAuthUserName(),
              'password': await _kVService.getAuthPassword(),
            };
            final newToken = await _refreshTokenRequest(
              dioError: err,
              handler: handler,
              tokenDio: tokenDio,
              data: data,
            );

            if (newToken == null) return super.onError(err, handler);

            _kVService.setAuthToken(newToken);

            final response = await _dio.request<JSON>(err.requestOptions.path,
                data: err.requestOptions.data,
                cancelToken: err.requestOptions.cancelToken,
                options: Options(
                  headers: <String, Object?>{
                    HttpHeaders.authorizationHeader: 'Bearer $newToken'
                  },
                ));
            return handler.resolve(response);
          }
        }
      }
    }
    debugPrint('\tEXITING REFRESH TOKEN INTERCEPTOR');
    return super.onError(err, handler);
  }

  Future<String?> _refreshTokenRequest({
    required DioError dioError,
    required ErrorInterceptorHandler handler,
    required Dio tokenDio,
    required JSON data,
  }) async {
    debugPrint('--> REFRESHING TOKEN');
    tokenDio.options.extra.remove(HttpHeaders.contentTypeHeader);
    tokenDio.options.extra.remove(HttpHeaders.acceptHeader);
    try {
      final response = await tokenDio.post<JSON>(
        _refreshTokenURL,
        data: data,
        options: Options(
          headers: <String, Object?>{
            HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
            HttpHeaders.authorizationHeader:
                'Basic ${base64Encode(utf8.encode(kSecret))}',
            'grant_type': 'password',
          },
        ),
      );

      final success = response.statusCode == 200;
      debugPrint('RESPONSE-- ${response.data?['access_token']}');
      if (success) {
        return response.data?['access_token'];
      } else {
        throw Exception('REFRESH TOKEN EXCEPTION ${response.statusMessage}');
      }
    } catch (e) {
      debugPrint('\t-- ERROR');
      if (e is DioError) {
        debugPrint('\t-- Exception: ${e.error}');
        debugPrint('\t-- Message: ${e.message}');
        debugPrint('\t-- ERROR: ${e.response}');
      } else {
        debugPrint('\t-- Exception: $e');
      }
      debugPrint('\t-- END ERROR');
      debugPrint('\t-- END REFRESH');
      return null;
    }
  }
}
