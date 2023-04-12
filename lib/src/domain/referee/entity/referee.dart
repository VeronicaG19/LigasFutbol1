import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ligas_futbol_flutter/src/domain/photo/entity/photo.dart';

part 'referee.g.dart';

/*
 * Entity from Match
 */
@JsonSerializable()
class Referee extends Equatable {
  final int? activeId;
  final String? enabledFlag;
  final int? partyId;
  //@JsonKey(name: 'refereeAdrres')
  final String? refereeAddress;
  final int? refereeId;
  final String? refereeLatitude;
  final String? refereeLength;
  final Photo? refereePhotoId;

  const Referee({
    this.activeId,
    this.enabledFlag,
    this.partyId,
    this.refereeAddress,
    this.refereeId,
    this.refereeLatitude,
    this.refereeLength,
    this.refereePhotoId,
  });

  Referee copyWith({
    int? activeId,
    String? enabledFlag,
    int? partyId,
    String? refereeAddress,
    int? refereeId,
    String? refereeLatitude,
    String? refereeLength,
    Photo? refereePhotoId,
  }) {
    return Referee(
      activeId: activeId ?? this.activeId,
      enabledFlag: enabledFlag ?? this.enabledFlag,
      partyId: partyId ?? this.partyId,
      refereeAddress: refereeAddress ?? this.refereeAddress,
      refereeId: refereeId ?? this.refereeId,
      refereeLatitude: refereeLatitude ?? this.refereeLatitude,
      refereeLength: refereeLength ?? this.refereeLength,
      refereePhotoId: refereePhotoId ?? this.refereePhotoId,
    );
  }

  static const empty = Referee();

  bool get isEmpty => this == Referee.empty;

  bool get isNotEmpty => this != Referee.empty;

  /// Connect the generated [_$RefereeFromJson] function to the `fromJson`
  /// factory.
  factory Referee.fromJson(Map<String, dynamic> json) =>
      _$RefereeFromJson(json);

  /// Connect the generated [_$RefereeToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RefereeToJson(this);

  @override
  List<Object?> get props {
    return [
      activeId,
      enabledFlag,
      partyId,
      refereeAddress,
      refereeId,
      refereeLatitude,
      refereeLength,
      refereePhotoId,
    ];
  }
}
