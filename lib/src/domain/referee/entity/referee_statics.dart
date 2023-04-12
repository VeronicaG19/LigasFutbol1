import 'package:equatable/equatable.dart';

class RefereeStatics extends Equatable {
  final int tournamentId;
  final int leagueId;
  final int refereeId;
  final int partyId;
  final String tournamentName;
  final String categoryName;
  final double asignaciones;
  final String principal;
  final String asistente;
  final String cuartoArbitro;
  final String tarjetasAmarillas;
  final String tarjetasRojas;

  const RefereeStatics({
    required this.tournamentId,
    required this.leagueId,
    required this.refereeId,
    required this.partyId,
    required this.tournamentName,
    required this.categoryName,
    required this.asignaciones,
    required this.principal,
    required this.asistente,
    required this.cuartoArbitro,
    required this.tarjetasAmarillas,
    required this.tarjetasRojas,
  });

  RefereeStatics copyWith({
    int? tournamentId,
    int? leagueId,
    int? refereeId,
    int? partyId,
    String? tournamentName,
    String? categoryName,
    double? asignaciones,
    String? principal,
    String? asistente,
    String? cuartoArbitro,
    String? tarjetasAmarillas,
    String? tarjetasRojas,
  }) {
    return RefereeStatics(
      tournamentId: tournamentId ?? this.tournamentId,
      leagueId: leagueId ?? this.leagueId,
      refereeId: refereeId ?? this.refereeId,
      partyId: partyId ?? this.partyId,
      tournamentName: tournamentName ?? this.tournamentName,
      categoryName: categoryName ?? this.categoryName,
      asignaciones: asignaciones ?? this.asignaciones,
      principal: principal ?? this.principal,
      asistente: asistente ?? this.asistente,
      cuartoArbitro: cuartoArbitro ?? this.cuartoArbitro,
      tarjetasAmarillas: tarjetasAmarillas ?? this.tarjetasAmarillas,
      tarjetasRojas: tarjetasRojas ?? this.tarjetasRojas,
    );
  }

  static const empty = RefereeStatics(
      tournamentId: 0,
      leagueId: 0,
      refereeId: 0,
      partyId: 0,
      tournamentName: '',
      categoryName: '',
      asignaciones: 0,
      principal: '',
      asistente: '',
      cuartoArbitro: '',
      tarjetasAmarillas: '',
      tarjetasRojas: '');

  factory RefereeStatics.fromJson(Map<String, dynamic> json) {
    return RefereeStatics(
      tournamentId: json['toutnamentId'] ?? 0,
      leagueId: json['leagueId'] ?? 0,
      refereeId: json['refereeId'] ?? 0,
      partyId: json['partyId'] ?? 0,
      tournamentName: json['tournamentId'] ?? '',
      categoryName: json['categoryName'] ?? '',
      asignaciones: double.parse(json['asignaciones'] ?? '0'),
      principal: json['principal'] ?? '',
      asistente: json['asistente'] ?? '',
      cuartoArbitro: json['cuartoArbitro'] ?? '',
      tarjetasAmarillas: json['tarjetaAmarillas'] ?? '',
      tarjetasRojas: json['tarjetasRojas'] ?? '',
    );
  }

  @override
  List<Object> get props => [
        tournamentId,
        leagueId,
        refereeId,
        partyId,
        tournamentName,
        categoryName,
        asignaciones,
        principal,
        asistente,
        cuartoArbitro,
        tarjetasAmarillas,
        tarjetasRojas,
      ];
}
