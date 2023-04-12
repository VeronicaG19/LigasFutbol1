// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category.dart';
import 'package:ligas_futbol_flutter/src/domain/document/entity/document.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/entity/league.dart';
import 'package:ligas_futbol_flutter/src/domain/scoring_system/entity/scoring_system.dart';

part 'tournament.g.dart';

@JsonSerializable()
class Tournament extends Equatable {
  final int? tournamentId;
  final String? tournamentName;
  final String? declain;
  final int? yellowCardFine;
  final int? redCardFine;
  final String? typeOfGame;
  final int? gameTimes;
  final int? durationByTime;
  final int? gameChanges;
  final String? unlimitedChanges;
  final String? typeTournament;
  final String? tournamentStatus;
  final int? breaksNumber;
  final int? breaksDuration;
  @JsonKey(name: 'startedplayyear')
  final String? startedPlayYear;
  final int? maxPlayers;
  final int? maxTeams;
  final String? tournamentPrivacy;
  final DateTime? inscriptionDate;
  final String? statusBegin;
  final int? rounds;
  @JsonKey(name: 'roundtrip')
  final int? roundTrip;
  final int? third;
  @JsonKey(name: 'dOrMForyellow')
  final int? dormForyellow;
  final String? temporaryReprimands;
  final String? daysMatches;
  @JsonKey(name: 'dOrMForred')
  final int? dormForred;
  final int? typeExpulsion;
  final String? activateBlueCard;
  final int? sanctionTime;
  final int? blueCardsAllowed;
  final int? numberOfFinalGames;
  final int? tieBreakType;
  @JsonKey(name: 'xxsprDocumentsList')
  final Document? documentId;
  final Category? categoryId;
  final League? leagueId;
  final ScoringSystem? scoringSystemId;
  final String? daysMatchesOrder;

  const Tournament(
      {this.tournamentId,
      this.tournamentName,
      this.declain,
      this.yellowCardFine,
      this.redCardFine,
      this.typeOfGame,
      this.gameTimes,
      this.durationByTime,
      this.gameChanges,
      this.unlimitedChanges,
      this.typeTournament,
      this.tournamentStatus,
      this.breaksNumber,
      this.breaksDuration,
      this.startedPlayYear,
      this.maxPlayers,
      this.maxTeams,
      this.tournamentPrivacy,
      this.inscriptionDate,
      this.statusBegin,
      this.rounds,
      this.roundTrip,
      this.third,
      this.dormForyellow,
      this.temporaryReprimands,
      this.daysMatches,
      this.dormForred,
      this.typeExpulsion,
      this.activateBlueCard,
      this.sanctionTime,
      this.blueCardsAllowed,
      this.numberOfFinalGames,
      this.tieBreakType,
      this.documentId,
      this.categoryId,
      this.leagueId,
      this.scoringSystemId,
      this.daysMatchesOrder});

  static const empty = Tournament();

  bool get isEmpty => this == Tournament.empty;

  bool get isNotEmpty => this != Tournament.empty;

  /// Connect the generated [_$TournamentFromJson] function to the `fromJson`
  /// factory.
  factory Tournament.fromJson(Map<String, dynamic> json) =>
      _$TournamentFromJson(json);

  /// Connect the generated [_$TournamentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TournamentToJson(this);

