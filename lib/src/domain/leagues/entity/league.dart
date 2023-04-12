import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'league.g.dart';

@JsonSerializable()
class League extends Equatable {
  @JsonKey(name: 'estatusLeague')
  final String? leagueStatus;
  final String? leagueDescription;
  final int leagueId;
  @JsonKey(name: 'nameLeague')
  final String leagueName;
  final int? presidentId;
  final String? publicFlag;

  const League({
    required this.leagueStatus,
    this.leagueDescription,
    required this.leagueId,
    required this.leagueName,
    required this.presidentId,
    required this.publicFlag,
  });

  /// Connect the generated [_$LeagueFromJson] function to the `fromJson`
  /// factory.
  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);

  /// Connect the generated [_$LeagueToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LeagueToJson(this);

  static const empty = League(
      leagueStatus: '',
      leagueId: 0,
      leagueName: '',
      presidentId: 0,
      publicFlag: '');


  League copyWith({
    String? leagueStatus,
    String? leagueDescription,
    int? leagueId,
    String? leagueName,
    int? presidentId,
    String? publicFlag,
  }) {
    return League(
      leagueStatus: leagueStatus ?? this.leagueStatus,
      leagueDescription: leagueDescription ?? this.leagueDescription,
      leagueId: leagueId ?? this.leagueId,
      leagueName: leagueName ?? this.leagueName,
      presidentId: presidentId ?? this.presidentId,
      publicFlag: publicFlag ?? this.publicFlag,
    );
  }

  @override
  List<Object?> get props => [
        leagueStatus,
        leagueDescription,
        leagueId,
        leagueName,
        presidentId,
        publicFlag,
      ];
}
