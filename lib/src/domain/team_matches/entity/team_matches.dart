// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../matches/entity/match.dart';
import '../../team_tournament/entity/team_tournament.dart';

part 'team_matches.g.dart';
/*
 * Entity from TeamTournament
 */
@JsonSerializable()
class TeamMatche extends Equatable {
  final String? agreement;
  final String? enabledFlag;
  final String? flagQualificationRefeere;
  final MatchSpr? matchId;
  final String? punishmentMatches;
  final int? score;
  final int? scoreShutout;
  final int? teamMatchId;
  final TeamTournament? teamTournamentId;
  final int? teamType;
  final int? totalCl;
  const TeamMatche({
    this.agreement,
    this.enabledFlag,
    this.flagQualificationRefeere,
    this.matchId,
    this.punishmentMatches,
    this.score,
    this.scoreShutout,
    this.teamMatchId,
    this.teamTournamentId,
    this.teamType,
    this.totalCl,
  });

  

  TeamMatche copyWith({
    String? agreement,
    String? enabledFlag,
    String? flagQualificationRefeere,
    MatchSpr? matchId,
    String? punishmentMatches,
    int? score,
    int? scoreShutout,
    int? teamMatchId,
    TeamTournament? teamTournamentId,
    int? teamType,
    int? totalCl,
  }) {
    return TeamMatche(
      agreement: agreement ?? this.agreement,
      enabledFlag: enabledFlag ?? this.enabledFlag,
      flagQualificationRefeere: flagQualificationRefeere ?? this.flagQualificationRefeere,
      matchId: matchId ?? this.matchId,
      punishmentMatches: punishmentMatches ?? this.punishmentMatches,
      score: score ?? this.score,
      scoreShutout: scoreShutout ?? this.scoreShutout,
      teamMatchId: teamMatchId ?? this.teamMatchId,
      teamTournamentId: teamTournamentId ?? this.teamTournamentId,
      teamType: teamType ?? this.teamType,
      totalCl: totalCl ?? this.totalCl,
    );
  }

    /// Connect the generated [_$TeamMatcheFromJson] function to the `fromJson`
  /// factory.
  factory TeamMatche.fromJson(Map<String, dynamic> json) =>
      _$TeamMatcheFromJson(json);

  /// Connect the generated [_$TeamMatcheToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TeamMatcheToJson(this);

  @override
  List<Object?> get props {
    return [
      agreement,
      enabledFlag,
      flagQualificationRefeere,
      matchId,
      punishmentMatches,
      score,
      scoreShutout,
      teamMatchId,
      teamTournamentId,
      teamType,
      totalCl,
    ];
  }
}
