enum UserExceptionType {
  unauthorized,
  badCredentials,
  serverException,
  socketException,
  unknownException,
  noCacheDataFound,
  timeout,
  emailExists,
  userNameExists,
  phoneExists,
}

class UserException implements Exception {
  final String name;
  final String message;
  final String? code;
  final int? statusCode;
  final UserExceptionType exceptionType;

  UserException({
    required this.message,
    this.code,
    int? statusCode,
    this.exceptionType = UserExceptionType.unknownException,
  })  : statusCode = statusCode ?? 500,
        name = exceptionType.name;

  factory UserException.fromCode(UserExceptionType type) {
    switch (type) {
      case UserExceptionType.unauthorized:
        return UserException(
          exceptionType: UserExceptionType.unauthorized,
          statusCode: 401,
          message: 'Failed to login, incorrect user or password',
        );
      case UserExceptionType.badCredentials:
        return UserException(
          exceptionType: UserExceptionType.badCredentials,
          statusCode: 400,
          message: 'Failed to login, incorrect user or password',
        );
      case UserExceptionType.serverException:
        return UserException(
          exceptionType: UserExceptionType.serverException,
          statusCode: 500,
          message: 'Error unrecognized',
        );
      case UserExceptionType.socketException:
        return UserException(
          exceptionType: UserExceptionType.socketException,
          statusCode: 500,
          message: 'No internet connectivity',
        );
      case UserExceptionType.unknownException:
        return UserException(
          exceptionType: UserExceptionType.unknownException,
          statusCode: 500,
          message: 'Error unrecognized',
        );
      case UserExceptionType.noCacheDataFound:
        return UserException(
          exceptionType: UserExceptionType.noCacheDataFound,
          statusCode: 500,
          code: UserExceptionType.noCacheDataFound.name,
          message: 'No cache data found',
        );
      case UserExceptionType.timeout:
        return UserException(
          exceptionType: UserExceptionType.timeout,
          statusCode: 500,
          code: UserExceptionType.timeout.name,
          message: 'No response from server',
        );
      case UserExceptionType.userNameExists:
        return UserException(
          exceptionType: UserExceptionType.userNameExists,
          statusCode: 500,
          code: UserExceptionType.userNameExists.name,
          message: 'Username is already registered',
        );
      case UserExceptionType.emailExists:
        return UserException(
          exceptionType: UserExceptionType.emailExists,
          statusCode: 500,
          code: UserExceptionType.emailExists.name,
          message: 'Email is already registered',
        );
      case UserExceptionType.phoneExists:
        return UserException(
          exceptionType: UserExceptionType.phoneExists,
          statusCode: 500,
          code: UserExceptionType.phoneExists.name,
          message: 'Phone number is already registered',
        );
    }
  }
}
