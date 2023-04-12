import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/entity/match.dart';

import '../../../referee_assigment/entity/referee_assigment.dart';
import '../../../team_matches/entity/team_matches.dart';


part 'MatchTeamMatchesRefereeDTO.g.dart';
/*
 * Entity from Match
 */
@JsonSerializable()
class MatchTeamMatchesRefereeDTO extends Equatable {
  final MatchSpr? match;
	final RefereeAssignment? refereeAssignment;
	final TeamMatche? teamMatchL;
	final TeamMatche? teamMatchV;

  const MatchTeamMatchesRefereeDTO({
    this.match,
    this.refereeAssignment,
    this.teamMatchL,
    this.teamMatchV,
  });

  MatchTeamMatchesRefereeDTO copyWith({
    MatchSpr? match,
    RefereeAssignment? refereeAssignment,
    TeamMatche? teamMatchL,
    TeamMatche? teamMatchV,
  }) {
    return MatchTeamMatchesRefereeDTO(
      match: match ?? this.match,
      refereeAssignment: refereeAssignment ?? this.refereeAssignment,
      teamMatchL: teamMatchL ?? this.teamMatchL,
      teamMatchV: teamMatchV ?? this.teamMatchV,
    );
  }

  /// Connect the generated [_$MatchTeamMatchesRefereeDTOFromJson] function to the `fromJson`
  /// factory.
  factory MatchTeamMatchesRefereeDTO.fromJson(Map<String, dynamic> json) =>
      _$MatchTeamMatchesRefereeDTOFromJson(json);

  /// Connect the generated [_$MatchTeamMatchesRefereeDTOToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MatchTeamMatchesRefereeDTOToJson(this);

  @override
  List<Object?> get props => [match, refereeAssignment, teamMatchL, teamMatchV];
}
