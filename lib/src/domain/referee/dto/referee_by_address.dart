import 'package:equatable/equatable.dart';

class RefereeByAddress extends Equatable {
  final int activeId;
  final String firstName;
  final String lastName;
  final int partyId;
  final int refereeId;

  const RefereeByAddress({
    required this.activeId,
    required this.firstName,
    required this.lastName,
    required this.partyId,
    required this.refereeId,
  });

  static const empty = RefereeByAddress(
      refereeId: 0, activeId: 0, partyId: 0, lastName: '', firstName: '');

  bool get isEmpty => this == RefereeByAddress.empty;

  bool get isNotEmpty => this != RefereeByAddress.empty;

  RefereeByAddress copyWith({
    int? activeId,
    String? firstName,
    String? lastName,
    int? partyId,
    int? refereeId,
  }) {
    return RefereeByAddress(
      activeId: activeId ?? this.activeId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      partyId: partyId ?? this.partyId,
      refereeId: refereeId ?? this.refereeId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activeId': activeId,
      'firstName': firstName,
      'lastName': lastName,
      'partyId': partyId,
      'refereeId': refereeId,
    };
  }

  factory RefereeByAddress.fromJson(Map<String, dynamic> json) {
    return RefereeByAddress(
      activeId: json['activeId'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      partyId: json['partyId'] ?? 0,
      refereeId: json['refereeId'] ?? 0,
    );
  }

  @override
  List<Object> get props => [
        activeId,
        firstName,
        lastName,
        partyId,
        refereeId,
      ];
}
