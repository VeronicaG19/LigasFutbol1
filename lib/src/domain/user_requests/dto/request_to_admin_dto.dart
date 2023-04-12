import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'request_to_admin_dto.g.dart';

@JsonSerializable()
class RequestToAdmonDTO extends Equatable {

  final String? leagueDescription;
  final String? leagueName;
  final int? partyId;
  final int? status;


  const RequestToAdmonDTO({
    this.leagueDescription,
    this.leagueName,
    this.partyId,
    this.status,
  });

  RequestToAdmonDTO copyWith({
    String? leagueDescription,
    String? leagueName,
    int? partyId,
    int? status,
  }) {
    return RequestToAdmonDTO(
      leagueDescription: leagueDescription ?? this.leagueDescription,
      leagueName: leagueName ?? this.leagueName,
      partyId: partyId ?? this.partyId,
      status: status ?? this.status,
    );
  }

  /// Connect the generated [_$RequestToAdmonDTOFromJson] function to the `fromJson`
  /// factory.
  factory RequestToAdmonDTO.fromJson(Map<String, dynamic> json) => _$RequestToAdmonDTOFromJson(json);

  /// Connect the generated [_$RequestToAdmonDTOJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RequestToAdmonDTOToJson(this);

  @override
  List<Object?> get props => [leagueDescription, leagueName, partyId, status,];


}