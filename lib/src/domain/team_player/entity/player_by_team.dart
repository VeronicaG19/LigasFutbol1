import 'package:equatable/equatable.dart';

class PlayerByTeam extends Equatable {
  final String playerName;
  final int playerNumber;
  final String playerPhoto;
  final int playerId;
  final String playerPosition;
  final int teamId;
  final String teamName;
  final int teamPlayerId;

  const PlayerByTeam({
    required this.playerName,
    required this.playerNumber,
    required this.playerPhoto,
    required this.playerId,
    required this.playerPosition,
    required this.teamId,
    required this.teamName,
    required this.teamPlayerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'namePLayer': playerName,
      'numberPlayer': playerNumber,
      'phothoPLayer': playerPhoto,
      'playerId': playerId,
      'positionPlayer': playerPosition,
      'teamId': teamId,
      'teamName': teamName,
      'teamPlayerId': teamPlayerId,
    };
  }

  factory PlayerByTeam.fromJson(Map<String, dynamic> json) {
    return PlayerByTeam(
      playerName: json['namePLayer'] ?? '',
      playerNumber: json['numberPlayer'] ?? 0,
      playerPhoto: json['phothoPLayer'] ?? '',
      playerId: json['playerId'] ?? 0,
      playerPosition: json['positionPlayer'] ?? '',
      teamId: json['teamId'] ?? 0,
      teamName: json['teamName'] ?? '',
      teamPlayerId: json['teamPlayerId'] ?? 0,
    );
  }

  PlayerByTeam copyWith({
    String? playerName,
    int? playerNumber,
    String? playerPhoto,
    int? playerId,
    String? playerPosition,
    int? teamId,
    String? teamName,
    int? teamPlayerId,
  }) {
    return PlayerByTeam(
      playerName: playerName ?? this.playerName,
      playerNumber: playerNumber ?? this.playerNumber,
      playerPhoto: playerPhoto ?? this.playerPhoto,
      playerId: playerId ?? this.playerId,
      playerPosition: playerPosition ?? this.playerPosition,
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      teamPlayerId: teamPlayerId ?? this.teamPlayerId,
    );
  }

  @override
  List<Object> get props => [
        playerName,
        playerNumber,
        playerPhoto,
        playerId,
        playerPosition,
        teamId,
        teamName,
        teamPlayerId,
      ];
}
