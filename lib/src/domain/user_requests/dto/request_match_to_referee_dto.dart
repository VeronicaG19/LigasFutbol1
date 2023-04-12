import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_match_to_referee_dto.g.dart';

@JsonSerializable()
class RequestMatchToRefereeDTO extends Equatable {
  final int? activeId;
  final String? currency;
  final int? durationEvent;
  final String? endDate;
  final int? matchID;
  final String? nameLeague;
  final String? nameTournament;
  final String? presidentLeague;
  final int? price;
  final int? refereeID;
  final int? requestId;
  final int? requestMadeById;
  final int? requestTo;
  final String? startDate;
  final String? statudRequest;
  final String? teamMatch;
  final String? typeRequest;
  final int? countEvents;

  const RequestMatchToRefereeDTO(
      {this.activeId,
      this.currency,
      this.durationEvent,
      this.endDate,
      this.matchID,
      this.nameLeague,
      this.nameTournament,
      this.presidentLeague,
      this.price,
      this.refereeID,
      this.requestId,
      this.requestMadeById,
      this.requestTo,
      this.startDate,
      this.statudRequest,
      this.teamMatch,
      this.typeRequest,
      this.countEvents});

  RequestMatchToRefereeDTO copyWith(
      {int? activeId,
      int? price,
      int? durationEvent,
      String? endDate,
      int? matchID,
      String? nameLeague,
      String? nameTournament,
      String? presidentLeague,
      String? currency,
      int? refereeID,
      int? requestId,
      int? requestMadeById,
      int? requestTo,
      String? startDate,
      String? statudRequest,
      String? teamMatch,
      String? typeRequest,
      int? countEvents}) {
    return RequestMatchToRefereeDTO(
        activeId: activeId ?? this.activeId,
        currency: currency ?? this.currency,
        durationEvent: durationEvent ?? this.durationEvent,
        endDate: endDate ?? this.endDate,
        matchID: matchID ?? this.matchID,
        nameLeague: nameLeague ?? this.nameLeague,
        nameTournament: nameTournament ?? this.nameTournament,
        presidentLeague: presidentLeague ?? this.presidentLeague,
        price: price ?? this.price,
        refereeID: refereeID ?? this.refereeID,
        requestId: requestId ?? this.requestId,
        requestMadeById: requestMadeById ?? this.requestMadeById,
        requestTo: requestTo ?? this.requestTo,
        startDate: startDate ?? this.startDate,
        statudRequest: statudRequest ?? this.statudRequest,
        teamMatch: teamMatch ?? this.teamMatch,
        typeRequest: typeRequest ?? this.typeRequest,
        countEvents: countEvents ?? this.countEvents);
  }

  factory RequestMatchToRefereeDTO.fromJson(Map<String, dynamic> json) =>
      _$RequestMatchToRefereeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RequestMatchToRefereeDTOToJson(this);

  static const empty = RequestMatchToRefereeDTO(
      activeId: 0,
      currency: 'MXN',
      durationEvent: 0,
      endDate: '',
      matchID: 0,
      nameLeague: '',
      nameTournament: '',
      price: 0,
      refereeID: 0,
      requestId: 0,
      requestMadeById: 0,
      requestTo: 0,
      startDate: '',
      statudRequest: '',
      teamMatch: '',
      typeRequest: '',
      countEvents: 0);

  @override
  List<Object?> get props => [
        activeId,
        durationEvent,
        endDate,
        matchID,
        nameLeague,
        nameTournament,
        presidentLeague,
        refereeID,
        requestId,
        requestMadeById,
        requestTo,
        startDate,
        statudRequest,
        teamMatch,
        typeRequest,
        countEvents
      ];
}
