import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';

import '../../tournament/entity/tournament.dart';

part 'team_tournament.g.dart';

/*
 * Entity from TeamTournament
 */
@JsonSerializable()
class TeamTournament extends Equatable {
  final String? enabledFlag;
  final int? finalPosition;
  final int? goalsAgainst;
  final int? goalsInFavor;
  final int? lossGames;
  final int? lossGamesShootOut;
  final Team? oldId;
  final int? rankedNivel;
  final String? rankedTeam;
  final Team? teamId;
  final int? teamTournamentId;
  final int? tieGames;
  final Tournament? tournamentId;
  final int? winGames;
  final int? winGamesShootOut;

  const TeamTournament({
    this.enabledFlag,
    this.finalPosition,
    this.goalsAgainst,
    this.goalsInFavor,
    this.lossGames,
    this.lossGamesShootOut,
    this.oldId,
    this.rankedNivel,
    this.rankedTeam,
    this.teamId,
    this.teamTournamentId,
    this.tieGames,
    this.tournamentId,
    this.winGames,
    this.winGamesShootOut,
  });

  TeamTournament copyWith({
    String? enabledFlag,
    int? finalPosition,
    int? goalsAgainst,
    int? goalsInFavor,
    int? lossGames,
    int? lossGamesShootOut,
    Team? oldId,
    int? rankedNivel,
    String? rankedTeam,
    Team? teamId,
    int? teamTournamentId,
    int? tieGames,
    Tournament? tournamentId,
    int? winGames,
    int? winGamesShootOut,
  }) {
    return TeamTournament(
      enabledFlag: enabledFlag ?? this.enabledFlag,
      finalPosition: finalPosition ?? this.finalPosition,
      goalsAgainst: goalsAgainst ?? this.goalsAgainst,
      goalsInFavor: goalsInFavor ?? this.goalsInFavor,
      lossGames: lossGames ?? this.lossGames,
      lossGamesShootOut: lossGamesShootOut ?? this.lossGamesShootOut,
      oldId: oldId ?? this.oldId,
      rankedNivel: rankedNivel ?? this.rankedNivel,
      rankedTeam: rankedTeam ?? this.rankedTeam,
      teamId: teamId ?? this.teamId,
      teamTournamentId: teamTournamentId ?? this.teamTournamentId,
      tieGames: tieGames ?? this.tieGames,
      tournamentId: tournamentId ?? this.tournamentId,
      winGames: winGames ?? this.winGames,
      winGamesShootOut: winGamesShootOut ?? this.winGamesShootOut,
    );
  }

  static const empty = TeamTournament();

  bool get isEmpty => this == TeamTournament.empty;
  bool get isNotEmpty => this != TeamTournament.empty;

  /// Connect the generated [_$TeamTournamentFromJson] function to the `fromJson`
  /// factory.
  factory TeamTournament.fromJson(Map<String, dynamic> json) =>
      _$TeamTournamentFromJson(json);

  /// Connect the generated [_$TeamTournamentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TeamTournamentToJson(this);

  @override
  List<Object?> get props {
    return [
      enabledFlag,
      finalPosition,
      goalsAgainst,
      goalsInFavor,
      lossGames,
      lossGamesShootOut,
      oldId,
      rankedNivel,
      rankedTeam,
      teamId,
      teamTournamentId,
      tieGames,
      tournamentId,
      winGames,
      winGamesShootOut,
    ];
  }
}
