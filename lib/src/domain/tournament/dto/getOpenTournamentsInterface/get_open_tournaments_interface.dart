// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_open_tournaments_interface.g.dart';

@JsonSerializable()
class GetOpenTournamentsInterface extends Equatable {
  final int? tournamentId;
  final String? tournamentName;
  final String? categoryName;
  final String? typeTournament;
  final String? tyoeOfTournament;
  final String? nameLeague;
  final int? leagueId;
  final int? numberPlayers;
  final int? timesByGame;

  const GetOpenTournamentsInterface({
    this.tournamentId,
    this.tournamentName,
    this.categoryName,
    this.typeTournament,
    this.tyoeOfTournament,
    this.nameLeague,
    this.leagueId,
    this.numberPlayers,
    this.timesByGame,
  });

  GetOpenTournamentsInterface copyWith({
    int? tournamentId,
    String? tournamentName,
    String? categoryName,
    String? typeTournament,
    String? tyoeOfTournament,
    String? nameLeague,
    int? leagueId,
    int? numberPlayers,
    int? timesByGame,
  }) {
    return GetOpenTournamentsInterface(
      tournamentId: tournamentId ?? this.tournamentId,
      tournamentName: tournamentName ?? this.tournamentName,
      categoryName: categoryName ?? this.categoryName,
      typeTournament: typeTournament ?? this.typeTournament,
      tyoeOfTournament: tyoeOfTournament ?? this.tyoeOfTournament,
      nameLeague: nameLeague ?? this.nameLeague,
      leagueId: leagueId ?? this.leagueId,
      numberPlayers: numberPlayers ?? this.numberPlayers,
      timesByGame: timesByGame ?? this.timesByGame,
    );
  }

  static const empty = GetOpenTournamentsInterface();

  /// Connect the generated [_$TournamentFromJson] function to the `fromJson`
  /// factory.
  factory GetOpenTournamentsInterface.fromJson(Map<String, dynamic> json) =>
      _$GetOpenTournamentsInterfaceFromJson(json);

  /// Connect the generated [_$TournamentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GetOpenTournamentsInterfaceToJson(this);

  @override
  List<Object?> get props {
    return [
      tournamentId,
      tournamentName,
      categoryName,
      typeTournament,
      tyoeOfTournament,
      nameLeague,
      leagueId,
      numberPlayers,
      timesByGame,
    ];
  }
}
