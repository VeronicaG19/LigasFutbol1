import 'package:equatable/equatable.dart';

class NotificationFailure extends Equatable {
  final String code;
  final String message;

  const NotificationFailure({
    required this.code,
    required this.message,
  });

  @override
  List<Object> get props => [code, message];
}
