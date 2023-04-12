import 'package:equatable/equatable.dart';

class AuthFailure extends Equatable {
  final String code;
  final String message;

  const AuthFailure({
    required this.code,
    required this.message,
  });

  @override
  List<Object> get props => [code, message];
}
