import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_into_team_dto.g.dart';

@JsonSerializable()
class PlayerIntoTeamDTO extends Equatable {
  final String? fullName;
  final int? partyId;
  final int? playerId;
  final String? teamName;
  const PlayerIntoTeamDTO({
    this.fullName,
    this.partyId,
    this.playerId,
    this.teamName,
  });

  PlayerIntoTeamDTO copyWith({
    String? fullName,
    int? partyId,
    int? playerId,
    String? teamName,
  }) {
    return PlayerIntoTeamDTO(
      fullName: fullName ?? this.fullName,
      partyId: partyId ?? this.partyId,
      playerId: playerId ?? this.playerId,
      teamName: teamName ?? this.teamName,
    );
  }

 /// Connect the generated [_$PlayerIntoTeamDTOFromJson] function to the `fromJson`
  /// factory.
  factory PlayerIntoTeamDTO.fromJson(Map<String, dynamic> json) =>
      _$PlayerIntoTeamDTOFromJson(json);

  /// Connect the generated [_$PlayerIntoTeamDTOToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PlayerIntoTeamDTOToJson(this);

  @override
  List<Object?> get props => [fullName, partyId, playerId, teamName];
}
