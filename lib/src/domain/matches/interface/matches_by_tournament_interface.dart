import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'matches_by_tournament_interface.g.dart';

@JsonSerializable()
class MatchesByTournamentsInterface extends Equatable {
  final int matchId;
  final int? jornada;
  final DateTime? fecha;
  final String? equipoLocal;
  final String? uniformeLocal;
  final int? marcadorLocal;
  final String? equipoVisita;
  final String? campo;
  final String? estadoJuego;
  final String? definicionShootout;
  final int? marcadorVisita;
  final int? shooutOutLocal;
  final int? shooutOutVisita;
  final String? uniformeVisita;

  const MatchesByTournamentsInterface({
    required this.matchId,
    this.jornada,
    this.fecha,
    this.equipoLocal,
    this.uniformeLocal,
    this.marcadorLocal,
    this.equipoVisita,
    this.campo,
    this.estadoJuego,
    this.definicionShootout,
    this.marcadorVisita,
    this.shooutOutLocal,
    this.shooutOutVisita,
    this.uniformeVisita,
  });

  /// Connect the generated [_$MatchesByTournamentsInterfaceFromJson] function to the `fromJson`
  /// factory.
  factory MatchesByTournamentsInterface.fromJson(Map<String, dynamic> json) =>
      _$MatchesByTournamentsInterfaceFromJson(json);

  /// Connect the generated [_$MatchesByTournamentsInterfaceToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MatchesByTournamentsInterfaceToJson(this);

  MatchesByTournamentsInterface copyWith({
    int? matchId,
    int? jornada,
    DateTime? fecha,
    String? equipoLocal,
    String? uniformeLocal,
    int? marcadorLocal,
    String? equipoVisita,
    String? campo,
    String? estadoJuego,
    String? definicionShootout,
    int? marcadorVisita,
    int? shooutOutLocal,
    int? shooutOutVisita,
    String? uniformeVisita,
  }) {
    return MatchesByTournamentsInterface(
      matchId: matchId ?? this.matchId,
      jornada: jornada ?? this.jornada,
      fecha: fecha ?? this.fecha,
      equipoLocal: equipoLocal ?? this.equipoLocal,
      uniformeLocal: uniformeLocal ?? this.uniformeLocal,
      marcadorLocal: marcadorLocal ?? this.marcadorLocal,
      equipoVisita: equipoVisita ?? this.equipoVisita,
      campo: campo ?? this.campo,
      estadoJuego: estadoJuego ?? this.estadoJuego,
      definicionShootout: definicionShootout ?? this.definicionShootout,
      marcadorVisita: marcadorVisita ?? this.marcadorVisita,
      shooutOutLocal: shooutOutLocal ?? this.shooutOutLocal,
      shooutOutVisita: shooutOutVisita ?? this.shooutOutVisita,
      uniformeVisita: uniformeVisita ?? this.uniformeVisita,
    );
  }

  @override
  List<Object?> get props => [
        matchId,
        jornada,
        fecha,
        equipoLocal,
        uniformeLocal,
        marcadorLocal,
        equipoVisita,
        campo,
        estadoJuego,
        definicionShootout,
        marcadorVisita,
        shooutOutLocal,
        shooutOutVisita,
        uniformeVisita,
      ];
}
