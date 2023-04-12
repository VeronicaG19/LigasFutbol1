import 'package:equatable/equatable.dart';

import '../constants.dart';

class VerificationCode extends Equatable {
  const VerificationCode({
    this.verificationCodeId,
    required this.verificationCode,
    this.personId,
    required this.statusCode,
    this.intents,
    required this.operationType,
    this.resetTime,
    required this.receiver,
  });

  static const empty = VerificationCode(
      verificationCode: '', statusCode: '', operationType: '', receiver: '');

  bool get isNotEmpty => this != VerificationCode.empty;

  bool get isEmpty => this == VerificationCode.empty;

  VerificationCode copyWith({
    int? verificationCodeId,
    String? verificationCode,
    int? personId,
    String? statusCode,
    int? intents,
    String? operationType,
    DateTime? resetTime,
    String? receiver,
  }) {
    return VerificationCode(
      verificationCodeId: verificationCodeId ?? this.verificationCodeId,
      verificationCode: verificationCode ?? this.verificationCode,
      personId: personId ?? this.personId,
      statusCode: statusCode ?? this.statusCode,
      intents: intents ?? this.intents,
      operationType: operationType ?? this.operationType,
      receiver: receiver ?? this.receiver,
      resetTime: resetTime ?? this.resetTime,
    );
  }

  /// Verification code id
  final int? verificationCodeId;

  /// The verification code
  final String verificationCode;

  /// Person id
  final int? personId;

  /// Verification code status
  final String statusCode;

  /// Number of intents by the user
  final int? intents;

  /// Operation for the code [Register, ForgotPassword]
  final String operationType;

  /// Valid duration
  final DateTime? resetTime;

  /// Where the code is sent
  final String receiver;

  factory VerificationCode.fromJson(Map json) {
    final String? date = json['resetTime']?.toString();
    final DateTime? dateTime = date != null ? DateTime.parse(date) : null;
    return VerificationCode(
        operationType: json['operationType'].toString(),
        personId: json['personId'],
        statusCode: json['statusCode'].toString(),
        verificationCode: json['verificationCode'].toString(),
        verificationCodeId: json['verificationCodeId'] as int,
        intents: json['intents'],
        resetTime: dateTime,
        receiver: json['receiver']);
  }

  Map<String, dynamic> toJson() {
    return {
      'operationType': operationType,
      'personId': personId,
      'statusCode': statusCode,
      'verificationCode': verificationCode,
      'verificationCodeId': verificationCodeId,
      'intents': intents,
      'resetTime': resetTime?.toString(),
      'receiver': receiver,
    };
  }

  static final _phoneRegExp = RegExp(r'^[0-9]{10}');

  String get getVerificationType {
    if (_phoneRegExp.hasMatch(receiver) && receiver.length == 10) {
      return kVerificationWithPhone;
    } else {
      return kVerificationWithEmail;
    }
  }

  /// Returns true if the code is still valid
  bool get getDateValidation => resetTime?.isAfter(DateTime.now()) ?? false;

  /// If the code has been validated
  bool get isTheCodeValidated => statusCode == 'CONFIRMED' && getDateValidation;

  @override
  List<Object?> get props => [
        verificationCodeId,
        verificationCode,
        personId,
        statusCode,
        intents,
        operationType,
        resetTime,
        receiver,
      ];

  @override
  String toString() {
    return 'VerificationCode{verificationCodeId: $verificationCodeId, verificationCode: $verificationCode, personId: $personId, statusCode: $statusCode, intents: $intents, operationType: $operationType, resetTime: $resetTime, receiver: $receiver}';
  }
}
