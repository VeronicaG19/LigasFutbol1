import 'package:dio/dio.dart';

import '../../typedefs/typedefs.dart';
import '../models/response_model.dart';

class DioService {
  final Dio _dio;
  final CancelToken _cancelToken;

  DioService({
    required Dio dioClient,
    Iterable<Interceptor>? interceptors,
    HttpClientAdapter? httpClientAdapter,
  })  : _dio = dioClient,
        _cancelToken = CancelToken() {
    if (interceptors != null) _dio.interceptors.addAll(interceptors);
    if (httpClientAdapter != null) _dio.httpClientAdapter = httpClientAdapter;
  }

  void cancelRequests({CancelToken? cancelToken}) {
    if (cancelToken == null) {
      _cancelToken.cancel('Canceled');
    } else {
      cancelToken.cancel();
    }
  }

  Future<ResponseModel<R>> get<R>({
    required String endpoint,
    required bool isList,
    JSON? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    if (isList) {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: _mergeDioOptions(dioOptions: options),
        cancelToken: cancelToken ?? _cancelToken,
      );
      final list = response.data as List;
      return ResponseModel<R>.fromList(list);
    }
    final response = await _dio.get<JSON>(
      endpoint,
      queryParameters: queryParameters,
      options: _mergeDioOptions(dioOptions: options),
      cancelToken: cancelToken ?? _cancelToken,
    );
    return ResponseModel<R>.fromJson(response.data!);
  }

  Future<ResponseModel<R>> post<R>({
    required String endpoint,
    JSON? data,
    String? dataAsString,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.post<JSON>(
      endpoint,
      data: data?.isNotEmpty ?? false ? data : dataAsString,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return ResponseModel<R>.fromJson(response.data!);
  }

  Future<ResponseModel<R>> patch<R>({
    required String endpoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.patch<JSON>(
      endpoint,
      data: data,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return ResponseModel<R>.fromJson(response.data!);
  }

  Future<ResponseModel<R>> delete<R>({
    required String endpoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.delete<JSON>(
      endpoint,
      data: data,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return ResponseModel<R>.fromJson(response.data!);
  }

  Options? _mergeDioOptions({Options? dioOptions}) {
    if (dioOptions == null) {
      return null;
    }
    return dioOptions;
  }
}
