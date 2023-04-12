import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tournament_champion_dto.g.dart';

@JsonSerializable()
class TournamentChampionDTO extends Equatable{
  final int? teamId;
  final String? teamName;
  final int? teamTournamentId;
  final int? tournamentId;

  const TournamentChampionDTO({
    this.teamId,
    this.teamName,
    this.teamTournamentId,
    this.tournamentId,
  });

  factory TournamentChampionDTO.fromJson(Map<String, dynamic> json) =>
      _$TournamentChampionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentChampionDTOToJson(this);

  TournamentChampionDTO copyWith({
    int? teamId,
    String? teamName,
    int? teamTournamentId,
    int? tournamentId,
  }) {
    return TournamentChampionDTO(
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      teamTournamentId: teamTournamentId ?? this.teamTournamentId,
      tournamentId: tournamentId ?? this.tournamentId,
    );
  }
  @override
  List<Object?> get props => [
    teamId,
    teamName,
    teamTournamentId,
    tournamentId,
  ];
  static const empty = TournamentChampionDTO(
    teamId: 0,
    teamName: '',
    teamTournamentId: 0,
    tournamentId: 0,
  );

}