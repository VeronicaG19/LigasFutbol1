import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'referee_match_event_dto.g.dart';

@JsonSerializable()
class RefereeMatchEventDTO extends Equatable{
  final String? causalDesc;
  final String? eventType;
  final String? fullName;
  final String? fullName2;
  final int? matchEventTime;

  const RefereeMatchEventDTO({
    this.causalDesc,
    this.eventType,
    this.fullName,
    this.fullName2,
    this.matchEventTime,
  });

  factory RefereeMatchEventDTO.fromJson(Map<String, dynamic> json) =>
      _$RefereeMatchEventDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RefereeMatchEventDTOToJson(this);

  RefereeMatchEventDTO copyWith({
    String? causalDesc,
    String? eventType,
    String? fullName,
    String? fullName2,
    int? matchEventTime,
  }) {
    return RefereeMatchEventDTO(
      causalDesc: causalDesc ?? this.causalDesc,
      eventType: eventType ?? this.eventType,
      fullName: fullName ?? this.fullName,
      fullName2: fullName2 ?? this.fullName2,
      matchEventTime: matchEventTime ?? this.matchEventTime,
    );
}

  @override
  List<Object?> get props => [
    causalDesc,
    eventType,
    fullName,
    fullName2,
    matchEventTime,
  ];
}