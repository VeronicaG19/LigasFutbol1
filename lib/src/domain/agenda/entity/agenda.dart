import 'package:equatable/equatable.dart';

class Agenda extends Equatable {
  final int availabilityId;
  final DateTime? day;
  final DateTime? endHour;
  final int numDay;
  final DateTime? startHour;
  final int worksDaysId;

  const Agenda({
    required this.availabilityId,
    this.day,
    this.endHour,
    required this.numDay,
    this.startHour,
    required this.worksDaysId,
  });

  static const empty = Agenda(availabilityId: 0, numDay: 0, worksDaysId: 0);

  bool get isEmpty => this == Agenda.empty;

  bool get isNotEmpty => this != Agenda.empty;

  Agenda copyWith({
    int? availabilityId,
    DateTime? day,
    DateTime? endHour,
    int? numDay,
    DateTime? startHour,
    int? worksDaysId,
  }) {
    return Agenda(
      availabilityId: availabilityId ?? this.availabilityId,
      day: day ?? this.day,
      endHour: endHour ?? this.endHour,
      numDay: numDay ?? this.numDay,
      startHour: startHour ?? this.startHour,
      worksDaysId: worksDaysId ?? this.worksDaysId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'availabilityId': availabilityId,
      'day': day,
      'endHour': endHour,
      'numDay': numDay,
      'startHour': startHour,
      'worksDaysId': worksDaysId,
    };
  }

  factory Agenda.fromJson(Map<String, dynamic> json) {
    final endJsonDate = json['endHour']?.toString();
    final startJsonDate = json['startHour']?.toString();
    final dayJson = json['day']?.toString();
    final String dayFormat =
        '${dayJson?.substring(6, 10)}-${dayJson?.substring(3, 5)}-${dayJson?.substring(0, 2)}';
    final DateTime? endDate =
        endJsonDate != null ? DateTime.parse(endJsonDate) : null;
    final DateTime? startDate =
        startJsonDate != null ? DateTime.parse(startJsonDate) : null;
    final DateTime? day = dayJson != null ? DateTime.parse(dayFormat) : null;
    return Agenda(
      availabilityId: json['availabilityId'] ?? 0,
      day: day,
      endHour: endDate,
      numDay: json['numDay'] ?? 0,
      startHour: startDate,
      worksDaysId: json['worksDaysId'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        availabilityId,
        day,
        endHour,
        numDay,
        startHour,
        worksDaysId,
      ];
}
