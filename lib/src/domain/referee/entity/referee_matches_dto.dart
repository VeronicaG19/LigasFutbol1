import 'package:equatable/equatable.dart';

class RefereeMatchesDTO extends Equatable {
  final String estado;
  final String fecha;
  final String horario;
  final int jornada;
  final String local;
  final int matchId;
  final String resultado;
  final String visitante;

  const RefereeMatchesDTO({
    required this.estado,
    required this.fecha,
    required this.horario,
    required this.jornada,
    required this.local,
    required this.matchId,
    required this.resultado,
    required this.visitante,
  });

  static const empty = RefereeMatchesDTO(
      estado: '',
      fecha: '',
      horario: '',
      jornada: 0,
      local: '',
      matchId: 0,
      resultado: '',
      visitante: '');

  bool get isEmpty => this == RefereeMatchesDTO.empty;

  bool get isNotEmpty => this != RefereeMatchesDTO.empty;

  Map<String, dynamic> toMap() {
    return {
      'estado': estado,
      'fecha': fecha,
      'horario': horario,
      'jornada': jornada,
      'local': local,
      'matchId': matchId,
      'resultado': resultado,
      'visitante': visitante,
    };
  }

  factory RefereeMatchesDTO.fromJson(Map<String, dynamic> json) {
    return RefereeMatchesDTO(
      estado: json['estado'] ?? '',
      fecha: json['fecha'] ?? '',
      horario: json['horario'] ?? '',
      jornada: json['jornada'] ?? 0,
      local: json['local'] ?? '',
      matchId: json['matchId'] ?? 0,
      resultado: json['resultado'] ?? '',
      visitante: json['visitante'] ?? '',
    );
  }

  RefereeMatchesDTO copyWith({
    String? estado,
    String? fecha,
    String? horario,
    int? jornada,
    String? local,
    int? matchId,
    String? resultado,
    String? visitante,
  }) {
    return RefereeMatchesDTO(
      estado: estado ?? this.estado,
      fecha: fecha ?? this.fecha,
      horario: horario ?? this.horario,
      jornada: jornada ?? this.jornada,
      local: local ?? this.local,
      matchId: matchId ?? this.matchId,
      resultado: resultado ?? this.resultado,
      visitante: visitante ?? this.visitante,
    );
  }

  @override
  List<Object> get props => [
        estado,
        fecha,
        horario,
        jornada,
        local,
        matchId,
        resultado,
        visitante,
      ];
}
