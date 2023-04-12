import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_match_dto.g.dart';

@JsonSerializable()
class EditMatchDTO extends Equatable {
  final DateTime? dateMatch;
  final int? fieldId;
  final DateTime? hourMatch;
  final int? matchId;
  final int? refereeId;
  const EditMatchDTO({
    this.dateMatch,
    this.fieldId,
    this.hourMatch,
    this.matchId,
    this.refereeId,
  });

  EditMatchDTO copyWith({
    DateTime? dateMatch,
    int? fieldId,
    DateTime? hourMatch,
    int? matchId,
    int? refereeId,
  }) {
    return EditMatchDTO(
      dateMatch: dateMatch ?? this.dateMatch,
      fieldId: fieldId ?? this.fieldId,
      hourMatch: hourMatch ?? this.hourMatch,
      matchId: matchId ?? this.matchId,
      refereeId: refereeId ?? this.refereeId,
    );
  }

    /// Connect the generated [_$EditMatchDTOFromJson] function to the `fromJson`
  /// factory.
  factory EditMatchDTO.fromJson(Map<String, dynamic> json) =>
      _$EditMatchDTOFromJson(json);

  /// Connect the generated [_$EditMatchDTOToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$EditMatchDTOToJson(this);

  static const empty = EditMatchDTO();

  @override
  List<Object?> get props {
    return [
      dateMatch,
      fieldId,
      hourMatch,
      matchId,
      refereeId,
    ];
  }
}
