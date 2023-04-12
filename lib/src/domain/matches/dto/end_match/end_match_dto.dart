import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'end_match_dto.g.dart';

@JsonSerializable()
class EndMatchDTO extends Equatable {
  final int? matchId;
  final int? scoreLocal;
  final int? scoreShoutoutLocal;
  final int? scoreShoutoutVisit;
  final int? scoreVist;
  final int? teamMatchLocal;
  final int? teamMatchVisit;

  const EndMatchDTO({
    this.matchId,
    this.scoreLocal,
    this.scoreShoutoutLocal,
    this.scoreShoutoutVisit,
    this.scoreVist,
    this.teamMatchLocal,
    this.teamMatchVisit,
  });

  EndMatchDTO copyWith({
    int? matchId,
    int? scoreLocal,
    int? scoreShoutoutLocal,
    int? scoreShoutoutVisit,
    int? scoreVist,
    int? teamMatchLocal,
    int? teamMatchVisit,
  }) {
    return EndMatchDTO(
      matchId: matchId ?? this.matchId,
      scoreLocal: scoreLocal ?? this.scoreLocal,
      scoreShoutoutLocal: scoreShoutoutLocal ?? this.scoreShoutoutLocal,
      scoreShoutoutVisit: scoreShoutoutVisit ?? this.scoreShoutoutVisit,
      scoreVist: scoreVist ?? this.scoreVist,
      teamMatchLocal: teamMatchLocal ?? this.teamMatchLocal,
      teamMatchVisit: teamMatchVisit ?? this.teamMatchVisit,
    );
  }

  static const empty = EndMatchDTO();

  /// Connect the generated [_$TournamentFromJson] function to the `fromJson`
  /// factory.
  factory EndMatchDTO.fromJson(Map<String, dynamic> json) =>
      _$EndMatchDTOFromJson(json);

  /// Connect the generated [_$TournamentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$EndMatchDTOToJson(this);

  @override
  List<Object?> get props => [
        matchId,
        scoreLocal,
        scoreShoutoutLocal,
        scoreShoutoutVisit,
        scoreVist,
        teamMatchLocal,
        teamMatchVisit,
      ];
}
