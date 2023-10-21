import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'constants.dart';
import 'local_datasource/key_value_storage_base.dart';
import 'local_datasource/key_value_storage_service.dart';
import 'remote_datasource/api_call/api_interface.dart';
import 'remote_datasource/api_call/api_service.dart';
import 'remote_datasource/api_call/dio_service.dart';
import 'remote_datasource/interceptors/api_interceptor.dart';
import 'remote_datasource/interceptors/logging_interceptor.dart';
import 'remote_datasource/interceptors/refresh_token_interceptor.dart';

class ApiClient {
  static late final Dio _dio;
  static late final String _refreshTokenURL;
  static late final KeyValueStorageService _localStorageService;
  static late final ApiInterface _networkApiCallService;

  ApiClient._();

  static final ApiClient _instance = ApiClient._();

  ApiInterface get network => _networkApiCallService;
  KeyValueStorageService get localStorage => _localStorageService;

  static Future<ApiClient> initialize(
      {required String baseUrl,
      required int orgId,
      required String refreshTokenURL,
      required bool showLogs}) async {
    _dio = Dio(
      BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: 80000,
          receiveTimeout: 60000,
          responseType: ResponseType.json,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            kAcceptOrgIdHeader: orgId,
          }),
    );
    _refreshTokenURL = refreshTokenURL;
    await KeyValueStorageBase.init();
    _localStorageService = KeyValueStorageService();
    _networkApiCallService = ApiService(
      DioService(
        dioClient: _dio,
        interceptors: [
          ApiInterceptor(_localStorageService),
          if (showLogs) LoggingInterceptor(),
          RefreshTokenInterceptor(
              dioClient: _dio,
              kVService: _localStorageService,
              refreshTokenURL: _refreshTokenURL),
        ],
      ),
    );
    return _instance;
  }
}
