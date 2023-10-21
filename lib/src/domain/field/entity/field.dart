import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/entity/match.dart';

import '../../photo/entity/photo.dart';

part 'field.g.dart';

/*
 * Entity for Field
 */
@JsonSerializable()
class Field extends Equatable {
  final int? activeId;
  final int? assessement;
  final String? availability;
  final String? enabledFlag;
  final int? fieldId;
  final String? fieldName;
  final Photo? fieldPhotoId;
  final String? fieldType;
  final String? fieldsAddress;
  final String? fieldsLatitude;
  final String? fieldsLength;
  final String? hourClose;
  final String? hourOpen;
  final int? leagueId;
  final List<MatchSpr>? matchesList;
  final String? sportType;

  const Field({
    this.activeId,
    this.assessement,
    this.availability,
    this.enabledFlag,
    this.fieldId,
    this.fieldName,
    this.fieldPhotoId,
    this.fieldType,
    this.fieldsAddress,
    this.fieldsLatitude,
    this.fieldsLength,
    this.hourClose,
    this.hourOpen,
    this.leagueId,
    this.matchesList,
    this.sportType,
  });

  Field copyWith({
    int? activeId,
    int? assessement,
    String? availability,
    String? enabledFlag,
    int? fieldId,
    String? fieldName,
    Photo? fieldPhotoId,
    String? fieldType,
    String? fieldsAddress,
    String? fieldsLatitude,
    String? fieldsLength,
    String? hourClose,
    String? hourOpen,
    int? leagueId,
    List<MatchSpr>? matchesList,
    String? sportType,
  }) {
    return Field(
      activeId: activeId ?? this.activeId,
      assessement: assessement ?? this.assessement,
      availability: availability ?? this.availability,
      enabledFlag: enabledFlag ?? this.enabledFlag,
      fieldId: fieldId ?? this.fieldId,
      fieldName: fieldName ?? this.fieldName,
      fieldPhotoId: fieldPhotoId ?? this.fieldPhotoId,
      fieldType: fieldType ?? this.fieldType,
      fieldsAddress: fieldsAddress ?? this.fieldsAddress,
      fieldsLatitude: fieldsLatitude ?? this.fieldsLatitude,
      fieldsLength: fieldsLength ?? this.fieldsLength,
      hourClose: hourClose ?? this.hourClose,
      hourOpen: hourOpen ?? this.hourOpen,
      leagueId: leagueId ?? this.leagueId,
      matchesList: matchesList ?? this.matchesList,
      sportType: sportType ?? this.sportType,
    );
  }

  static const empty = Field();

  bool get isEmpty => this == Field.empty;

  bool get isNotEmpty => this != Field.empty;

  String get getFieldName => fieldName ?? '';

  /// Connect the generated [_$FieldFromJson] function to the `fromJson`
  /// factory.
  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  /// Connect the generated [_$FieldToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FieldToJson(this);

  @override
  List<Object?> get props => [
        activeId,
        assessement,
        availability,
        enabledFlag,
        fieldId,
        fieldName,
        fieldPhotoId,
        fieldType,
        fieldsAddress,
        fieldsLatitude,
        fieldsLength,
        hourClose,
        hourOpen,
        leagueId,
        matchesList,
        sportType,
      ];
}
