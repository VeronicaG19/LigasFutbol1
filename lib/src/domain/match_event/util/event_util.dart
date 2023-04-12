import 'package:equatable/equatable.dart';

class EventUtil extends Equatable {
  final String? code;
  final String? label;

  const EventUtil({
    this.code,
    this.label,
  });

  EventUtil copyWith({
    String? code,
    String? label,
  }) {
    return EventUtil(
      code: code ?? this.code,
      label: label ?? this.label,
    );
  }

  static const empty = EventUtil();

  @override
  List<Object?> get props => [
        code,
        label,
      ];
}
