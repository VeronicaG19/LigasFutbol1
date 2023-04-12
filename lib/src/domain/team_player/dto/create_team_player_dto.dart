import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ligas_futbol_flutter/src/domain/player/entity/player.dart';
import '../../player/entity/player_image_profile.dart';
import '../../team/entity/team.dart';

part 'create_team_player_dto.g.dart';

@JsonSerializable()
class CreateTeamPlayerDTO extends Equatable{
  final String? numberApprovalFlag;
  final Player? playerId;
  final int? playerNumber;
  final int? playerPosition;
  final int? punishmentMatches;
  final PlayerPhotoId? registerPhotoId;
  final Team? teamId;
  final int? teamPlayerId;

  const CreateTeamPlayerDTO({
    this.numberApprovalFlag,
    this.playerId,
    this.playerNumber,
    this.playerPosition,
    this.punishmentMatches,
    this.registerPhotoId,
    this.teamId,
    this.teamPlayerId,
  });

  factory CreateTeamPlayerDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateTeamPlayerDTOFromJson(json);

  static const empty = CreateTeamPlayerDTO();

  bool get isEmpty => this == CreateTeamPlayerDTO.empty;

  bool get isNotEmpty => this != CreateTeamPlayerDTO.empty;

  Map<String, dynamic> toJson() => _$CreateTeamPlayerDTOToJson(this);

  CreateTeamPlayerDTO copyWith({
    String? numberApprovalFlag,
    Player? playerId,
    int? playerNumber,
    int? playerPosition,
    int? punishmentMatches,
    PlayerPhotoId? registerPhotoId,
    Team? teamId,
    int? teamPlayerId,
  }) {
    return CreateTeamPlayerDTO(
      numberApprovalFlag: numberApprovalFlag ?? this.numberApprovalFlag,
      playerId: playerId ?? this.playerId,
      playerNumber: playerNumber ?? this.playerNumber,
      playerPosition: playerPosition ?? this.playerPosition,
      punishmentMatches: punishmentMatches ?? this.punishmentMatches,
      registerPhotoId: registerPhotoId ?? this.registerPhotoId,
      teamId: teamId ?? this.teamId,
      teamPlayerId: teamPlayerId ?? this.teamPlayerId,
    );
  }

  @override
  List<Object?> get props => [
    numberApprovalFlag,
    playerId,
    playerNumber,
    playerPosition,
    punishmentMatches,
    registerPhotoId,
    teamId,
    teamPlayerId,
  ];

  Map<String, dynamic> ToJsonCreate(){
    final Map<String, dynamic> tmplyr = <String, dynamic>{};
    tmplyr['numberApprovalFlag'] = numberApprovalFlag;
    tmplyr['playerId'] = playerId?.toJsonUpdate();
    tmplyr['playerNumber'] = playerNumber;
    tmplyr['playerPosition'] = playerPosition;
    tmplyr['punishmentMatches'] = punishmentMatches;
    tmplyr['registerPhotoId'] = registerPhotoId;
    tmplyr['teamId'] = teamId?.toJson();
    tmplyr['teamPlayerId'] = teamPlayerId;
    return tmplyr;
  }
}