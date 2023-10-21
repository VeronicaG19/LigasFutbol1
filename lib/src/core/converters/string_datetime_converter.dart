import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';

class StringDateTimeConverter implements JsonConverter<DateTime, String> {
  const StringDateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.dateForTransactionFormat();
}
