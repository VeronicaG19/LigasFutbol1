enum AuthExceptionType {
  unauthorized,
  badCredentials,
  serverException,
  socketException,
  unknownException,
  noCacheDataFound,
  timeout,
}

class AuthenticationException implements Exception {
  final String name;
  final String message;
  final String? code;
  final int? statusCode;
  final AuthExceptionType exceptionType;

  AuthenticationException({
    required this.message,
    this.code,
    int? statusCode,
    this.exceptionType = AuthExceptionType.unknownException,
  })  : statusCode = statusCode ?? 500,
        name = exceptionType.name;

  factory AuthenticationException.fromCode(AuthExceptionType type) {
    switch (type) {
      case AuthExceptionType.unauthorized:
        return AuthenticationException(
            exceptionType: AuthExceptionType.unauthorized,
            statusCode: 401,
            //message: 'Failed to login, incorrect user or password',
            message:
                'No se pudo iniciar sesión, usuario o contraseña incorrectos.');
      case AuthExceptionType.badCredentials:
        return AuthenticationException(
            exceptionType: AuthExceptionType.badCredentials,
            statusCode: 400,
            message:
                'No se pudo iniciar sesión, usuario o contraseña incorrectos.');
      case AuthExceptionType.serverException:
        return AuthenticationException(
          exceptionType: AuthExceptionType.serverException,
          statusCode: 500,
          message: 'Error unrecognized',
        );
      case AuthExceptionType.socketException:
        return AuthenticationException(
          exceptionType: AuthExceptionType.socketException,
          statusCode: 500,
          message: 'No internet connectivity',
        );
      case AuthExceptionType.unknownException:
        return AuthenticationException(
          exceptionType: AuthExceptionType.unknownException,
          statusCode: 500,
          message: 'Error unrecognized',
        );
      case AuthExceptionType.noCacheDataFound:
        return AuthenticationException(
          exceptionType: AuthExceptionType.noCacheDataFound,
          statusCode: 500,
          code: AuthExceptionType.noCacheDataFound.name,
          message: 'No cache data found',
        );
      case AuthExceptionType.timeout:
        return AuthenticationException(
          exceptionType: AuthExceptionType.timeout,
          statusCode: 500,
          code: AuthExceptionType.timeout.name,
          message: 'No response from server',
        );
    }
  }
}
