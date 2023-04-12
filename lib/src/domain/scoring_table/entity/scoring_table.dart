import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../team_tournament/entity/team_tournament.dart';

part 'scoring_table.g.dart';

@JsonSerializable()
class ScoringTable extends Equatable {

  final String? enabledFlag;
  final int? numberGoalsScored;
  final int? partyId;
  final int? scoringTableId;
  final TeamTournament? teamTournamentId;
  const ScoringTable({
    this.enabledFlag,
    this.numberGoalsScored,
    this.partyId,
    this.scoringTableId,
    this.teamTournamentId,
  });

  

  ScoringTable copyWith({
    String? enabledFlag,
    int? numberGoalsScored,
    int? partyId,
    int? scoringTableId,
    TeamTournament? teamTournamentId,
  }) {
    return ScoringTable(
      enabledFlag: enabledFlag ?? this.enabledFlag,
      numberGoalsScored: numberGoalsScored ?? this.numberGoalsScored,
      partyId: partyId ?? this.partyId,
      scoringTableId: scoringTableId ?? this.scoringTableId,
      teamTournamentId: teamTournamentId ?? this.teamTournamentId,
    );
  }

  /// Connect the generated [_$ScoringTableFromJson] function to the `fromJson`
  /// factory.
  factory ScoringTable.fromJson(Map<String, dynamic> json) => _$ScoringTableFromJson(json);

  /// Connect the generated [_$ScoringTableToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ScoringTableToJson(this);

  static const empty = ScoringTable();

  @override
  List<Object?> get props {
    return [
      enabledFlag,
      numberGoalsScored,
      partyId,
      scoringTableId,
      teamTournamentId,
    ];
  }
}
