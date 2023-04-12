import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';

part 'tournament_by_team_dto.g.dart';

@JsonSerializable()
class TournamentByTeamDTO extends Equatable{
  final Tournament? tournament;
  final String? typeOfGame;
  final String? typeTournament;

  const TournamentByTeamDTO({
    this.tournament,
    this.typeOfGame,
    this.typeTournament,
  });

  factory TournamentByTeamDTO.fromJson(Map<String, dynamic> json) =>
      _$TournamentByTeamDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentByTeamDTOToJson(this);

  TournamentByTeamDTO copyWith({
    Tournament? tournament,
    String? typeOfGame,
    String? typeTournament,
  }) {
    return TournamentByTeamDTO(
      tournament: tournament ?? this.tournament,
      typeOfGame: typeOfGame ?? this.typeOfGame,
      typeTournament: typeTournament ?? this.typeTournament,
    );
  }

  @override
  List<Object?> get props => [
    tournament,
    typeOfGame,
    typeTournament,
  ];

}