import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'match_event_dto.g.dart';

@JsonSerializable()
class MatchEventDTO extends Equatable {
  final String? causalDescription;
  final String? eventType;
  final int? matchEventTime;
  final int? partyId;
  final int? partyId2;
  final int? teamMatchId;
  final String? timeType;

  const MatchEventDTO({
    this.causalDescription,
    this.eventType,
    this.matchEventTime,
    this.partyId,
    this.partyId2,
    this.teamMatchId,
    this.timeType,
  });

  MatchEventDTO copyWith({
    String? causalDescription,
    String? eventType,
    int? matchEventTime,
    int? partyId,
    int? partyId2,
    int? teamMatchId,
    String? timeType,
  }) {
    return MatchEventDTO(
      causalDescription: causalDescription ?? this.causalDescription,
      eventType: eventType ?? this.eventType,
      matchEventTime: matchEventTime ?? this.matchEventTime,
      partyId: partyId ?? this.partyId,
      partyId2: partyId2 ?? this.partyId2,
      teamMatchId: teamMatchId ?? this.teamMatchId,
      timeType: timeType ?? this.timeType,
    );
  }

  static const empty = MatchEventDTO();

  /// Connect the generated [_$TournamentFromJson] function to the `fromJson`
  /// factory.
  factory MatchEventDTO.fromJson(Map<String, dynamic> json) =>
      _$MatchEventDTOFromJson(json);

  /// Connect the generated [_$TournamentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MatchEventDTOToJson(this);

  @override
  List<Object?> get props => [
        causalDescription,
        eventType,
        matchEventTime,
        partyId,
        partyId2,
        teamMatchId,
        timeType,
      ];
}
