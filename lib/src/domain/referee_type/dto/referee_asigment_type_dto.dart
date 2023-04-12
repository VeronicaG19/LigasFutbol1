import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'referee_asigment_type_dto.g.dart';
/*
 * Entity from RefereeAsigmentTypeDTO
 */
@JsonSerializable()
class RefereeAsigmentTypeDTO extends Equatable {
  final int? matchId;
  final int? rassignmentId;
  final int? refereeTypeId;
  const RefereeAsigmentTypeDTO({
    this.matchId,
    this.rassignmentId,
    this.refereeTypeId,
  });

  RefereeAsigmentTypeDTO copyWith({
    int? matchId,
    int? rassignmentId,
    int? refereeTypeId,
  }) {
    return RefereeAsigmentTypeDTO(
      matchId: matchId ?? this.matchId,
      rassignmentId: rassignmentId ?? this.rassignmentId,
      refereeTypeId: refereeTypeId ?? this.refereeTypeId,
    );
  }


  /// Connect the generated [_$RefereeAsigmentTypeDTOFromJson] function to the `fromJson`
  /// factory.
  factory RefereeAsigmentTypeDTO.fromJson(Map<String, dynamic> json) =>
      _$RefereeAsigmentTypeDTOFromJson(json);

  /// Connect the generated [_$RefereeAsigmentTypeDTOToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RefereeAsigmentTypeDTOToJson(this);

  @override
  List<Object?> get props => [matchId, rassignmentId, refereeTypeId];
}
