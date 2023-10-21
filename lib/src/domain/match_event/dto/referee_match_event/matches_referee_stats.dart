import 'package:equatable/equatable.dart';

class MatchesRefereeStats extends Equatable {
  final String categoryName;
  final int id;
  final int leagueId;
  final int matchId;
  final int partyId;
  final int refereeId;
  final int scoreLocal;
  final int scoreVisit;
  final String tarjetaAmarillas;
  final String tarjetasRojas;
  final String teamLocal;
  final String teamVisit;
  final String tournamentId;
  final int toutnamentId;

  const MatchesRefereeStats({
    required this.categoryName,
    required this.id,
    required this.leagueId,
    required this.matchId,
    required this.partyId,
    required this.refereeId,
    required this.scoreLocal,
    required this.scoreVisit,
    required this.tarjetaAmarillas,
    required this.tarjetasRojas,
    required this.teamLocal,
    required this.teamVisit,
    required this.tournamentId,
    required this.toutnamentId,
  });

  static const empty = MatchesRefereeStats(
      categoryName: '',
      id: 0,
      leagueId: 0,
      matchId: 0,
      partyId: 0,
      refereeId: 0,
      scoreLocal: 0,
      scoreVisit: 0,
      tarjetaAmarillas: '',
      tarjetasRojas: '',
      teamLocal: '',
      teamVisit: '',
      tournamentId: '',
      toutnamentId: 0);

  bool get isEmpty => this == MatchesRefereeStats.empty;

  bool get isNotEmpty => this != MatchesRefereeStats.empty;

  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
      'id': id,
      'leagueId': leagueId,
      'matchId': matchId,
      'partyId': partyId,
      'refereeId': refereeId,
      'scoreLocal': scoreLocal,
      'scoreVisit': scoreVisit,
      'tarjetaAmarillas': tarjetaAmarillas,
      'tarjetasRojas': tarjetasRojas,
      'teamLocal': teamLocal,
      'teamVisit': teamVisit,
      'tournamentId': tournamentId,
      'toutnamentId': toutnamentId,
    };
  }

  factory MatchesRefereeStats.fromJson(Map<String, dynamic> map) {
    return MatchesRefereeStats(
      categoryName: map['categoryName'] ?? '',
      id: map['id'] ?? 0,
      leagueId: map['leagueId'] ?? 0,
      matchId: map['matchId'] ?? 0,
      partyId: map['partyId'] ?? 0,
      refereeId: map['refereeId'] ?? 0,
      scoreLocal: map['scoreLocal'] ?? 0,
      scoreVisit: map['scoreVisit'] ?? 0,
      tarjetaAmarillas: map['tarjetaAmarillas'] ?? '0',
      tarjetasRojas: map['tarjetasRojas'] ?? '0',
      teamLocal: map['teamLocal'] ?? '',
      teamVisit: map['teamVisit'] ?? '',
      tournamentId: map['tournamentId'] ?? '',
      toutnamentId: map['toutnamentId'] ?? 0,
    );
  }

  @override
  List<Object> get props => [
        categoryName,
        id,
        leagueId,
        matchId,
        partyId,
        refereeId,
        scoreLocal,
        scoreVisit,
        tarjetaAmarillas,
        tarjetasRojas,
        teamLocal,
        teamVisit,
        tournamentId,
        toutnamentId,
      ];
}
