import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_player.g.dart';

@JsonSerializable()
class TeamPlayer extends Equatable {
  final int? pseudoId;
  final int? partyId;
  final String? fullName;
  final String? firstName;

  final String? lastName;
  final String? acronym;
  final String? areaCode;
  final String? positionCode;
  final String? personType;
  final int? orgId;
  final String? effectiveStartDate;
  final String? effectiveEndDate;
  final String? enabledFlag;

  const TeamPlayer({
    this.pseudoId,
    this.partyId,
    this.fullName,
    this.firstName,
    this.lastName,
    this.acronym,
    this.areaCode,
    this.positionCode,
    this.personType,
    this.orgId,
    this.effectiveStartDate,
    this.effectiveEndDate,
    this.enabledFlag,
  });

  /// Connect the generated [_$TeamPlayerFromJson] function to the `fromJson`
  /// factory.
  factory TeamPlayer.fromJson(Map<String, dynamic> json) =>
      _$TeamPlayerFromJson(json);

  /// Connect the generated [_$TeamPlayerToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TeamPlayerToJson(this);

  TeamPlayer copyWith({
    int? pseudoId,
    int? partyId,
    String? fullName,
    String? firstName,
    String? lastName,
    String? acronym,
    String? areaCode,
    String? positionCode,
    String? personType,
    int? orgId,
    String? effectiveStartDate,
    String? effectiveEndDate,
    String? enabledFlag,
  }) {
    return TeamPlayer(
      pseudoId: pseudoId ?? this.pseudoId,
      partyId: partyId ?? this.partyId,
      fullName: fullName ?? this.fullName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      acronym: acronym ?? this.acronym,
      areaCode: areaCode ?? this.areaCode,
      positionCode: positionCode ?? this.positionCode,
      personType: personType ?? this.personType,
      orgId: orgId ?? this.orgId,
      effectiveStartDate: effectiveStartDate ?? this.effectiveStartDate,
      effectiveEndDate: effectiveEndDate ?? this.effectiveEndDate,
      enabledFlag: enabledFlag ?? this.enabledFlag,
    );
  }

  @override
  List<Object?> get props => [
        pseudoId,
        partyId,
        fullName,
        firstName,
        lastName,
        acronym,
        areaCode,
        positionCode,
        personType,
        orgId,
        effectiveStartDate,
        effectiveEndDate,
        enabledFlag,
      ];
}
