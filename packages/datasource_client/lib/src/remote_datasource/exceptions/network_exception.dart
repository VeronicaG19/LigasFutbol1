import 'package:dio/dio.dart';

enum ExceptionType {
  tokenExpiredException,
  cancelException,
  connectTimeoutException,
  sendTimeoutException,
  receiveTimeoutException,
  socketException,
  fetchDataException,
  formatException,
  unrecognizedException,
  apiException,
  serializationException,
}

class NetworkException implements Exception {
  final String name;
  final String message;
  final String? code;
  final int? statusCode;
  final String? data;
  final ExceptionType exceptionType;

  NetworkException({
    required this.message,
    this.code,
    int? statusCode,
    this.data,
    this.exceptionType = ExceptionType.apiException,
  })  : statusCode = statusCode ?? 500,
        name = exceptionType.name;

  factory NetworkException.fromDioException(Exception error) {
    try {
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.cancel:
            return NetworkException(
              exceptionType: ExceptionType.cancelException,
              statusCode: error.response?.statusCode,
              message: 'Request cancelled prematurely',
            );
          case DioErrorType.connectTimeout:
            return NetworkException(
              exceptionType: ExceptionType.connectTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Connection not established',
            );
          case DioErrorType.sendTimeout:
            return NetworkException(
              exceptionType: ExceptionType.sendTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Failed to send',
            );
          case DioErrorType.receiveTimeout:
            return NetworkException(
              exceptionType: ExceptionType.receiveTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Failed to receive',
            );
          case DioErrorType.response:
            String? responseMessage;
            String? responseData;
            if (error.response != null && error.response?.statusCode == 500) {
              final message = error.response?.data['result'] ??
                  error.response?.data['error'];
              responseData = error.response.toString();
              responseMessage = message;
            } else if (error.response != null &&
                error.response?.statusCode == 409) {
              final message = error.response?.data['result'] ??
                  error.response?.data['error'];
              responseMessage = message;
            } else if (error.response != null &&
                error.response?.statusCode == 401) {
              final message = error.response?.data['result'] ??
                  error.response?.data['error'];
              responseMessage = message;
            }
            return NetworkException(
              exceptionType: ExceptionType.apiException,
              statusCode: error.response?.statusCode,
              message: responseMessage ?? 'Ah ocurrido un error',
              code: 'API_RESPONSE_ERROR',
              data: responseData,
            );
          case DioErrorType.other:
            if (error.message.contains(ExceptionType.socketException.name)) {
              return NetworkException(
                exceptionType: ExceptionType.fetchDataException,
                statusCode: error.response?.statusCode,
                message: 'No internet connectivity',
              );
            }
            if (error.response?.data['error'] == null) {
              return NetworkException(
                exceptionType: ExceptionType.unrecognizedException,
                statusCode: error.response?.statusCode,
                message: error.response?.statusMessage ?? 'Unknown',
              );
            }
            final name = error.response?.data['error'] as String;
            final message = error.response?.data['error'] as String;
            if (name == ExceptionType.tokenExpiredException.name) {
              return NetworkException(
                exceptionType: ExceptionType.tokenExpiredException,
                code: name,
                statusCode: error.response?.statusCode,
                message: message,
              );
            }
            return NetworkException(
              code: name,
              statusCode: error.response?.statusCode,
              message: message,
            );
        }
      } else {
        return NetworkException(
          exceptionType: ExceptionType.unrecognizedException,
          message: 'Error unrecognized',
        );
      }
    } on FormatException catch (e) {
      return NetworkException(
        exceptionType: ExceptionType.formatException,
        message: e.message,
      );
    } on Exception catch (_) {
      return NetworkException(
        exceptionType: ExceptionType.unrecognizedException,
        message: 'Error unrecognized',
      );
    }
  }

  factory NetworkException.fromParsingException() {
    return NetworkException(
      exceptionType: ExceptionType.serializationException,
      message: 'Failed to parse network response to model or vice versa',
    );
  }
}
