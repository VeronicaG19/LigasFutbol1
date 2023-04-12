import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'start_match_res_dto.g.dart';

@JsonSerializable()
class StartMatchResDTO extends Equatable {
  final int? colRound;
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

  const StartMatchResDTO({
    this.colRound,
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

  StartMatchResDTO copyWith({
    int? colRound,
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
    return StartMatchResDTO(
      colRound: colRound ?? this.colRound,
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

  static const empty = StartMatchResDTO();

  /// Connect the generated [_$TournamentFromJson] function to the `fromJson`
  /// factory.
  factory StartMatchResDTO.fromJson(Map<String, dynamic> json) =>
      _$StartMatchResDTOFromJson(json);

  /// Connect the generated [_$TournamentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$StartMatchResDTOToJson(this);

  @override
  List<Object?> get props => [
        colRound,
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
