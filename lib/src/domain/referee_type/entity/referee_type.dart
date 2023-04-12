// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../referee/entity/referee.dart';

part 'referee_type.g.dart';
/*
 * Entity from RefereeType
 */
@JsonSerializable()
class RefereeType extends Equatable {
  final String? enabledFlag;
  final int? refereeCategoryId;
  final Referee? refereeId;
  final int? refereeType;
  final int? refereeTypeId;
  const RefereeType({
    this.enabledFlag,
    this.refereeCategoryId,
    this.refereeId,
    this.refereeType,
    this.refereeTypeId,
  });

  RefereeType copyWith({
    String? enabledFlag,
    int? refereeCategoryId,
    Referee? refereeId,
    int? refereeType,
    int? refereeTypeId,
  }) {
    return RefereeType(
      enabledFlag: enabledFlag ?? this.enabledFlag,
      refereeCategoryId: refereeCategoryId ?? this.refereeCategoryId,
      refereeId: refereeId ?? this.refereeId,
      refereeType: refereeType ?? this.refereeType,
      refereeTypeId: refereeTypeId ?? this.refereeTypeId,
    );
  }

  /// Connect the generated [_$RefereeTypeFromJson] function to the `fromJson`
  /// factory.
  factory RefereeType.fromJson(Map<String, dynamic> json) =>
      _$RefereeTypeFromJson(json);

  /// Connect the generated [_$RefereeTypeToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RefereeTypeToJson(this);

  @override
  List<Object?> get props {
    return [
      enabledFlag,
      refereeCategoryId,
      refereeId,
      refereeType,
      refereeTypeId,
    ];
  }
}
