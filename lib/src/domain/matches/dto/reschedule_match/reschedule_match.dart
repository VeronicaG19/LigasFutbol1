import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reschedule_match.g.dart';

@JsonSerializable()
class RescheduleMatchDTO extends Equatable {
  final int? matchId;
  final DateTime? reagendMatch;
  final String? reazon;

  const RescheduleMatchDTO({
    this.matchId,
    this.reagendMatch,
    this.reazon,
  });

  /// Connect the generated [_$MatchesByPlayerDTOFromJson] function to the `fromJson`
  /// factory.
  factory RescheduleMatchDTO.fromJson(Map<String, dynamic> json) =>
      _$RescheduleMatchDTOFromJson(json);

  /// Connect the generated [_$RescheduleMatchDTOToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RescheduleMatchDTOToJson(this);

  static const empty = RescheduleMatchDTO();

  RescheduleMatchDTO copyWith(
      {int? matchId, DateTime? reagendMatch, String? reazon}) {
    return RescheduleMatchDTO(
      matchId: matchId ?? this.matchId,
      reagendMatch: reagendMatch ?? this.reagendMatch,
      reazon: reazon ?? this.reazon,
    );
  }

  @override
  List<Object?> get props => [
        matchId,
        reagendMatch,
        reazon,
      ];
}
