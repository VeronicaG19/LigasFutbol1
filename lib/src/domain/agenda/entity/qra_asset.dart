import 'package:equatable/equatable.dart';

class QraAsset extends Equatable {
  final int? appId;
  final double assignedPrice;
  final int capacity;
  final int durationEvents;
  final String? latitude;
  final String location;
  final String? longitude;
  final String namePerson;
  final int partyId;
  final int activeId;

  const QraAsset({
    this.appId,
    required this.assignedPrice,
    required this.capacity,
    required this.durationEvents,
    this.latitude,
    required this.location,
    this.longitude,
    required this.namePerson,
    required this.partyId,
    required this.activeId,
  });

  static const empty = QraAsset(
      appId: 0,
      assignedPrice: 0,
      capacity: 0,
      durationEvents: 0,
      latitude: '',
      location: '',
      longitude: '',
      namePerson: '',
      activeId: 0,
      partyId: 0);

  bool get isEmpty => this == QraAsset.empty;

  bool get isNotEmpty => this != QraAsset.empty;

  Map<String, dynamic> toJson() {
    return {
      'appId': appId,
      'assignedPrice': assignedPrice,
      'capacity': capacity,
      'durationEvents': durationEvents,
      'latitude': latitude,
      'location': location,
      'longitude': longitude,
      'namePerson': namePerson,
      'partyId': partyId,
      'activeId': activeId
    };
  }

  factory QraAsset.fromJson(Map<String, dynamic> json) {
    final price =
        json['assignedPrice'] == null ? 0.0 : json['assignedPrice'] as double;
    return QraAsset(
      appId: json['appId'] ?? 0,
      assignedPrice: price,
      capacity: json['capacity'] ?? 0,
      durationEvents: json['durationEvents'] ?? 0,
      latitude: json['latitude'] ?? '',
      location: json['location'] ?? '',
      longitude: json['longitude'] ?? '',
      namePerson: json['namePerson'] ?? '',
      partyId: json['partyId'] ?? 0,
      activeId: json['activeId'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        appId,
        assignedPrice,
        capacity,
        durationEvents,
        latitude,
        location,
        longitude,
        namePerson,
        partyId,
      ];
}
