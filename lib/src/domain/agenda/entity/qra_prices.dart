import 'package:equatable/equatable.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_active.dart';

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

class QraPrices extends Equatable {
  const QraPrices({
    required this.activeId,
    required this.currency,
    required this.durationTime,
    this.enabledFlag,
    this.periodEnd,
    this.periodStart,
    this.periotTime,
    required this.price,
    this.priceId,
    this.typePrice,
  });

  final QraActive? activeId;
  final Currency? currency;
  final int? durationTime;
  final String? enabledFlag;
  final DateTime? periodEnd;
  final DateTime? periodStart;
  final TimeType? periotTime;
  final double? price;
  final int? priceId;
  final int? typePrice;

  QraPrices copyWith({
    QraActive? activeId,
    Currency? currency,
    int? durationTime,
    String? enabledFlag,
    DateTime? periodEnd,
    DateTime? periodStart,
    TimeType? periotTime,
    double? price,
    int? priceId,
    int? typePrice,
  }) {
    return QraPrices(
      activeId: activeId ?? this.activeId,
      currency: currency ?? this.currency,
      durationTime: durationTime ?? this.durationTime,
      enabledFlag: enabledFlag ?? this.enabledFlag,
      periodEnd: periodEnd ?? this.periodEnd,
      periodStart: periodStart ?? this.periodStart,
      periotTime: periotTime ?? this.periotTime,
      price: price ?? this.price,
      priceId: priceId ?? this.priceId,
      typePrice: typePrice ?? this.typePrice,
    );
  }

  static const empty = QraPrices(
    priceId: 0,
    price: 0,
    enabledFlag: 'N',
    typePrice: 0,
    activeId: null,
    durationTime: 0,
    currency: Currency.MXN,
    periotTime: TimeType.MONTHLY,
  );
  bool get isEmpty => this == QraPrices.empty;

  bool get isNotEmpty => this != QraPrices.empty;

  String getTypeCurrency(Currency currency) => currency.name.toLowerCase();

  String getStringOfTime(TimeType timeType) {
    switch (timeType) {
      case TimeType.DAY:
        {
          return 'Precio por dia';
        }
        break;

      case TimeType.HOURLY:
        {
          return 'Precio por hora';
        }
        break;

      case TimeType.YEARLY:
        {
          return 'Precio por año';
        }
        break;

      case TimeType.MINUTE:
        {
          return 'Precio por minuto';
        }
        break;

      case TimeType.MONTHLY:
        {
          return 'Precio por mes';
        }
        break;

      case TimeType.FUTBOL7:
        {
          return 'Precio por partido de fútbol 7';
        }
        break;
      case TimeType.SOCCER:
        {
          return 'Precio por partido de fútbol';
        }
        break;

      case TimeType.INDORFUTBOL:
        {
          return 'Precio por partido de fútbol sala';
        }
        break;
      case TimeType.FASTFUTBOL:
        {
          return 'Precio por partido de fútbol rapido';
        }
        break;

      case TimeType.MATCH:
        {
          return 'Precio por partido general';
        }
        break;
      default:
        {
          //statements;
        }
        break;
    }

    return 'sin tiempo definido';
  }

  factory QraPrices.fromJson(Map<String, dynamic> json) {
    return QraPrices(
      activeId: json["activeId"] == null
          ? null
          : QraActive.fromJson(json["activeId"]),
      currency: Currency.fromJson(json['currency'] ?? 'MXN'),
      durationTime: json["durationTime"],
      enabledFlag: json["enabledFlag"],
      periodEnd: DateTime.tryParse(json["periodEnd"] ?? ""),
      periodStart: DateTime.tryParse(json["periodStart"] ?? ""),
      periotTime: TimeType.fromJson(json['periotTime'] ?? 'MONTHLY'),
      price: json["price"],
      priceId: json["priceId"],
      typePrice: json["typePrice"],
    );
  }

  Map<String, dynamic> toJson() => {
        "activeId": activeId?.toJson(),
        "currency": currency?.name,
        "durationTime": durationTime,
        "enabledFlag": enabledFlag,
        "periodEnd": periodEnd?.toIso8601String(),
        "periodStart": periodStart?.toIso8601String(),
        "periotTime": periotTime?.name,
        "price": price == 0 ? null : price,
        "priceId": priceId,
        "typePrice": typePrice == 0 ? null : typePrice,
      };

  @override
  String toString() {
    return "$activeId, $currency, $durationTime, $enabledFlag, $periodEnd, $periodStart, $periotTime, $price, $priceId, $typePrice, ";
  }

  @override
  List<Object?> get props => [
        activeId,
        currency,
        durationTime,
        enabledFlag,
        periodEnd,
        periodStart,
        periotTime,
        price,
        priceId,
        typePrice,
      ];
}
