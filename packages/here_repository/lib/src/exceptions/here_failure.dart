import 'package:equatable/equatable.dart';

class HereFailure extends Equatable {
  final String code;
  final String message;

  const HereFailure({
    required this.code,
    required this.message,
  });

  @override
  List<Object> get props => [code, message];
}
