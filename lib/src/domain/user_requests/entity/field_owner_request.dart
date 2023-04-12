import 'package:equatable/equatable.dart';

class FieldOwnerRequest extends Equatable {
  final String teamMatch;
  final String fieldName;
  final String leagueName;
  final int requestId;
  final String requestType;
  final int leagueId;
  final int requestTo;
  final String? startDate;
  final int fieldId;
  final int activeId;
  final String? endDate;
  final String leaguePresident;
  final int matchId;
  final String requestStatus;
  final int eventDuration;
  final String tournamentName;
  final int price;
  final String currency;
  final int? countEvents;

  const FieldOwnerRequest(
      {required this.teamMatch,
      required this.fieldName,
      required this.leagueName,
      required this.requestId,
      required this.requestType,
      required this.leagueId,
      required this.requestTo,
      this.startDate,
      required this.fieldId,
      required this.activeId,
      this.endDate,
      required this.leaguePresident,
      required this.matchId,
      required this.requestStatus,
      required this.eventDuration,
      required this.tournamentName,
      required this.price,
      required this.currency,
      this.countEvents});

  static const empty = FieldOwnerRequest(
      teamMatch: '',
      fieldName: '',
      leagueName: '',
      requestId: 0,
      requestType: '',
      leagueId: 0,
      requestTo: 0,
      fieldId: 0,
      activeId: 0,
      leaguePresident: '',
      matchId: 0,
      requestStatus: '',
      eventDuration: 0,
      tournamentName: '',
      price: 0,
      currency: 'MXN',
      countEvents: 0);

  bool get isEmpty => this == FieldOwnerRequest.empty;

  bool get isNotEmpty => this != FieldOwnerRequest.empty;

  factory FieldOwnerRequest.fromJson(Map<String, dynamic> json) {
    // final endJsonDate = json['endDate']?.toString();
    // final startJsonDate = json['startDate']?.toString();
    // final DateTime? endDate =
    //     endJsonDate != null ? DateTime.parse(endJsonDate) : null;
    // final DateTime? startDate =
    //     startJsonDate != null ? DateTime.parse(startJsonDate) : null;
    return FieldOwnerRequest(
        teamMatch: json['teamMatch'] ?? '',
        fieldName: json['fieldName'] ?? '',
        leagueName: json['nameLeague'] ?? '',
        requestId: json['requestId'] ?? 0,
        requestType: json['typeRequest'] ?? '',
        leagueId: json['leagueId'] ?? 0,
        requestTo: json['requestTo'] ?? 0,
        startDate: json['startDate'],
        fieldId: json['fiedlId'] ?? 0,
        activeId: json['activeId'] ?? 0,
        endDate: json['endDate'],
        leaguePresident: json['presidentLeague'] ?? '',
        matchId: json['matchID'] ?? 0,
        requestStatus: json['statudRequest'] ?? '',
        eventDuration: json['durationEvent'] ?? 0,
        tournamentName: json['nameTournament'] ?? '',
        price: json['price'] ?? 0,
        currency: json['currency'] ?? 'MXN',
        countEvents: json['countEvents'] ?? 0);
  }

  FieldOwnerRequest copyWith(
      {String? teamMatch,
      String? fieldName,
      String? leagueName,
      int? requestId,
      String? requestType,
      int? leagueId,
      int? requestTo,
      String? startDate,
      int? fieldId,
      int? activeId,
      String? endDate,
      String? leaguePresident,
      int? matchId,
      String? requestStatus,
      int? eventDuration,
      String? tournamentName,
      int? price,
      String? currency,
      int? countEvents}) {
    return FieldOwnerRequest(
        teamMatch: teamMatch ?? this.teamMatch,
        fieldName: fieldName ?? this.fieldName,
        leagueName: leagueName ?? this.leagueName,
        requestId: requestId ?? this.requestId,
        requestType: requestType ?? this.requestType,
        leagueId: leagueId ?? this.leagueId,
        requestTo: requestTo ?? this.requestTo,
        startDate: startDate ?? this.startDate,
        fieldId: fieldId ?? this.fieldId,
        activeId: activeId ?? this.activeId,
        endDate: endDate ?? this.endDate,
        leaguePresident: leaguePresident ?? this.leaguePresident,
        matchId: matchId ?? this.matchId,
        requestStatus: requestStatus ?? this.requestStatus,
        eventDuration: eventDuration ?? this.eventDuration,
        tournamentName: tournamentName ?? this.tournamentName,
        price: price ?? this.price,
        currency: currency ?? this.currency,
        countEvents: countEvents ?? this.countEvents);
  }

  @override
  List<Object?> get props => [
        teamMatch,
        fieldName,
        leagueName,
        requestId,
        requestType,
        leagueId,
        requestTo,
        startDate,
        fieldId,
        activeId,
        endDate,
        leaguePresident,
        matchId,
        requestStatus,
        eventDuration,
        tournamentName,
        price,
        currency,
        countEvents
      ];
}
