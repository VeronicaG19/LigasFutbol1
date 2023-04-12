import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constants.dart';
import '../../typedefs/typedefs.dart';
import '../exceptions/network_exception.dart';
import '../models/response_model.dart';
import 'api_interface.dart';
import 'dio_service.dart';

class ApiService implements ApiInterface {
  late final DioService _dioService;

  ApiService(DioService dioService) : _dioService = dioService;

  @override
  void cancelRequests({CancelToken? cancelToken}) {
    _dioService.cancelRequests(cancelToken: cancelToken);
  }

  @override
  Future<T> deleteData<T>(
      {required String endpoint,
      JSON? data,
      CancelToken? cancelToken,
      bool requiresAuthToken = true,
      required T Function(JSON response) converter}) async {
    ResponseModel<JSON> response;

    try {
      response = await _dioService.delete<JSON>(
        endpoint: endpoint,
        data: data,
        options: Options(extra: <String, Object?>{
          kRequiresAuthToken: requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );
    } on Exception catch (ex) {
      throw NetworkException.fromDioException(ex);
    }

    try {
      return converter(response.body);
    } catch (_) {
      throw NetworkException.fromParsingException();
    }
  }

  @override
  Future<List<T>> getCollectionData<T>(
      {required String endpoint,
      JSON? queryParams,
      CancelToken? cancelToken,
      bool requiresAuthToken = true,
      required T Function(JSON responseBody) converter}) async {
    List<Object?> body;

    try {
      final request = await _dioService.get<List<Object?>>(
        endpoint: endpoint,
        isList: true,
        options: Options(extra: <String, Object?>{
          kRequiresAuthToken: requiresAuthToken,
        }),
        queryParameters: queryParams,
        cancelToken: cancelToken,
      );
      body = request.body;
    } on Exception catch (ex) {
      throw NetworkException.fromDioException(ex);
    }
    try {
      return body.map((e) => converter(e! as JSON)).toList();
    } catch (e) {
      debugPrint('Parsing error --> ${e.toString()}');
      throw NetworkException.fromParsingException();
    }
  }

  @override
  Future<T> getData<T>(
      {required String endpoint,
      JSON? queryParams,
      CancelToken? cancelToken,
      bool requiresAuthToken = true,
      required T Function(JSON responseBody) converter}) async {
    JSON body;
    try {
      final request = await _dioService.get<JSON>(
        endpoint: endpoint,
        isList: false,
        queryParameters: queryParams,
        options: Options(extra: <String, Object?>{
          kRequiresAuthToken: requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );
      body = request.body;
    } on Exception catch (ex) {
      throw NetworkException.fromDioException(ex);
    }

    try {
      return converter(body);
    } catch (e) {
      debugPrint('Parsing error --> ${e.toString()}');
      throw NetworkException.fromParsingException();
    }
  }

  @override
  Future<T> postData<T>(
      {required String endpoint,
      required JSON? data,
      CancelToken? cancelToken,
      String? dataAsString,
      bool requiresAuthToken = true,
      required T Function(JSON response) converter}) async {
    ResponseModel<JSON> response;

    try {
      response = await _dioService.post<JSON>(
        endpoint: endpoint,
        data: data,
        dataAsString: dataAsString,
        options: Options(extra: <String, Object?>{
          kRequiresAuthToken: requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );
    } on Exception catch (ex) {
      throw NetworkException.fromDioException(ex);
    }

    try {
      return converter(response.body);
    } catch (e) {
      debugPrint('Parsing error --> ${e.toString()}');
      throw NetworkException.fromParsingException();
    }
  }

  @override
  Future<T> updateData<T>(
      {required String endpoint,
      JSON? data,
      CancelToken? cancelToken,
      bool requiresAuthToken = true,
      required T Function(JSON response) converter}) async {
    ResponseModel<JSON> response;

    try {
      response = await _dioService.patch<JSON>(
        endpoint: endpoint,
        data: data,
        options: Options(extra: <String, Object?>{
          kRequiresAuthToken: requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );
    } on Exception catch (ex) {
      throw NetworkException.fromDioException(ex);
    }

    try {
      return converter(response.body);
    } catch (e) {
      debugPrint('Parsing error --> ${e.toString()}');
      throw NetworkException.fromParsingException();
    }
  }
}
