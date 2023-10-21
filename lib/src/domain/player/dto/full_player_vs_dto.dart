import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'full_player_vs_dto.g.dart';

@JsonSerializable()
class FullPlayerVsDTO extends Equatable {
  final int? pseudoId;
  final int? partyId;
  final int? playerId;
  final String? fullName;
  final int? payToPlay;
  final DateTime? birthday;
  final String? preferencePosition;
  final int? age;
  final String? address;

  const FullPlayerVsDTO({
    this.pseudoId,
    this.partyId,
    this.playerId,
    this.fullName,
    this.payToPlay,
    this.birthday,
    this.preferencePosition,
    this.age,
    this.address,
  });

  factory FullPlayerVsDTO.fromJson(Map<String, dynamic> json) =>
      _$FullPlayerVsDTOFromJson(json);

  static const empty = FullPlayerVsDTO();

  bool get isEmpty => this == FullPlayerVsDTO.empty;

  bool get isNotEmpty => this != FullPlayerVsDTO.empty;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "pseudoId": pseudoId,
        "partyId": partyId,
        "playerId": playerId,
        "fullName": fullName,
        "payToPlay": payToPlay,
        "birthday": birthday,
        "preferencePosition": preferencePosition,
        "age": age,
        "address": address,
      };

  FullPlayerVsDTO copyWith({
    int? pseudoId,
    int? partyId,
    int? playerId,
    String? fullName,
    int? payToPlay,
    DateTime? birthday,
    String? preferencePosition,
    int? age,
    String? address,
  }) {
    return FullPlayerVsDTO(
      pseudoId: pseudoId ?? this.pseudoId,
      partyId: partyId ?? this.partyId,
      playerId: playerId ?? this.playerId,
      fullName: fullName ?? this.fullName,
      payToPlay: payToPlay ?? this.payToPlay,
      birthday: birthday ?? this.birthday,
      preferencePosition: preferencePosition ?? this.preferencePosition,
      age: age ?? this.age,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
        pseudoId,
        partyId,
        playerId,
        fullName,
        payToPlay,
        birthday,
        preferencePosition,
        age,
        address,
      ];
}
