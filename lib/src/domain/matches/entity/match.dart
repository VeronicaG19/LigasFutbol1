import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'match.g.dart';
/*
 * Entity from Match
 */
@JsonSerializable()
class MatchSpr extends Equatable {
  final int? colRound;
  final String? enabledFlag;
  final int? eventId;
  final String? matchDate;
  final int? matchId;
  final int? matchNumber;
  final String? matchStartTime;
  final int? matchStatus;
  final String? matchType;
  final String? refereeAgreement;
  final int? round;
  final String? roundName;
  final int? roundNumber;
  final String? shootingDefinition;
  final int? typeMatch;
  const MatchSpr({
    this.colRound,
    this.enabledFlag,
    this.eventId,
    this.matchDate,
    this.matchId,
    this.matchNumber,
    this.matchStartTime,
    this.matchStatus,
    this.matchType,
    this.refereeAgreement,
    this.round,
    this.roundName,
    this.roundNumber,
    this.shootingDefinition,
    this.typeMatch,
  });

  MatchSpr copyWith({
    int? colRound,
    String? enabledFlag,
    int? eventId,
    String? matchDate,
    int? matchId,
    int? matchNumber,
    String? matchStartTime,
    int? matchStatus,
    String? matchType,
    String? refereeAgreement,
    int? round,
    String? roundName,
    int? roundNumber,
    String? shootingDefinition,
    int? typeMatch,
  }) {
    return MatchSpr(
      colRound: colRound ?? this.colRound,
      enabledFlag: enabledFlag ?? this.enabledFlag,
      eventId: eventId ?? this.eventId,
      matchDate: matchDate ?? this.matchDate,
      matchId: matchId ?? this.matchId,
      matchNumber: matchNumber ?? this.matchNumber,
      matchStartTime: matchStartTime ?? this.matchStartTime,
      matchStatus: matchStatus ?? this.matchStatus,
      matchType: matchType ?? this.matchType,
      refereeAgreement: refereeAgreement ?? this.refereeAgreement,
      round: round ?? this.round,
      roundName: roundName ?? this.roundName,
      roundNumber: roundNumber ?? this.roundNumber,
      shootingDefinition: shootingDefinition ?? this.shootingDefinition,
      typeMatch: typeMatch ?? this.typeMatch,
    );
  }


  /// Connect the generated [_$MatchSprFromJson] function to the `fromJson`
  /// factory.
  factory MatchSpr.fromJson(Map<String, dynamic> json) =>
      _$MatchSprFromJson(json);

  /// Connect the generated [_$MatchSprToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MatchSprToJson(this);

  @override
  List<Object?> get props {
    return [
      colRound,
      enabledFlag,
      eventId,
      matchDate,
      matchId,
      matchNumber,
      matchStartTime,
      matchStatus,
      matchType,
      refereeAgreement,
      round,
      roundName,
      roundNumber,
      shootingDefinition,
      typeMatch,
    ];
  }
}
