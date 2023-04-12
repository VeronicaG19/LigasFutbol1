import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'finalize_match_dto.g.dart';

@JsonSerializable()
class FinalizeMatchDTO extends Equatable {
  final int? matchId;
  final int? scoreLocal;
  final int? scoreShoutoutLocal;
  final int? scoreShoutoutVisit;
  final int? scoreVist;
  final int? teamMatchLocal;
  final int? teamMatchVisit;
  const FinalizeMatchDTO({
    this.matchId,
    this.scoreLocal,
    this.scoreShoutoutLocal,
    this.scoreShoutoutVisit,
    this.scoreVist,
    this.teamMatchLocal,
    this.teamMatchVisit,
  });


  FinalizeMatchDTO copyWith({
    int? matchId,
    int? scoreLocal,
    int? scoreShoutoutLocal,
    int? scoreShoutoutVisit,
    int? scoreVist,
    int? teamMatchLocal,
    int? teamMatchVisit,
  }) {
    return FinalizeMatchDTO(
      matchId: matchId ?? this.matchId,
      scoreLocal: scoreLocal ?? this.scoreLocal,
      scoreShoutoutLocal: scoreShoutoutLocal ?? this.scoreShoutoutLocal,
      scoreShoutoutVisit: scoreShoutoutVisit ?? this.scoreShoutoutVisit,
      scoreVist: scoreVist ?? this.scoreVist,
      teamMatchLocal: teamMatchLocal ?? this.teamMatchLocal,
      teamMatchVisit: teamMatchVisit ?? this.teamMatchVisit,
    );
  }

  /// Connect the generated [_$FinalizeMatchDTOFromJson] function to the `fromJson`
  /// factory.
  factory FinalizeMatchDTO.fromJson(Map<String, dynamic> json) =>
      _$FinalizeMatchDTOFromJson(json);

  /// Connect the generated [_$FinalizeMatchDTOToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FinalizeMatchDTOToJson(this);
  
  static const empty = FinalizeMatchDTO();

  @override
  List<Object?> get props {
    return [
      matchId,
      scoreLocal,
      scoreShoutoutLocal,
      scoreShoutoutVisit,
      scoreVist,
      teamMatchLocal,
      teamMatchVisit,
    ];
  }
}
