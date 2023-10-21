import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_active.dart';

class Availability extends Equatable {
  final QraActive? activeId;
  final int availabilityId;
  final DateTime? expirationDate;
  final DateTime? openingDate;
  final DateTime? hourClose;
  final DateTime? hourOpen;
  final int partyId;
  final int status;

  const Availability({
    this.activeId,
    required this.availabilityId,
    this.expirationDate,
    this.openingDate,
    this.hourClose,
    this.hourOpen,
    required this.partyId,
    required this.status,
  });

  static const empty = Availability(availabilityId: 0, partyId: 0, status: 0);

  bool get isEmpty => this == Availability.empty;

  bool get isNotEmpty => this != Availability.empty;

  Map<String, dynamic> toJson() {
    return {
      'activeId': activeId?.activeId,
      'availabilityId': availabilityId,
      'endDate': DateFormat('yyyy-MM-dd').format(expirationDate!),
      'startDate': DateFormat('yyyy-MM-dd').format(openingDate!),
      'hourClose': DateFormat('HH:mm:ss').format(hourClose!),
      'hourOpen': DateFormat('HH:mm:ss').format(hourOpen!),
      'partyId': partyId,
      'status': status,
    };
  }

  factory Availability.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat('yyyy-MM-DDTHH:mm');
    final expJsonDate = json['expirationDate']?.toString();
    final opeJsonDate =
        json['openingDate']?.toString() ?? json['openingdate']?.toString();
    final DateTime? expDate =
        expJsonDate != null ? dateFormat.parse(expJsonDate) : null;
    final DateTime? opeDate =
        opeJsonDate != null ? dateFormat.parse(opeJsonDate) : null;
    return Availability(
      activeId: json['activeId'] is int
          ? QraActive(activeId: json['activeId'] ?? 0)
          : QraActive.fromJson(json['activeId']),
      availabilityId: json['availabilityId'] ?? json['availability'] ?? 0,
      expirationDate: expDate,
      openingDate: opeDate,
      partyId: 0,
      status: 0,
    );
  }

  @override
  List<Object?> get props => [
        activeId,
        availabilityId,
        expirationDate,
        openingDate,
        hourClose,
        hourOpen,
        partyId,
        status,
      ];

  Availability copyWith({
    QraActive? activeId,
    int? availabilityId,
    DateTime? expirationDate,
    DateTime? openingDate,
    DateTime? hourClose,
    DateTime? hourOpen,
    int? partyId,
    int? status,
  }) {
    return Availability(
      activeId: activeId ?? this.activeId,
      availabilityId: availabilityId ?? this.availabilityId,
      expirationDate: expirationDate ?? this.expirationDate,
      openingDate: openingDate ?? this.openingDate,
      hourClose: hourClose ?? this.hourClose,
      hourOpen: hourOpen ?? this.hourOpen,
      partyId: partyId ?? this.partyId,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'Availability{activeId: $activeId, availabilityId: $availabilityId, expirationDate: $expirationDate, openingDate: $openingDate, hourClose: $hourClose, hourOpen: $hourOpen, partyId: $partyId, status: $status}';
  }
}
