import 'package:equatable/equatable.dart';

class RefereeMatchDTO extends Equatable {
  final String estado;
  final String fechayCampo;
  final int? jornada;
  final int? leagueId;
  final String ligayTorneo;
  final DateTime? matchDate;
  final int? matchId;
  final String partido;
  final int? tournamentId;
  final int? local;
  final int? visit;
  final int? teamIdLocal;
  final int? teamIdVisit;

  const RefereeMatchDTO({
    required this.estado,
    required this.fechayCampo,
    this.jornada,
    this.leagueId,
    required this.ligayTorneo,
    this.matchDate,
    this.matchId,
    required this.partido,
    this.tournamentId,
    this.local,
    this.visit,
    this.teamIdLocal,
    this.teamIdVisit,
  });

  static const empty = RefereeMatchDTO(
      estado: '', fechayCampo: '', ligayTorneo: '', partido: '');

  Map<String, dynamic> toJson() {
    return {
      'estado': estado,
      'fechayCampo': fechayCampo,
      'jornada': jornada,
      'leagueId': leagueId,
      'ligayTorneo': ligayTorneo,
      'matchDate': matchDate,
      'matchId': matchId,
      'partido': partido,
      'tournamentId': tournamentId,
      'local': local,
      'visit': visit,
      'teamIdLocal': teamIdLocal,
      'teamIdVisit': teamIdVisit,
    };
  }

  factory RefereeMatchDTO.fromJson(Map<String, dynamic> json) {
    final date = json['matchDate']?.toString();
    final DateTime? matchDate = date != null ? DateTime.parse(date) : null;
    return RefereeMatchDTO(
      estado: json['estado'] ?? '',
      fechayCampo: json['fechayCampo'] ?? '',
      jornada: json['jornada'],
      leagueId: json['leagueId'],
      ligayTorneo: json['ligayTorneo'] ?? '',
      matchDate: matchDate,
      matchId: json['matchId'],
      partido: json['partido'] ?? '',
      tournamentId: json['tournamentId'],
      local: json['local'],
      visit: json['visit'],
      teamIdLocal: json['teamIdLocal'],
      teamIdVisit: json['teamIdVisit'],
    );
  }

  RefereeMatchDTO copyWith({
    String? estado,
    String? fechayCampo,
    int? jornada,
    int? leagueId,
    String? ligayTorneo,
    DateTime? matchDate,
    int? matchId,
    String? partido,
    int? tournamentId,
    int? local,
    int? visit,
    int? teamIdLocal,
    int? teamIdVisit,
  }) {
    return RefereeMatchDTO(
      estado: estado ?? this.estado,
      fechayCampo: fechayCampo ?? this.fechayCampo,
      jornada: jornada ?? this.jornada,
      leagueId: leagueId ?? this.leagueId,
      ligayTorneo: ligayTorneo ?? this.ligayTorneo,
      matchDate: matchDate ?? this.matchDate,
      matchId: matchId ?? this.matchId,
      partido: partido ?? this.partido,
      tournamentId: tournamentId ?? this.tournamentId,
      local: local ?? this.local,
      visit: visit ?? this.visit,
      teamIdLocal: teamIdLocal ?? this.teamIdLocal,
      teamIdVisit: teamIdVisit ?? this.teamIdVisit,
    );
  }

  String get getFirstTeam => _firstTeam();

  String get getSecondTeam => _secondTeam();

  String _firstTeam() {
    if (partido.isEmpty) return '';
    final reverse = _reverseFirstTeam;
    final name = reverse.substring(reverse.indexOf(' '));
    return name.split('').reversed.join('');
  }

  String _secondTeam() {
    if (partido.isEmpty) return '';
    final team = _getSecondTeamToCompare;
    final name = team.substring(team.trim().indexOf(' '));
    return name;
  }

  String get _getFirstTeamToCompare =>
      partido.substring(0, partido.indexOf(' - '));

  String get getFirstScore =>
      _reverseFirstTeam.substring(0, _reverseFirstTeam.indexOf(' '));

  String get _reverseFirstTeam =>
      _getFirstTeamToCompare.trim().split('').reversed.join('');

  String get _getSecondTeamToCompare =>
      partido.substring(partido.indexOf(' - ') + 3);

  String get getSecondScore => _getSecondTeamToCompare
      .trim()
      .substring(0, _reverseFirstTeam.indexOf(' '));

  String get getFieldName => fechayCampo.isNotEmpty ? 
      fechayCampo.substring(fechayCampo.indexOf('- ') + 2) : "Campo no asignado";
  String get getDate =>
      '${matchDate?.year ?? '----'}-${_addZeroToInt(matchDate?.month)}-${_addZeroToInt(matchDate?.day)}';

  String get getTime =>
      '${_addZeroToInt(matchDate?.hour)}:${_addZeroToInt(matchDate?.minute)}';

  String _addZeroToInt(int? number) {
    if (number == null) {
      return '--';
    }
    return number < 10 ? '0$number' : '$number';
  }

  @override
  List<Object?> get props => [
        estado,
        fechayCampo,
        jornada,
        leagueId,
        ligayTorneo,
        matchDate,
        matchId,
        partido,
        tournamentId,
        local,
        visit,
        teamIdLocal,
        teamIdVisit,
      ];
}
