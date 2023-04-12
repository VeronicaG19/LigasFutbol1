import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scoring_table_dto.g.dart';

@JsonSerializable()
class ScroginTableDTO extends Equatable {
  final String? fullName;
  final int? numberGoalsScored;
  final String? teamName;
  final int? teamId;
  final int? teamTournamentId;
  const ScroginTableDTO({
    this.fullName,
    this.numberGoalsScored,
    this.teamName,
    this.teamId,
    this.teamTournamentId
  });

  

  ScroginTableDTO copyWith({
    String? fullName,
    int? numberGoalsScored,
    String? teamName,
    int? teamId,
    int? teamTournamentId
  }) {
    return ScroginTableDTO(
      fullName: fullName ?? this.fullName,
      numberGoalsScored: numberGoalsScored ?? this.numberGoalsScored,
      teamName: teamName ?? this.teamName,
      teamId: teamId ?? this.teamId,
      teamTournamentId: teamTournamentId ?? this.teamTournamentId
    );
  }

   /// Connect the generated [_$ScroginTableDTOFromJson] function to the `fromJson`
  /// factory.
  factory ScroginTableDTO.fromJson(Map<String, dynamic> json) => _$ScroginTableDTOFromJson(json);

  /// Connect the generated [_$ScroginTableDTOToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ScroginTableDTOToJson(this);

  @override
  List<Object?> get props => [fullName, numberGoalsScored, teamName, teamTournamentId, teamId];
}
