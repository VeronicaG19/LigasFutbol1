import 'package:equatable/equatable.dart';

class CountEventTournament extends Equatable {
  final String evento;
  final int matchEventC;

  const CountEventTournament({
    required this.evento,
    required this.matchEventC,
  });

  static const empty = CountEventTournament(evento: '', matchEventC: 0);

  CountEventTournament copyWith({
    String? evento,
    int? matchEventC,
  }) {
    return CountEventTournament(
      evento: evento ?? this.evento,
      matchEventC: matchEventC ?? this.matchEventC,
    );
  }

  factory CountEventTournament.fromJson(Map<String, dynamic> json) {
    return CountEventTournament(
      evento: json['evento'] as String,
      matchEventC: json['matchEventC'] as int,
    );
  }

  @override
  List<Object> get props => [evento, matchEventC];
}
