import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

enum Currency {
  MXN,
  USD,
  EUR;

  String toJson() => name;
  static Currency fromJson(String json) => values.byName(json);
}

enum TimeType {
  MONTHLY,
  HOURLY,
  MINUTE,
  DAY,
  YEARLY,
  SOCCER,
  FUTBOL7,
  INDORFUTBOL,
  FASTFUTBOL,
  MATCH;

  String toJson() => name;
  static TimeType fromJson(String json) => values.byName(json);
}

class QraEvent extends Equatable {
  final int activeId;
  final String assignmentStatus;
  final Currency? currency;
  final int duration;
  final DateTime? endDate;
  final DateTime? endHour;
  final int entytyId;
  final String information;
  final TimeType? pediod;
  final int? price;
  final DateTime? startDate;
  final DateTime? startHour;
  final int status;
  final String subject;
  final int? timePeriod;
  final String? fieldName;
  final int? fieldId;
  final int? eventId;
  final DateTime? dateHour;
  final DateTime? dateEvent;
  final String startHourString;
  final String endHourString;

  const QraEvent({
    required this.activeId,
    required this.duration,
    required this.entytyId,
    required this.timePeriod,
    required this.status,
    required this.assignmentStatus,
    this.endDate,
    required this.currency,
    this.price,
    this.endHour,
    required this.information,
    required this.pediod,
    this.startDate,
    this.startHour,
    required this.subject,
    this.fieldName,
    this.fieldId,
    this.eventId,
    this.dateHour,
    this.dateEvent,
    required this.startHourString,
    required this.endHourString,
  });

  static const empty = QraEvent(
      activeId: 0,
      duration: 0,
      entytyId: 0,
      timePeriod: 0,
      currency: Currency.MXN,
      price: 0,
      status: 0,
      assignmentStatus: '',
      information: '',
      pediod: TimeType.MONTHLY,
      startHourString: '',
      endHourString: '',
      subject: '');

  bool get isEmpty => this == QraEvent.empty;

  bool get isNotEmpty => this != QraEvent.empty;

  Map<String, dynamic> toJson() {
    return {
      'activeId': activeId == 0 ? null : activeId,
      'currency': currency?.name,
      'price': price == 0 ? null : price,
      'duration': duration == 0 ? null : duration,
      'entytyId': entytyId == 0 ? null : entytyId,
      'timePeriod': timePeriod == 0 ? null : timePeriod,
      'status': status == 0 ? null : status,
      'assignmentStatus': assignmentStatus == '' ? null : assignmentStatus,
      'endDate':
          endDate != null ? DateFormat('yyyy-MM-dd').format(endDate!) : null,
      'endHour':
          endHour != null ? DateFormat('HH:mm:ss').format(endHour!) : null,
      'information': information == '' ? null : information,
      'pediod': pediod?.name,
      'startDate': startDate != null
          ? DateFormat('yyyy-MM-dd').format(startDate!)
          : null,
      'startHour':
          startHour != null ? DateFormat('HH:mm:ss').format(startHour!) : null,
      'subject': subject == '' ? null : subject,
    };
  }

  factory QraEvent.fromJson(Map<String, dynamic> map) {
    // final endJsonDate = map['endHour']?.toString();
    // final startJsonDate = map['startHour']?.toString();
    // final startDayJson =
    //     map['startDate']?.toString() ?? map['start_DATE']?.toString();
    // final endDayJson = map['endDate']?.toString();
    final dateEventJson = map['dateevent']?.toString();
    // final dateHourJson = map['datehour']?.toString();
    // final DateTime? startDay =
    //     startDayJson != null ? DateTime.parse(startDayJson) : null;
    // final DateTime? endDay =
    //     endDayJson != null ? DateTime.parse(endDayJson) : null;
    final DateTime? dateEvent =
        dateEventJson != null ? DateTime.parse(dateEventJson) : null;
    // final DateTime? startHour =
    // startJsonDate != null ? DateTime.parse(startJsonDate) : null;
    // final DateTime? dateHour =
    //     dateHourJson != null ? DateTime.parse(dateHourJson) : null;
    // final DateTime? endHour =
    // endJsonDate != null ? DateTime.parse(endJsonDate) : null;
    return QraEvent(
      activeId: map['activeId'] ?? 0,
      duration: map['duration'] ?? 0,
      currency: Currency.fromJson(map['currency'] ?? 'MXN'),
      pediod: TimeType.fromJson(map['pediod'] ?? 'MONTHLY'),
      price: map['price'] ?? 0,
      entytyId: map['entytyId'] ?? 0,
      timePeriod: map['timePeriod'] ?? 0,
      status: map['status'] ?? 0,
      assignmentStatus: map['assignmentStatus'] ?? '',
      endDate: null,
      endHour: null,
      information: map['information'] ?? '',
      startDate: null,
      startHour: null,
      subject: map['subject'] ?? '',
      dateEvent: dateEvent,
      dateHour: null,
      eventId: map['eventId'] ?? 0,
      fieldName: map['fiedlName']?.toString() ?? '',
      fieldId: map['fieldId'] ?? 0,
      startHourString: map['starthour'] ?? '',
      endHourString: map['endhour'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        activeId,
        duration,
        entytyId,
        timePeriod,
        status,
        currency,
        price,
        assignmentStatus,
        endDate,
        endHour,
        information,
        pediod,
        startDate,
        startHour,
        subject,
      ];

  QraEvent copyWith({
    int? activeId,
    String? assignmentStatus,
    Currency? currency,
    int? duration,
    DateTime? endDate,
    DateTime? endHour,
    int? entytyId,
    String? information,
    TimeType? pediod,
    int? price,
    DateTime? startDate,
    DateTime? startHour,
    int? status,
    String? subject,
    int? timePeriod,
    String? fieldName,
    int? fieldId,
    int? eventId,
    DateTime? dateHour,
    DateTime? dateEvent,
    String? startHourString,
    String? endHourString,
  }) {
    return QraEvent(
      activeId: activeId ?? this.activeId,
      assignmentStatus: assignmentStatus ?? this.assignmentStatus,
      currency: currency ?? this.currency,
      duration: duration ?? this.duration,
      endDate: endDate ?? this.endDate,
      endHour: endHour ?? this.endHour,
      entytyId: entytyId ?? this.entytyId,
      information: information ?? this.information,
      pediod: pediod ?? this.pediod,
      price: price ?? this.price,
      startDate: startDate ?? this.startDate,
      startHour: startHour ?? this.startHour,
      status: status ?? this.status,
      subject: subject ?? this.subject,
      timePeriod: timePeriod ?? this.timePeriod,
      fieldName: fieldName ?? this.fieldName,
      fieldId: fieldId ?? this.fieldId,
      eventId: eventId ?? this.eventId,
      dateHour: dateHour ?? this.dateHour,
      dateEvent: dateEvent ?? this.dateEvent,
      startHourString: startHourString ?? this.startHourString,
      endHourString: endHourString ?? this.endHourString,
    );
  }
}
