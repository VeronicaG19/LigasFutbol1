import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../matches/entity/match.dart';
import '../../referee_type/entity/referee_type.dart';

part 'referee_assigment.g.dart';
/*
 * Entity from RefereeAssignment
 */
@JsonSerializable()
class RefereeAssignment extends Equatable {
  final String? enabledFlag;
	final int? healthFactorLocal;
	final int? healthFactorVisit;
	final int? impartialityLocal;
	final int? impartialityVisit;
	final MatchSpr? matchId;
	final int? puntualityLocal;
	final int? puntualityVisit;
	final int? rassignmentId;
	final RefereeType? refereeTypeId;
	final int? statusAssignment;
	final int? tacticalFactorLocal;
	final int? tacticalFactorVisit;
	final int? technicalKnwLocal;
	final int? technicalKnwVisit;
  const RefereeAssignment({
    this.enabledFlag,
    this.healthFactorLocal,
    this.healthFactorVisit,
    this.impartialityLocal,
    this.impartialityVisit,
    this.matchId,
    this.puntualityLocal,
    this.puntualityVisit,
    this.rassignmentId,
    this.refereeTypeId,
    this.statusAssignment,
    this.tacticalFactorLocal,
    this.tacticalFactorVisit,
    this.technicalKnwLocal,
    this.technicalKnwVisit,
  });

  RefereeAssignment copyWith({
    String? enabledFlag,
    int? healthFactorLocal,
    int? healthFactorVisit,
    int? impartialityLocal,
    int? impartialityVisit,
    MatchSpr? matchId,
    int? puntualityLocal,
    int? puntualityVisit,
    int? rassignmentId,
    RefereeType? refereeTypeId,
    int? statusAssignment,
    int? tacticalFactorLocal,
    int? tacticalFactorVisit,
    int? technicalKnwLocal,
    int? technicalKnwVisit,
  }) {
    return RefereeAssignment(
      enabledFlag: enabledFlag ?? this.enabledFlag,
      healthFactorLocal: healthFactorLocal ?? this.healthFactorLocal,
      healthFactorVisit: healthFactorVisit ?? this.healthFactorVisit,
      impartialityLocal: impartialityLocal ?? this.impartialityLocal,
      impartialityVisit: impartialityVisit ?? this.impartialityVisit,
      matchId: matchId ?? this.matchId,
      puntualityLocal: puntualityLocal ?? this.puntualityLocal,
      puntualityVisit: puntualityVisit ?? this.puntualityVisit,
      rassignmentId: rassignmentId ?? this.rassignmentId,
      refereeTypeId: refereeTypeId ?? this.refereeTypeId,
      statusAssignment: statusAssignment ?? this.statusAssignment,
      tacticalFactorLocal: tacticalFactorLocal ?? this.tacticalFactorLocal,
      tacticalFactorVisit: tacticalFactorVisit ?? this.tacticalFactorVisit,
      technicalKnwLocal: technicalKnwLocal ?? this.technicalKnwLocal,
      technicalKnwVisit: technicalKnwVisit ?? this.technicalKnwVisit,
    );
  }

  /// Connect the generated [_$RefereeAssignmentFromJson] function to the `fromJson`
  /// factory.
  factory RefereeAssignment.fromJson(Map<String, dynamic> json) =>
      _$RefereeAssignmentFromJson(json);

  /// Connect the generated [_$RefereeAssignmentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RefereeAssignmentToJson(this);

  @override
  List<Object?> get props {
    return [
      enabledFlag,
      healthFactorLocal,
      healthFactorVisit,
      impartialityLocal,
      impartialityVisit,
      matchId,
      puntualityLocal,
      puntualityVisit,
      rassignmentId,
      refereeTypeId,
      statusAssignment,
      tacticalFactorLocal,
      tacticalFactorVisit,
      technicalKnwLocal,
      technicalKnwVisit,
    ];
  }
}
