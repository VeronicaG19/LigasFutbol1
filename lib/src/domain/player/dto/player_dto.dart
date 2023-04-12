import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_dto.g.dart';

@JsonSerializable()
class PlayerDTO extends Equatable {
  final String? fullName;
  final int? partyId;
  final int? playerId;
  final String? teamName;

  const PlayerDTO({
    this.fullName,
    this.partyId,
    this.playerId,
    this.teamName,
  });

  PlayerDTO copyWith({
    String? fullName,
    int? partyId,
    int? playerId,
    String? teamName,
  }) {
    return PlayerDTO(
      fullName: fullName ?? this.fullName,
      partyId: partyId ?? this.partyId,
      playerId: playerId ?? this.playerId,
      teamName: teamName ?? this.teamName,
    );
  }

  static const empty = PlayerDTO();

  /// Connect the generated [_$TournamentFromJson] function to the `fromJson`
  /// factory.
  factory PlayerDTO.fromJson(Map<String, dynamic> json) =>
      _$PlayerDTOFromJson(json);

  /// Connect the generated [_$TournamentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PlayerDTOToJson(this);

  @override
  List<Object?> get props => [
        fullName,
        partyId,
        playerId,
        teamName,
      ];
}
