import 'package:equatable/equatable.dart';

class UserFailure extends Equatable {
  final String code;
  final String message;

  const UserFailure({
    required this.code,
    required this.message,
  });

  @override
  List<Object> get props => [code, message];
}
