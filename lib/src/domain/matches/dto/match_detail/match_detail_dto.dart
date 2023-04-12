import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'match_detail_dto.g.dart';

@JsonSerializable()
class MatchDetailDTO extends Equatable {
  final String? localTeam;
  final int? matchId;
  final int? scoreLocal;
  final int? scoreVisit;
  final int? teamMatchLocal;
  final int? teamMatchVisit;
  final String? visitTeam;

  const MatchDetailDTO({
    this.localTeam,
    this.matchId,
    this.scoreLocal,
    this.scoreVisit,
    this.teamMatchLocal,
    this.teamMatchVisit,
    this.visitTeam,
  });

  MatchDetailDTO copyWith({
    String? localTeam,
    int? matchId,
    int? scoreLocal,
    int? scoreVisit,
    int? teamMatchLocal,
    int? teamMatchVisit,
    String? visitTeam,
  }) {
    return MatchDetailDTO(
      localTeam: localTeam ?? localTeam,
      matchId: matchId ?? matchId,
      scoreLocal: scoreLocal ?? scoreLocal,
      scoreVisit: scoreVisit ?? scoreVisit,
      teamMatchLocal: teamMatchLocal ?? teamMatchLocal,
      teamMatchVisit: teamMatchVisit ?? teamMatchVisit,
      visitTeam: visitTeam ?? visitTeam,
    );
  }

  static const empty = MatchDetailDTO();

  /// Connect the generated [_$TournamentFromJson] function to the `fromJson`
  /// factory.
  factory MatchDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$MatchDetailDTOFromJson(json);

  /// Connect the generated [_$TournamentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MatchDetailDTOToJson(this);

  @override
  List<Object?> get props => [
        localTeam,
        matchId,
        scoreLocal,
        scoreVisit,
        teamMatchLocal,
        teamMatchVisit,
        visitTeam,
      ];
}
