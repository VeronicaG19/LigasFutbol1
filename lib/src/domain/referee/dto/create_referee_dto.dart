import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_referee_dto.g.dart';

@JsonSerializable()
class CreateRefereeDTO extends Equatable {
  final int? leagueId;
  final int? partyId;
  final int? refereeCategory;
  final int? refereeType;
  final int? activeId;
  final String? refereeAddress;
  final String? refereeLatitude;
  final String? refereeLength;

  const CreateRefereeDTO({
    this.leagueId,
    this.partyId,
    this.refereeCategory,
    this.refereeType,
    this.activeId,
    this.refereeAddress,
    this.refereeLatitude,
    this.refereeLength,
  });

  CreateRefereeDTO copyWith({
    int? leagueId,
    int? partyId,
    int? refereeCategory,
    int? refereeType,
    int? activeId,
    String? refereeAddress,
    String? refereeLatitude,
    String? refereeLength,
  }) {
    return CreateRefereeDTO(
      leagueId: leagueId ?? this.leagueId,
      partyId: partyId ?? this.partyId,
      refereeCategory: refereeCategory ?? this.refereeCategory,
      refereeType: refereeType ?? this.refereeType,
      activeId: activeId ?? this.activeId,
      refereeAddress: refereeAddress ?? this.refereeAddress,
      refereeLatitude: refereeLatitude ?? this.refereeLatitude,
      refereeLength: refereeLength ?? this.refereeLength,
    );
  }

  static const empty = CreateRefereeDTO();

  /// Connect the generated [_$CreateRefereeDTOFromJson] function to the `fromJson`
  /// factory.
  factory CreateRefereeDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateRefereeDTOFromJson(json);

  /// Connect the generated [_$CreateRefereeDTOTOJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CreateRefereeDTOToJson(this);

  @override
  List<Object?> get props => [
        leagueId,
        partyId,
        refereeCategory,
        refereeType,
        activeId,
        refereeAddress,
        refereeLatitude,
        refereeLength,
      ];
}
