import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'matches_by_team.g.dart';

@JsonSerializable()
class MatchesByTeamDTO extends Equatable {
  final int? matchId;
  final String? estado;
  final String? fecha;
  final String? horario;
  final int? jornada;
  final String? local;
  final String? resultado;
  final String? visitante;

  const MatchesByTeamDTO({
    this.matchId,
    this.estado,
    this.fecha,
    this.horario,
    this.jornada,
    this.local,
    this.resultado,
    this.visitante,
  });

  factory MatchesByTeamDTO.fromJson(Map<String, dynamic> json) =>
      _$MatchesByTeamDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MatchesByTeamDTOToJson(this);

  MatchesByTeamDTO copyWith({
    int? matchId,
    String? estado,
    String? fecha,
    String? horario,
    int? jornada,
    String? local,
    String? resultado,
    String? visitante,
  }) {
    return MatchesByTeamDTO(
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