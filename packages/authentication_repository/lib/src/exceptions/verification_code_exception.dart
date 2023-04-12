import '../constants.dart';

class VerificationCodeException implements Exception {
  const VerificationCodeException([this.code = kUnknownException]);

  const VerificationCodeException.exists([this.code = kAlreadyExistsCode]);

  const VerificationCodeException.invalidCode([this.code = kInvalidCode]);

  const VerificationCodeException.intentsExceeded(
      [this.code = kIntentsExceededCode]);

  final String code;
}
