import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_to_league_dto.g.dart';
@JsonSerializable()
class RequestToLeagueDTO extends Equatable {
  final int? categoryId;
  final int? leagueId;
  final String? nameTeam;
  final int? partyId;

  const RequestToLeagueDTO({
    this.categoryId,
    this.leagueId,
    this.nameTeam,
    this.partyId,
  });

  RequestToLeagueDTO copyWith({
    int? categoryId,
    int? leagueId,
    String? nameTeam,
    int? partyId,
  }) {
    return RequestToLeagueDTO(
      categoryId: categoryId ?? this.categoryId,
      leagueId: leagueId ?? this.leagueId,
      nameTeam: nameTeam ?? this.nameTeam,
      partyId: partyId ?? this.partyId,
    );
  }

  factory RequestToLeagueDTO.fromJson(Map<String, dynamic> json) =>
      _$RequestToLeagueDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToLeagueDTOToJson(this);

  @override
  List<Object?> get props => [categoryId,leagueId,nameTeam,partyId,];

}