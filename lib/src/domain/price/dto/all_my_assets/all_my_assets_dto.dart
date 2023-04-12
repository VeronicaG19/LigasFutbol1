import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_active.dart';

class AllMyAssetsDTO extends Equatable{
  final QraActive? activeId;
  final String? currency;
  final int? durationTime;
  final String? enabledFlag;
  final DateTime? periodEnd;
  final DateTime? periodStart;
  final String? periotTime;
  final double? price;
  final int? priceId;
  final int? typePrice;

  const AllMyAssetsDTO({
    this.activeId,
    this.currency,
    this.durationTime,
    this.enabledFlag,
    this.periodEnd,
    this.periodStart,
    this.periotTime,
    this.price,
    this.priceId,
    this.typePrice,
  });

  AllMyAssetsDTO copyWith({
    QraActive? activeId,
    String? currency,
    int? durationTime,
    String? enabledFlag,
    DateTime? periodEnd,
    DateTime? periodStart,
    String? periotTime,
    double? price,
    int? priceId,
    int? typePrice,
  }) {
    return AllMyAssetsDTO(
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

  Map<String, dynamic> toJson() {
    return {
      'activeId': activeId,
      'currency': currency,
      'durationTime': durationTime,
      'enabledFlag': enabledFlag,
      'periodEnd': DateFormat('yyyy-MM-dd').format(periodEnd!),
      'periodStart': DateFormat('yyyy-MM-dd').format(periodStart!),
      'periotTime': periotTime,
      'price': price,
      'priceId': priceId,
      'typePrice': typePrice,
    };
  }

  static const empty = AllMyAssetsDTO();

  bool get isEmpty => this == AllMyAssetsDTO.empty;

  bool get isNotEmpty => this != AllMyAssetsDTO.empty;

  factory AllMyAssetsDTO.fromJson(Map<String, dynamic> json) {

    final periodEndJsonDate = json['periodEnd']?.toString();
    final periodStartJsonDate =
        json['periodStart']?.toString() ?? json['periodStart']?.toString();
    final DateTime? periodStart =
    periodEndJsonDate != null ? DateTime.parse(periodEndJsonDate) : null;
    final DateTime? periodEnd =
    periodStartJsonDate != null ? DateTime.parse(periodStartJsonDate) : null;

    return AllMyAssetsDTO(
      activeId: QraActive.fromJson(json['activeId']),
      currency: json['currency'],
      durationTime: 1,
      enabledFlag: json['enabledFlag'],
      periodEnd: periodEnd,
      periodStart: periodStart,
      price: json['price'],
      priceId: json['priceId'],
      typePrice: json['typePrice'],
      periotTime: json['periotTime']
    );
  }
}