import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'qualifying_match_detail_dto.g.dart';

@JsonSerializable()
class QualifyingMatchDetailDTO extends Equatable {
  final int? endMaches;
  final int? matchNumber;
  final int? numberFinalsGame;
  final String? rounName;
  final int? round;
  final int? roundNumber;
  final int? roundtrip;
  final int? scoreLocal;
  final int? scoreVisit;
  final int? teamLocalId;
  final int? teamVisitId;
  final int? tieBreakType;
  final int? tournamentId;

  const QualifyingMatchDetailDTO({
    this.endMaches,
    this.matchNumber,
    this.numberFinalsGame,
    this.rounName,
    this.round,
    this.roundNumber,
    this.roundtrip,
    this.scoreLocal,
    this.scoreVisit,
    this.teamLocalId,
    this.teamVisitId,
    this.tieBreakType,
    this.tournamentId,
  });

  static const empty = QualifyingMatchDetailDTO();

  factory QualifyingMatchDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$QualifyingMatchDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => _$QualifyingMatchDetailDTOToJson(this);

  QualifyingMatchDetailDTO copyWith({
    int? endMaches,
    int? matchNumber,
    int? numberFinalsGame,
    String? rounName,
    int? round,
    int? roundNumber,
    int? roundtrip,
    int? scoreLocal,
    int? scoreVisit,
    int? teamLocalId,
    int? teamVisitId,
    int? tieBreakType,
    int? tournamentId,
  }) {
    return QualifyingMatchDetailDTO(
      endMaches: endMaches ?? this.endMaches,
      matchNumber: matchNumber ?? this.matchNumber,
      numberFinalsGame: numberFinalsGame ?? this.numberFinalsGame,
      rounName: rounName ?? this.rounName,
      round: round ?? this.round,
      roundNumber: roundNumber ?? this.roundNumber,
      roundtrip: roundtrip ?? this.roundtrip,
      scoreLocal: scoreLocal ?? this.scoreLocal,
      scoreVisit: scoreVisit ?? this.scoreVisit,
      teamLocalId: teamLocalId ?? this.teamLocalId,
      teamVisitId: teamVisitId ?? this.teamVisitId,
      tieBreakType: tieBreakType ?? this.tieBreakType,
      tournamentId: tournamentId ?? this.tournamentId,
    );
  }

  @override
  List<Object?> get props => [
        endMaches,
        matchNumber,
        numberFinalsGame,
        rounName,
        round,
        roundNumber,
        roundtrip,
        scoreLocal,
        scoreVisit,
        teamLocalId,
        teamVisitId,
        tieBreakType,
        tournamentId,
      ];
}
