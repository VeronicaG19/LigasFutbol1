import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'validate_request_dto.g.dart';

@JsonSerializable()
class ValidateRequestDTO extends Equatable {

  final int? partyId;
  final int? playerId;
  final int? requestId;
  final int? teamPlayerId;
  final String? lookupName;

  const ValidateRequestDTO(
       {this.partyId,
         this.playerId,
         this.requestId,
         this.teamPlayerId,
         this.lookupName,}
      );

  factory ValidateRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$ValidateRequestDTOFromJson(json);

  static const empty = ValidateRequestDTO();

  bool get isEmpty => this == ValidateRequestDTO.empty;

  bool get isNotEmpty => this != ValidateRequestDTO.empty;

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        "partyId": partyId,
        "playerId": playerId,
        "requestId": requestId,
        "teamPlayerId": teamPlayerId,
        "lookupName": lookupName,
      };

  ValidateRequestDTO copyWith({
    int? partyId,
    int? playerId,
    int? requestId,
    int? teamPlayerId,
    String? lookupName,
  }) {
    return ValidateRequestDTO(
      partyId: partyId ?? this.partyId,
      playerId: playerId ?? this.playerId,
      requestId: requestId ?? this.requestId,
      teamPlayerId: teamPlayerId ?? this.teamPlayerId,
      lookupName: lookupName ?? this.lookupName,
    );
  }

  @override
  List<Object?> get props =>
      [partyId, playerId, requestId, teamPlayerId, lookupName,];
}