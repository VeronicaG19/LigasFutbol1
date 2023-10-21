import 'package:equatable/equatable.dart';

class RefereeByAddress extends Equatable {
  final int activeId;
  final String name;
  final int partyId;
  final int refereeId;
  final String latitude;
  final String longitude;
  final String address;

  const RefereeByAddress({
    required this.activeId,
    required this.name,
    required this.partyId,
    required this.refereeId,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  static const empty = RefereeByAddress(
      refereeId: 0,
      activeId: 0,
      partyId: 0,
      name: '',
      latitude: '0',
      longitude: '0',
      address: '');

  bool get isEmpty => this == RefereeByAddress.empty;

  bool get isNotEmpty => this != RefereeByAddress.empty;

  RefereeByAddress copyWith({
    int? activeId,
    String? name,
    int? partyId,
    int? refereeId,
    String? latitude,
    String? longitude,
    String? address,
  }) {
    return RefereeByAddress(
      activeId: activeId ?? this.activeId,
      name: name ?? this.name,
      partyId: partyId ?? this.partyId,
      refereeId: refereeId ?? this.refereeId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activeId': activeId,
      'firstName': name,
      'partyId': partyId,
      'refereeId': refereeId,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }

  factory RefereeByAddress.fromJson(Map<String, dynamic> json) {
    return RefereeByAddress(
      activeId: json['activeId'] ?? 0,
      name: json['name'] ?? '',
      latitude: json['latitude'] ?? '0',
      longitude: json['longitude'] ?? '0',
      address: json['address'] ?? '',
      partyId: json['partyId'] ?? 0,
      refereeId: json['refereeId'] ?? 0,
    );
  }

  double get getLongitude => double.parse(longitude);
  double get getLatitude => double.parse(latitude);
  String get getRefereeName => name ?? '';

  @override
  List<Object> get props => [
        activeId,
        name,
        partyId,
        refereeId,
        longitude,
        latitude,
        address,
      ];
}
