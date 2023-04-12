import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'matches_by_player.g.dart';

@JsonSerializable()
class MatchesByPlayerDTO extends Equatable {
  final int? matchId;
  final String? estado;
  final DateTime? fecha;
  final String? horario;
  final int? jornada;
  final String? local;
  final String? resultado;
  final String? visitante;

  const MatchesByPlayerDTO({
    this.matchId,
    this.estado,
    this.fecha,
    this.horario,
    this.jornada,
    this.local,
    this.resultado,
    this.visitante,
  });

  /// Connect the generated [_$MatchesByPlayerDTOFromJson] function to the `fromJson`
  /// factory.
  factory MatchesByPlayerDTO.fromJson(Map<String, dynamic> json) =>
      _$MatchesByPlayerDTOFromJson(json);

  /// Connect the generated [_$MatchesByPlayerDTOToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MatchesByPlayerDTOToJson(this);

  MatchesByPlayerDTO copyWith({
    int? matchId,
    String? estado,
    DateTime? fecha,
    String? horario,
    int? jornada,
    String? local,
    String? resultado,
    String? visitante,
  }) {
    return MatchesByPlayerDTO(
      matchId: matchId ?? this.matchId,
      estado: estado ?? this.estado,
      fecha: fecha ?? this.fecha,
      horario: horario ?? this.horario,
      jornada: jornada ?? this.jornada,
      local: local ?? this.local,
      resultado: resultado ?? this.resultado,
      visitante: visitante ?? this.visitante,
    );
  }

  @override
  List<Object?> get props => [
        matchId,
        estado,
        fecha,
        horario,
        jornada,
        local,
        resultado,
        visitante,
      ];
}
