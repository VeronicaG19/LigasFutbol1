import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'match_event_res_dto.g.dart';

@JsonSerializable()
class MatchEventResDTO extends Equatable {
  final int? teamMatchId;
  final String? causalDescription;
  final int? compensationTime;
  final int? matchEventId;
  final int? matchEventTime;
  final String? matchEventTimeDesc;
  final String? matchEventTimeUnit;
  final String? matchEventType;

  const MatchEventResDTO({
    this.teamMatchId,
    this.causalDescription,
    this.compensationTime,
    this.matchEventId,
    this.matchEventTime,
    this.matchEventTimeDesc,
    this.matchEventTimeUnit,
    this.matchEventType,
  });

  MatchEventResDTO copyWith({
    int? teamMatchId,
    String? causalDescription,
    int? compensationTime,
    int? matchEventId,
    int? matchEventTime,
    String? matchEventTimeDesc,
    String? matchEventTimeUnit,
    String? matchEventType,
  }) {
    return MatchEventResDTO(
      causalDescription: causalDescription ?? causalDescription,
      compensationTime: compensationTime ?? compensationTime,
      matchEventId: matchEventId ?? matchEventId,
      matchEventTime: matchEventTime ?? matchEventTime,
      matchEventTimeDesc: matchEventTimeDesc ?? matchEventTimeDesc,
      matchEventTimeUnit: matchEventTimeUnit ?? matchEventTimeUnit,
      matchEventType: matchEventType ?? matchEventType,
      teamMatchId: teamMatchId ?? teamMatchId
    );
  }

  static const empty = MatchEventResDTO();

  /// Connect the generated [_$TournamentFromJson] function to the `fromJson`
  /// factory.
  factory MatchEventResDTO.fromJson(Map<String, dynamic> json) =>
      _$MatchEventResDTOFromJson(json);

  /// Connect the generated [_$TournamentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MatchEventResDTOToJson(this);

  @override
  List<Object?> get props => [
        teamMatchId,
        causalDescription,
        compensationTime,
        matchEventId,
        matchEventTime,
        matchEventTimeDesc,
        matchEventTimeUnit,
        matchEventType,
      ];
}