  Tournament copyWith(
      {int? tournamentId,
      String? tournamentName,
      String? declain,
      int? yellowCardFine,
      int? redCardFine,
      String? typeOfGame,
      int? gameTimes,
      int? durationByTime,
      int? gameChanges,
      String? unlimitedChanges,
      String? typeTournament,
      String? tournamentStatus,
      int? breaksNumber,
      int? breaksDuration,
      String? startedPlayYear,
      int? maxPlayers,
      int? maxTeams,
      String? tournamentPrivacy,
      DateTime? inscriptionDate,
      String? statusBegin,
      int? rounds,
      int? roundTrip,
      int? third,
      int? dormForyellow,
      String? temporaryReprimands,
      String? daysMatches,
      int? dormForred,
      int? typeExpulsion,
      String? activateBlueCard,
      int? sanctionTime,
      int? blueCardsAllowed,
      int? numberOfFinalGames,
      int? tieBreakType,
      Document? documentId,
      Category? categoryId,
      League? leagueId,
      ScoringSystem? scoringSystemId,
      String? daysMatchesOrder}) {
    return Tournament(
        tournamentId: tournamentId ?? this.tournamentId,
        tournamentName: tournamentName ?? this.tournamentName,
        declain: declain ?? this.declain,
        yellowCardFine: yellowCardFine ?? this.yellowCardFine,
        redCardFine: redCardFine ?? this.redCardFine,
        typeOfGame: typeOfGame ?? this.typeOfGame,
        gameTimes: gameTimes ?? this.gameTimes,
        durationByTime: durationByTime ?? this.durationByTime,
        gameChanges: gameChanges ?? this.gameChanges,
        unlimitedChanges: unlimitedChanges ?? this.unlimitedChanges,
        typeTournament: typeTournament ?? this.typeTournament,
        tournamentStatus: tournamentStatus ?? this.tournamentStatus,
        breaksNumber: breaksNumber ?? this.breaksNumber,
        breaksDuration: breaksDuration ?? this.breaksDuration,
        startedPlayYear: startedPlayYear ?? this.startedPlayYear,
        maxPlayers: maxPlayers ?? this.maxPlayers,
        maxTeams: maxTeams ?? this.maxTeams,
        tournamentPrivacy: tournamentPrivacy ?? this.tournamentPrivacy,
        inscriptionDate: inscriptionDate ?? this.inscriptionDate,
        statusBegin: statusBegin ?? this.statusBegin,
        rounds: rounds ?? this.rounds,
        roundTrip: roundTrip ?? this.roundTrip,
        third: third ?? this.third,
        dormForyellow: dormForyellow ?? this.dormForyellow,
        temporaryReprimands: temporaryReprimands ?? this.temporaryReprimands,
        daysMatches: daysMatches ?? this.daysMatches,
        dormForred: dormForred ?? this.dormForred,
        typeExpulsion: typeExpulsion ?? this.typeExpulsion,
        activateBlueCard: activateBlueCard ?? this.activateBlueCard,
        sanctionTime: sanctionTime ?? this.sanctionTime,
        blueCardsAllowed: blueCardsAllowed ?? this.blueCardsAllowed,
        numberOfFinalGames: numberOfFinalGames ?? this.numberOfFinalGames,
        tieBreakType: tieBreakType ?? this.tieBreakType,
        documentId: documentId ?? this.documentId,
        categoryId: categoryId ?? this.categoryId,
        leagueId: leagueId ?? this.leagueId,
        scoringSystemId: scoringSystemId ?? this.scoringSystemId,
        daysMatchesOrder: daysMatchesOrder ?? this.daysMatchesOrder);
  }

  @override
  List<Object?> get props => [
        tournamentId,
        tournamentName,
        declain,
        yellowCardFine,
        redCardFine,
        typeOfGame,
        gameTimes,
        durationByTime,
        gameChanges,
        unlimitedChanges,
        typeTournament,
        tournamentStatus,
        breaksNumber,
        breaksDuration,
        startedPlayYear,
        maxPlayers,
        maxTeams,
        tournamentPrivacy,
        inscriptionDate,
        statusBegin,
        rounds,
        roundTrip,
        third,
        dormForyellow,
        temporaryReprimands,
        daysMatches,
        dormForred,
        typeExpulsion,
        activateBlueCard,
        sanctionTime,
        blueCardsAllowed,
        numberOfFinalGames,
        tieBreakType,
        documentId,
        categoryId,
        leagueId,
        scoringSystemId,
        daysMatchesOrder
      ];

  Map<String, dynamic> tojsonUpdateCreate() {
    return <String, dynamic>{
      'tournamentId': tournamentId,
      'tournamentName': tournamentName,
      'declain': declain,
      'yellowCardFine': yellowCardFine,
      'redCardFine': redCardFine,
      'typeOfGame': typeOfGame,
      'gameTimes': gameTimes,
      'durationByTime': durationByTime,
      'gameChanges': gameChanges,
      'unlimitedChanges': unlimitedChanges,
      'typeTournament': typeTournament,
      'tournamentStatus': tournamentStatus,
      'breaksNumber': breaksNumber,
      'breaksDuration': breaksDuration,
      'startedPlayYear': startedPlayYear,
      'maxPlayers': maxPlayers,
      'maxTeams': maxTeams,
      'tournamentPrivacy': tournamentPrivacy,
      'inscriptionDate': inscriptionDate?.millisecondsSinceEpoch,
      'statusBegin': statusBegin,
      'rounds': rounds,
      'roundTrip': roundTrip,
      'third': third,
      'dormForyellow': dormForyellow,
      'temporaryReprimands': temporaryReprimands,
      'daysMatches': daysMatches,
      'dormForred': dormForred,
      'typeExpulsion': typeExpulsion,
      'activateBlueCard': activateBlueCard,
      'sanctionTime': sanctionTime,
      'blueCardsAllowed': blueCardsAllowed,
      'numberOfFinalGames': numberOfFinalGames,
      'tieBreakType': tieBreakType,
      'documentId': documentId?.toJson(),
      'categoryId': categoryId?.toJson(),
      'leagueId': leagueId?.toJson(),
      'scoringSystemId': scoringSystemId?.toJson(),
      'attribute5': daysMatchesOrder
    };
  }
}
