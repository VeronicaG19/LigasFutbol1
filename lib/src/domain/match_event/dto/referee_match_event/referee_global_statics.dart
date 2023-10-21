import 'package:equatable/equatable.dart';

class RefereeGlobalStatics extends Equatable {
  final int refereeID;
  final int redCards;
  final int yellowCards;
  final int totalMatches;

  const RefereeGlobalStatics({
    required this.refereeID,
    required this.redCards,
    required this.yellowCards,
    required this.totalMatches,
  });

  static const empty = RefereeGlobalStatics(
      refereeID: 0, redCards: 0, yellowCards: 0, totalMatches: 0);

  bool get isEmpty => this == RefereeGlobalStatics.empty;

  bool get isNotEmpty => this != RefereeGlobalStatics.empty;

  Map<String, dynamic> toJson() {
    return {
      'refereeID': refereeID,
      'redCards': redCards,
      'yellowCards': yellowCards,
      'totalMatches': totalMatches,
    };
  }

  factory RefereeGlobalStatics.fromJson(Map<String, dynamic> map) {
    return RefereeGlobalStatics(
      refereeID: map['refereeID'] ?? 0,
      redCards: map['redCards'] ?? 0,
      yellowCards: map['yellowCards'] ?? 0,
      totalMatches: map['totalMatches'] ?? 0,
    );
  }

  @override
  List<Object> get props => [
        refereeID,
        redCards,
        yellowCards,
        totalMatches,
      ];
}
