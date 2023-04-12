enum HereExceptionType {
  unauthorized,
  badCredentials,
  serverException,
  socketException,
  unknownException,
}

class HereException implements Exception {
  final String name;
  final String message;
  final String? code;
  final int? statusCode;
  final HereExceptionType exceptionType;

  HereException({
    required this.message,
    this.code,
    int? statusCode,
    this.exceptionType = HereExceptionType.unknownException,
  })  : statusCode = statusCode ?? 500,
        name = exceptionType.name;

  factory HereException.fromCode(HereExceptionType type) {
    switch (type) {
      case HereExceptionType.unauthorized:
        return HereException(
          exceptionType: HereExceptionType.unauthorized,
          statusCode: 401,
          message: 'Failed to login, incorrect user or password',
        );
      case HereExceptionType.badCredentials:
        return HereException(
          exceptionType: HereExceptionType.badCredentials,
          statusCode: 400,
          message: 'Failed to login, incorrect user or password',
        );
      case HereExceptionType.serverException:
        return HereException(
          exceptionType: HereExceptionType.serverException,
          statusCode: 500,
          message: 'Error unrecognized',
        );
      case HereExceptionType.socketException:
        return HereException(
          exceptionType: HereExceptionType.socketException,
          statusCode: 500,
          message: 'No internet connectivity',
        );
      case HereExceptionType.unknownException:
        return HereException(
          exceptionType: HereExceptionType.unknownException,
          statusCode: 500,
          message: 'Error unrecognized',
        );
    }
  }
}
