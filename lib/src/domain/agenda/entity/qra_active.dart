import 'package:equatable/equatable.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category_qra.dart';

class QraActive extends Equatable {
  final int activeId;
  final String? name;
  final String? description;
  final int? capacity;
  final String? code;
  final int? durationEvents;
  final String? longitude;
  final String? latitude;
  final int? idActiveApp;
  final String? phoneContact;
  final String? emailContact;
  final String? typeEvent;
  final String? typeDateEvent;
  final String? existence;
  final int? appId;
  final String? shareAsset;
  final QraCategory? categoryId;
  final String? location;
  final String? unitDurationEvents;

  const QraActive({
    required this.activeId,
    this.name,
    this.description,
    this.capacity,
    this.code,
    this.durationEvents,
    this.longitude,
    this.latitude,
    this.idActiveApp,
    this.phoneContact,
    this.emailContact,
    this.typeEvent,
    this.typeDateEvent,
    this.existence,
    this.appId,
    this.shareAsset,
    this.categoryId,
    this.location,
    this.unitDurationEvents,
  });

  static const empty = QraActive(
    activeId: 0
  );

  bool get isEmpty => this == QraActive.empty;

  bool get isNotEmpty => this != QraActive.empty;

  QraActive copyWith({
    int? activeId,
    String? name,
    String? description,
    int? capacity,
    String? code,
    int? durationEvents,
    String? longitude,
    String? latitude,
    int? idActiveApp,
    String? phoneContact,
    String? emailContact,
    String? typeEvent,
    String? typeDateEvent,
    String? existence,
    int? appId,
    String? shareAsset,
    QraCategory? categoryId,
    String? location,
    String? unitDurationEvents,
  }) {
    return QraActive(
      activeId: activeId ?? this.activeId,
      name: name ?? this.name,
      description: description ?? this.description,
      capacity: capacity ?? this.capacity,
      code: code ?? this.code,
      durationEvents: durationEvents ?? this.durationEvents,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      idActiveApp: idActiveApp ?? this.idActiveApp,
      phoneContact: phoneContact ?? this.phoneContact,
      emailContact: emailContact ?? this.emailContact,
      typeEvent: typeEvent ?? this.typeEvent,
      typeDateEvent: typeDateEvent ?? this.typeDateEvent,
      existence: existence ?? this.existence,
      appId: appId ?? this.appId,
      shareAsset: shareAsset ?? this.shareAsset,
      categoryId: categoryId ?? this.categoryId,
      location: location ?? this.location,
      unitDurationEvents: unitDurationEvents ?? this.unitDurationEvents,
    );
  }

  @override
  List<Object?> get props => [
        activeId,
        name,
        description,
        capacity,
        code,
        durationEvents,
        longitude,
        latitude,
        idActiveApp,
        phoneContact,
        emailContact,
        typeEvent,
        typeDateEvent,
        existence,
        appId,
        shareAsset,
        categoryId,
    location,
    unitDurationEvents
  ];

  Map<String, dynamic> toJson() {
    return {
      'activeId': this.activeId,
      'name': this.name,
      'description': this.description,
      'capacity': this.capacity,
      'code': this.code,
      'durationEvents': this.durationEvents,
      'longitude': this.longitude,
      'latitude': this.latitude,
      'idActiveApp': this.idActiveApp,
      'phoneContact': this.phoneContact,
      'emailContact': this.emailContact,
      'typeEvent': this.typeEvent,
      'typeDateEvent': this.typeDateEvent,
      'existence': this.existence,
      'appId': this.appId,
      'shareAsset': this.shareAsset,
      'categoryId': this.categoryId,
      'location': this.location,
      'unitDurationEvents': this.unitDurationEvents,
    };
  }

  factory QraActive.fromJson(Map<String, dynamic> map) {
    return QraActive(
      activeId: map['activeId'] ?? 0,
      name: map['name'],
      description: map['description'],
      capacity: map['capacity'],
      code: map['code'],
      durationEvents: map['durationEvents'],
      longitude: map['longitude'],
      latitude: map['latitude'],
      idActiveApp: map['idActiveApp'],
      phoneContact: map['phoneContact'],
      emailContact: map['emailContact'],
      typeEvent: map['typeEvent'],
      typeDateEvent: map['typeDateEvent'],
      existence: map['existence'],
      appId: map['appId'],
      shareAsset: map['shareAsset'],
      categoryId: QraCategory.fromJson(map['categoryId']),
      location: map['location'],
      unitDurationEvents: map['unitDurationEvents'],
    );
  }
}
