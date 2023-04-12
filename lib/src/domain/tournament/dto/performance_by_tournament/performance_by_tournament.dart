import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_by_tournament.g.dart';

@JsonSerializable()
class PerformanceByTournament extends Equatable {
  final int? matchId;
  final String? local;
  final int? yellowCard;

  final String? encuentro;
  final int? redCards;

  final String? visitante;
  final String? logolocAL;

  final String? logovisit;
  final int? tournamentid;

  final String? nombredeltorneo;
  final int? goles;

  const PerformanceByTournament({
    this.matchId,
    this.local,
    this.yellowCard,
    this.encuentro,
    this.redCards,
    this.visitante,
    this.logolocAL,
    this.logovisit,
    this.tournamentid,
    this.nombredeltorneo,
    this.goles,
  });

  /// Connect the generated [_$PerformanceByTournamentFromJson] function to the `fromJson`
  /// factory.
  factory PerformanceByTournament.fromJson(Map<String, dynamic> json) =>
      _$PerformanceByTournamentFromJson(json);

  /// Connect the generated [_$PerformanceByTournamentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PerformanceByTournamentToJson(this);

  PerformanceByTournament copyWith({
    int? matchId,
    String? local,
    int? yellowCard,
    String? encuentro,
    int? redCards,
    String? visitante,
    String? logolocAL,
    String? logovisit,
    int? tournamentid,
    String? nombredeltorneo,
    int? goles,
  }) {
    return PerformanceByTournament(
      matchId: matchId ?? this.matchId,
      local: local ?? this.local,
      yellowCard: yellowCard ?? this.yellowCard,
      encuentro: encuentro ?? this.encuentro,
      redCards: redCards ?? this.redCards,
      visitante: visitante ?? this.visitante,
      logolocAL: logolocAL ?? this.logolocAL,
      logovisit: logovisit ?? this.logovisit,
      tournamentid: tournamentid ?? this.tournamentid,
      nombredeltorneo: nombredeltorneo ?? this.nombredeltorneo,
      goles: goles ?? this.goles,
    );
  }

  @override
  List<Object?> get props => [
        matchId,
        local,
        yellowCard,
        encuentro,
        redCards,
        visitante,
        logolocAL,
        logovisit,
        tournamentid,
        nombredeltorneo,
        goles,
      ];
}
