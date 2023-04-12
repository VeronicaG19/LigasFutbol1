import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'roles_by_tournament.g.dart';
/*
 * Entity from Match
 */
@JsonSerializable()
class RolesByTournament extends Equatable {
  final String? matchDate;
  final int? matchId;
  final String? nameLocal;
  final String? nameVisit;
  final int? roundNumber;
  final int? scoreLocal;
  final int? scoreVisit;
  const RolesByTournament({
    this.matchDate,
    this.matchId,
    this.nameLocal,
    this.nameVisit,
    this.roundNumber,
    this.scoreLocal,
    this.scoreVisit,
  });

  

  RolesByTournament copyWith({
    String? matchDate,
    int? matchId,
    String? nameLocal,
    String? nameVisit,
    int? roundNumber,
    int? scoreLocal,
    int? scoreVisit,
  }) {
    return RolesByTournament(
      matchDate: matchDate ?? this.matchDate,
      matchId: matchId ?? this.matchId,
      nameLocal: nameLocal ?? this.nameLocal,
      nameVisit: nameVisit ?? this.nameVisit,
      roundNumber: roundNumber ?? this.roundNumber,
      scoreLocal: scoreLocal ?? this.scoreLocal,
      scoreVisit: scoreVisit ?? this.scoreVisit,
    );
  }

  /// Connect the generated [_$RolesByTournamentFromJson] function to the `fromJson`
  /// factory.
  factory RolesByTournament.fromJson(Map<String, dynamic> json) =>
      _$RolesByTournamentFromJson(json);

  /// Connect the generated [_$RolesByTournamentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RolesByTournamentToJson(this);

  @override
  List<Object?> get props {
    return [
      matchDate,
      matchId,
      nameLocal,
      nameVisit,
      roundNumber,
      scoreLocal,
      scoreVisit,
    ];
  }
}
