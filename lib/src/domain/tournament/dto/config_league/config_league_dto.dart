import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config_league_dto.g.dart';

@JsonSerializable()
class ConfigLeagueDTO extends Equatable{

  final String? matchForRound;
  final String? numberOrFinals;
  final String? rounds;
  final String? tieBreakerType;
  final int? tournamentId;

  const ConfigLeagueDTO({
    this.matchForRound,
    this.numberOrFinals,
    this.rounds,
    this.tieBreakerType,
    this.tournamentId,
  });

  factory ConfigLeagueDTO.fromJson(Map<String, dynamic> json) =>
      _$ConfigLeagueDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigLeagueDTOToJson(this);

  static const empty = ConfigLeagueDTO(
    tournamentId: 0,
  );

  ConfigLeagueDTO copyWith({
    String? matchForRound,
    String? numberOrFinals,
    String? rounds,
    String? tieBreakerType,
    int? tournamentId,
  }) {
    return ConfigLeagueDTO(
      matchForRound: matchForRound ?? this.matchForRound,
      numberOrFinals: numberOrFinals ?? this.numberOrFinals,
      rounds: rounds ?? this.rounds,
      tieBreakerType: tieBreakerType ?? this.tieBreakerType,
      tournamentId: tournamentId ?? this.tournamentId,
    );
  }
  @override
  List<Object?> get props => [
    matchForRound,
    numberOrFinals,
    rounds,
    tieBreakerType,
    tournamentId,
  ];

}