import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'match_role_dto.g.dart';

@JsonSerializable()
class MatchRoleDTO extends Equatable {

  final DateTime? dateMatch;
  final int? fieldId;
  final int? refereeId;
  final int? roundNumber;
  final int? scoreLocal;
  final int? scoreVisit;
  final int? teamLocalId;
  final int? teamVisitId;

  const MatchRoleDTO({
    this.dateMatch,
    this.fieldId,
    this.refereeId,
    this.roundNumber,
    this.scoreLocal,
    this.scoreVisit,
    this.teamLocalId,
    this.teamVisitId,
  });


  MatchRoleDTO copyWith({
    DateTime? dateMatch,
    int? fieldId,
    int? refereeId,
    int? roundNumber,
    int? scoreLocal,
    int? scoreVisit,
    int? teamLocalId,
    int? teamVisitId,
  }) {
    return MatchRoleDTO(
      dateMatch: dateMatch ?? this.dateMatch,
      fieldId: fieldId ?? this.fieldId,
      refereeId: refereeId ?? this.refereeId,
      roundNumber: roundNumber ?? this.roundNumber,
      scoreLocal: scoreLocal ?? this.scoreLocal,
      scoreVisit: scoreVisit ?? this.scoreVisit,
      teamLocalId: teamLocalId ?? this.teamLocalId,
      teamVisitId: teamVisitId ?? this.teamVisitId,
    );
  }

  static const empty = MatchRoleDTO();
    /// Connect the generated [_$MatchRoleDTOFromJson] function to the `fromJson`
  /// factory.
  factory MatchRoleDTO.fromJson(Map<String, dynamic> json) =>
      _$MatchRoleDTOFromJson(json);

  /// Connect the generated [_$MatchRoleDTOToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MatchRoleDTOToJson(this);

  @override
  List<Object?> get props {
    return [
      dateMatch,
      fieldId,
      refereeId,
      roundNumber,
      scoreLocal,
      scoreVisit,
      teamLocalId,
      teamVisitId,
    ];
  }
}
