import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_rol_match_DTO.g.dart';

/*
 * DTO from Match Detail
 */
@JsonSerializable()
class DeatilRolMatchDTO extends Equatable {
  final String? dateMatch;
  final String? fieldMatch;
  final int? fieldMatchId;
  final String? localTeam;
  final int? matchId;
  final int? refereeAssigmentId;
  final int? refereeId;
  final String? refereeName;
  final int? roundNumber;
  final String? score;
  final int? teamMatchLocalId;
  final int? teamMatchVisitId;
  final String? teamVisit;
  final String? uniformLocal;
  final String? uniformVisit;
  final int? requestFieldId;
  final String? statusRequestField;
  final int? requestRefereeId;
  final String? statusRequestReferee;
  const DeatilRolMatchDTO({
    this.dateMatch,
    this.fieldMatch,
    this.fieldMatchId,
    this.localTeam,
    this.matchId,
    this.refereeAssigmentId,
    this.refereeId,
    this.refereeName,
    this.roundNumber,
    this.score,
    this.teamMatchLocalId,
    this.teamMatchVisitId,
    this.teamVisit,
    this.uniformLocal,
    this.uniformVisit,
    this.requestFieldId,
    this.statusRequestField,
    this.requestRefereeId,
    this.statusRequestReferee,
  });

  static const empty = DeatilRolMatchDTO();

  DeatilRolMatchDTO copyWith({
    String? dateMatch,
    String? fieldMatch,
    int? fieldMatchId,
    String? localTeam,
    int? matchId,
    int? refereeAssigmentId,
    int? refereeId,
    String? refereeName,
    int? roundNumber,
    String? score,
    int? teamMatchLocalId,
    int? teamMatchVisitId,
    int? requestFieldId,
    String? teamVisit,
    String? uniformLocal,
    String? uniformVisit,
    String? statusRequestField,
    int? requestRefereeId,
    String? statusRequestReferee,
  }) {
    return DeatilRolMatchDTO(
        dateMatch: dateMatch ?? this.dateMatch,
        fieldMatch: fieldMatch ?? this.fieldMatch,
        fieldMatchId: fieldMatchId ?? this.fieldMatchId,
        localTeam: localTeam ?? this.localTeam,
        matchId: matchId ?? this.matchId,
        refereeAssigmentId: refereeAssigmentId ?? this.refereeAssigmentId,
        refereeId: refereeId ?? this.refereeId,
        refereeName: refereeName ?? this.refereeName,
        roundNumber: roundNumber ?? this.roundNumber,
        score: score ?? this.score,
        teamMatchLocalId: teamMatchLocalId ?? this.teamMatchLocalId,
        teamMatchVisitId: teamMatchVisitId ?? this.teamMatchVisitId,
        teamVisit: teamVisit ?? this.teamVisit,
        uniformLocal: uniformLocal ?? this.uniformLocal,
        uniformVisit: uniformVisit ?? this.uniformVisit,
        statusRequestField: statusRequestField ?? this.statusRequestField,
        requestFieldId: requestFieldId ?? this.requestFieldId,
        requestRefereeId: requestRefereeId ?? this.requestRefereeId,
        statusRequestReferee:
            statusRequestReferee ?? this.statusRequestReferee);
  }

  /// Connect the generated [_$DeatilRolMatchDTOFromJson] function to the `fromJson`
  /// factory.
  factory DeatilRolMatchDTO.fromJson(Map<String, dynamic> json) =>
      _$DeatilRolMatchDTOFromJson(json);

  /// Connect the generated [_$DeatilRolMatchDTOToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DeatilRolMatchDTOToJson(this);

  @override
  List<Object?> get props {
    return [
      dateMatch,
      fieldMatch,
      fieldMatchId,
      localTeam,
      matchId,
      refereeAssigmentId,
      refereeId,
      refereeName,
      roundNumber,
      score,
      teamMatchLocalId,
      teamMatchVisitId,
      teamVisit,
      uniformLocal,
      uniformVisit,
      requestFieldId,
      statusRequestField,
      requestRefereeId,
      statusRequestReferee,
    ];
  }
}
