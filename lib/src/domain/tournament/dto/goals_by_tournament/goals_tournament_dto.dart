import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goals_tournament_dto.g.dart';

@JsonSerializable()
class GoalsTournamentDTO extends Equatable {
  final int? goals;
  final int? partyId;
  final String? player;
  @JsonKey(name: 'rownum')
  final String? rowNum;
  final int? scoringTableId;
  final String? team;
  final int? teamId;
  final int? teamTournamentId;

  const GoalsTournamentDTO({
    this.goals,
    this.partyId,
    this.player,
    this.rowNum,
    this.scoringTableId,
    this.team,
    this.teamId,
    this.teamTournamentId,
  });

  /// Connect the generated [_$GoalsTournamentDTOFromJson] function to the `fromJson`
  /// factory.
  factory GoalsTournamentDTO.fromJson(Map<String, dynamic> json) =>
      _$GoalsTournamentDTOFromJson(json);

  /// Connect the generated [_$GoalsTournamentDTOToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GoalsTournamentDTOToJson(this);

  GoalsTournamentDTO copyWith({
    int? goals,
    int? partyId,
    String? player,
    String? rowNum,
    int? scoringTableId,
    String? team,
    int? teamId,
    int? teamTournamentId,
  }) {
    return GoalsTournamentDTO(
      goals: goals ?? this.goals,
      partyId: partyId ?? this.partyId,
      player: player ?? this.player,
      rowNum: rowNum ?? this.rowNum,
      scoringTableId: scoringTableId ?? this.scoringTableId,
      team: team ?? this.team,
      teamId: teamId ?? this.teamId,
      teamTournamentId: teamTournamentId ?? this.teamTournamentId,
    );
  }

  @override
  List<Object?> get props => [
        goals,
        partyId,
        player,
        rowNum,
        scoringTableId,
        team,
        teamId,
        teamTournamentId,
      ];
}
