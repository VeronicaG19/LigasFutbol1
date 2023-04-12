import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tournament_by_player.g.dart';

@JsonSerializable()
class TournamentByPlayer extends Equatable {
  final int? teamId;
  final int? teamTournamentId;
  final int? tournamentId;

  final String? tournamentName;

  const TournamentByPlayer({
    this.teamId,
    this.teamTournamentId,
    this.tournamentId,
    this.tournamentName,
  });

  /// Connect the generated [_$TournamentByPlayerFromJson] function to the `fromJson`
  /// factory.
  factory TournamentByPlayer.fromJson(Map<String, dynamic> json) =>
      _$TournamentByPlayerFromJson(json);

  /// Connect the generated [_$TournamentByPlayerToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TournamentByPlayerToJson(this);

  TournamentByPlayer copyWith({
    int? teamId,
    int? teamTournamentId,
    int? tournamentId,
    String? tournamentName,
  }) {
    return TournamentByPlayer(
      teamId: teamId ?? this.teamId,
      teamTournamentId: teamTournamentId ?? this.teamTournamentId,
      tournamentId: tournamentId ?? this.tournamentId,
      tournamentName: tournamentName ?? this.tournamentName,
    );
  }

  @override
  List<Object?> get props => [
        teamId,
        teamTournamentId,
        tournamentId,
        tournamentName,
      ];
}
