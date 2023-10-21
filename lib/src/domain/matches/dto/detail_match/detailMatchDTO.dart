import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detailMatchDTO.g.dart';

@JsonSerializable()
class DetailMatchDTO extends Equatable {
  final int? matchId;
  final String? arbitro;
  final String? cambiosIlimitados;
  final String? campo;
  final String? direccion;
  final String? estado;
  final String? fecha;
  final String? fechaJuego;
  final String? hora;
  final int? idLocal;
  final int? idVisit;
  final String? jordana;
  final String? local;
  final String? logoLocal;
  final String? logoVisit;
  final int? marcadorLocal;
  final int? marcadorVisitante;
  final int? numerodeCambios;
  final String? shootOut;
  final int? shootoutLocal;
  final int? shootoutVisit;
  final int? uniformeLocal;
  final int? uniformeVisitante;
  final String? visitante;
  final String? vs;
  final int? fieldId;
  final int? refereeId;
  final int? leagueid;

  const DetailMatchDTO({
    this.matchId,
    this.arbitro,
    this.cambiosIlimitados,
    this.campo,
    this.direccion,
    this.estado,
    this.fecha,
    this.fechaJuego,
    this.hora,
    this.idLocal,
    this.idVisit,
    this.jordana,
    this.local,
    this.logoLocal,
    this.logoVisit,
    this.marcadorLocal,
    this.marcadorVisitante,
    this.numerodeCambios,
    this.shootOut,
    this.shootoutLocal,
    this.shootoutVisit,
    this.uniformeLocal,
    this.uniformeVisitante,
    this.visitante,
    this.vs,
    this.fieldId,
    this.refereeId,
    this.leagueid,
  });

  /// Connect the generated [_$DetailMatchDTOFromJson] function to the `fromJson`
  /// factory.
  factory DetailMatchDTO.fromJson(Map<String, dynamic> json) =>
      _$DetailMatchDTOFromJson(json);

  /// Connect the generated [_$DetailMatchDTOToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DetailMatchDTOToJson(this);

  DetailMatchDTO copyWith(
      {int? matchId,
      String? arbitro,
      String? cambiosIlimitados,
      String? campo,
      String? direccion,
      String? estado,
      String? fecha,
      String? hora,
      int? idLocal,
      int? idVisit,
      String? jordana,
      String? local,
      String? logoLocal,
      String? logoVisit,
      int? marcadorLocal,
      int? marcadorVisitante,
      int? numerodeCambios,
      String? shootOut,
      int? shootoutLocal,
      int? shootoutVisit,
      int? uniformeLocal,
      int? uniformeVisitante,
      String? visitante,
      String? vs,
      int? fieldId,
      int? refereeId,
      int? leagueid}) {
    return DetailMatchDTO(
      matchId: matchId ?? this.matchId,
      arbitro: arbitro ?? this.arbitro,
      cambiosIlimitados: cambiosIlimitados ?? this.cambiosIlimitados,
      campo: campo ?? this.campo,
      direccion: direccion ?? this.direccion,
      estado: estado ?? this.estado,
      fecha: fecha ?? this.fecha,
      hora: hora ?? this.hora,
      idLocal: idLocal ?? this.idLocal,
      idVisit: idVisit ?? this.idVisit,
      jordana: jordana ?? this.jordana,
      local: local ?? this.local,
      logoLocal: logoLocal ?? this.logoLocal,
      logoVisit: logoVisit ?? this.logoVisit,
      marcadorLocal: marcadorLocal ?? this.marcadorLocal,
      marcadorVisitante: marcadorVisitante ?? this.marcadorVisitante,
      numerodeCambios: numerodeCambios ?? this.numerodeCambios,
      shootOut: shootOut ?? this.shootOut,
      shootoutLocal: shootoutLocal ?? this.shootoutLocal,
      shootoutVisit: shootoutVisit ?? this.shootoutVisit,
      uniformeLocal: uniformeLocal ?? this.uniformeLocal,
      uniformeVisitante: uniformeVisitante ?? this.uniformeVisitante,
      visitante: visitante ?? this.visitante,
      vs: vs ?? this.vs,
      fieldId: fieldId ?? this.fieldId,
      refereeId: refereeId ?? this.refereeId,
      leagueid: leagueid ?? this.leagueid,
    );
  }

  @override
  List<Object?> get props => [
        matchId,
        arbitro,
        cambiosIlimitados,
        campo,
        direccion,
        estado,
        fecha,
        hora,
        idLocal,
        idVisit,
        jordana,
        local,
        logoLocal,
        logoVisit,
        marcadorLocal,
        marcadorVisitante,
        numerodeCambios,
        shootOut,
        shootoutLocal,
        shootoutVisit,
        uniformeLocal,
        uniformeVisitante,
        visitante,
        vs,
        fieldId,
        refereeId,
        leagueid,
      ];
}
