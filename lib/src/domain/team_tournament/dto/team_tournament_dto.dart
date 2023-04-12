import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_tournament_dto.g.dart';

@JsonSerializable()
class TeamTournamentDto extends Equatable {
  final String? category;
  final int? finalPosition;
  final int? goalsAgainst;
  final int? goalsInFavor;
  final int? lossGames;
  final int? lossGamesShootOut;
  final int? oldId;
  final int? rankedNivel;
  final String? rankedTeam;
  final String? representant;
  final int? teamId;
  final String? teamLogo;
  final String? teamName;
  final int? teamTournamentId;
  final int? tieGames;
  final int? tournamentId;
  final int? winGames;
  final int? winGamesShootOut;

  const TeamTournamentDto({
    this.category,
    this.finalPosition,
    this.goalsAgainst,
    this.goalsInFavor,
    this.lossGames,
    this.lossGamesShootOut,
    this.oldId,
    this.rankedNivel,
    this.rankedTeam,
    this.representant,
    this.teamId,
    this.teamLogo,
    this.teamName,
    this.teamTournamentId,
    this.tieGames,
    this.tournamentId,
    this.winGames,
    this.winGamesShootOut,
  });

  TeamTournamentDto copyWith({
    String? category,
    int? finalPosition,
    int? goalsAgainst,
    int? goalsInFavor,
    int? lossGames,
    int? lossGamesShootOut,
    int? oldId,
    int? rankedNivel,
    String? rankedTeam,
    String? representant,
    int? teamId,
    String? teamLogo,
    String? teamName,
    int? teamTournamentId,
    int? tieGames,
    int? tournamentId,
    int? winGames,
    int? winGamesShootOut,
  }) {
    return TeamTournamentDto(
      category: category ?? this.category,
      finalPosition: finalPosition ?? this.finalPosition,
      goalsAgainst: goalsAgainst ?? this.goalsAgainst,
      goalsInFavor: goalsInFavor ?? this.goalsInFavor,
      lossGames: lossGames ?? this.lossGames,
      lossGamesShootOut: lossGamesShootOut ?? this.lossGamesShootOut,
      oldId: oldId ?? this.oldId,
      rankedNivel: rankedNivel ?? this.rankedNivel,
      rankedTeam: rankedTeam ?? this.rankedTeam,
      representant: representant ?? this.representant,
      teamId: teamId ?? this.teamId,
      teamLogo: teamLogo ?? this.teamLogo,
      teamName: teamName ?? this.teamName,
      teamTournamentId: teamTournamentId ?? this.teamTournamentId,
      tieGames: tieGames ?? this.tieGames,
      tournamentId: tournamentId ?? this.tournamentId,
      winGames: winGames ?? this.winGames,
      winGamesShootOut: winGamesShootOut ?? this.winGamesShootOut,
    );
  }

  /// Connect the generated [_$TeamTournamentDtoFromJson] function to the `fromJson`
  /// factory.
  factory TeamTournamentDto.fromJson(Map<String, dynamic> json) =>
      _$TeamTournamentDtoFromJson(json);

  /// Connect the generated [_$TeamTournamentDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TeamTournamentDtoToJson(this);

  @override
  List<Object?> get props {
    return [
      category,
      finalPosition,
      goalsAgainst,
      goalsInFavor,
      lossGames,
      lossGamesShootOut,
      oldId,
      rankedNivel,
      rankedTeam,
      representant,
      teamId,
      teamLogo,
      teamName,
      teamTournamentId,
      tieGames,
      tournamentId,
      winGames,
      winGamesShootOut,
    ];
  }
}
