import 'package:equatable/equatable.dart';

class RefereeByLeagueDTO extends Equatable {
  final int qualifyReferee;
  final int refereeId;
  final String refereeName;
  final String refereePhoto;
  final String refereeStatus;
  final int activeId;

  const RefereeByLeagueDTO(
      {required this.qualifyReferee,
      required this.refereeId,
      required this.refereeName,
      required this.refereePhoto,
      required this.refereeStatus,
      required this.activeId});

  static const empty = RefereeByLeagueDTO(
      qualifyReferee: 0,
      refereeId: 0,
      refereeName: '',
      refereePhoto: '',
      refereeStatus: '',
      activeId: 0);

  bool get isEmpty => this == RefereeByLeagueDTO.empty;

  bool get isNotEmpty => this != RefereeByLeagueDTO.empty;

  Map<String, dynamic> toJson() {
    return {
      'qualifiReferee': qualifyReferee,
      'refereId': refereeId,
      'refereeName': refereeName,
      'refereePhoto': refereePhoto,
      'refereeStatus': refereeStatus,
      'activeId': activeId
    };
  }

  factory RefereeByLeagueDTO.fromJson(Map<String, dynamic> json) {
    return RefereeByLeagueDTO(
        qualifyReferee: json['qualifiReferee'] ?? 0,
        refereeId: json['refereId'] ?? 0,
        refereeName: json['refereeName'] ?? '',
        refereePhoto: json['refereePhoto'] ?? '',
        refereeStatus: json['refereeStatus'] ?? '',
        activeId: json['activeId'] ?? 0);
  }

  RefereeByLeagueDTO copyWith(
      {int? qualifyReferee,
      int? refereeId,
      String? refereeName,
      String? refereePhoto,
      String? refereeStatus,
      int? activeId}) {
    return RefereeByLeagueDTO(
        qualifyReferee: qualifyReferee ?? this.qualifyReferee,
        refereeId: refereeId ?? this.refereeId,
        refereeName: refereeName ?? this.refereeName,
        refereePhoto: refereePhoto ?? this.refereePhoto,
        refereeStatus: refereeStatus ?? this.refereeStatus,
        activeId: activeId ?? this.activeId);
  }

  @override
  List<Object> get props => [
        qualifyReferee,
        refereeId,
        refereeName,
        refereePhoto,
        refereeStatus,
      ];
}
