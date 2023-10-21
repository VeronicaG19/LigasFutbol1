import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scoring_tournament_dto.g.dart';

@JsonSerializable()
class ScoringTournamentDTO extends Equatable {
  final int? tournamentId;
  final String? team;
  @JsonKey(name: 'rownum')
  final String? rowNum;
  final int? pg;
  final int? pe;
  final int? pp;
  final int? pps;
  final int? gf;
  final int? gc;
  final int? dif;
  final int? pts;
  final int? pj;

  final int? pgs;
  final int? typeOfGame;

  const ScoringTournamentDTO({
    this.tournamentId,
    this.team,
    this.rowNum,
    this.pg,
    this.pe,
    this.pp,
    this.pps,
    this.gf,
    this.gc,
    this.dif,
    this.pts,
    this.pj,
    this.pgs,
    this.typeOfGame,
  });
  static const empty = ScoringTournamentDTO();

  /// Connect the generated [_$ScoringTournamentDTOFromJson] function to the `fromJson`
  /// factory.
  factory ScoringTournamentDTO.fromJson(Map<String, dynamic> json) =>
      _$ScoringTournamentDTOFromJson(json);

  /// Connect the generated [_$ScoringTournamentDTOToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ScoringTournamentDTOToJson(this);

  ScoringTournamentDTO copyWith({
    int? tournamentId,
    String? team,
    String? rowNum,
    int? pg,
    int? pe,
    int? pp,
    int? pps,
    int? gf,
    int? gc,
    int? dif,
    int? pts,
    int? pj,
    int? pgs,
    int? typeOfGame,
  }) {
    return ScoringTournamentDTO(
      tournamentId: tournamentId ?? this.tournamentId,
      team: team ?? this.team,
      rowNum: rowNum ?? this.rowNum,
      pg: pg ?? this.pg,
      pe: pe ?? this.pe,
      pp: pp ?? this.pp,
      pps: pps ?? this.pps,
      gf: gf ?? this.gf,
      gc: gc ?? this.gc,
      dif: dif ?? this.dif,
      pts: pts ?? this.pts,
      pj: pj ?? this.pj,
      pgs: pgs ?? this.pgs,
      typeOfGame: typeOfGame ?? this.typeOfGame,
    );
  }

  @override
  List<Object?> get props => [
        tournamentId,
        team,
        rowNum,
        pg,
        pe,
        pp,
        pps,
        gf,
        gc,
        dif,
        pts,
        pj,
        pgs,
        typeOfGame,
      ];
}
