import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lookupvalue.g.dart';

@JsonSerializable()
class LookUpValue extends Equatable {
  final String? enabledFlag;
  final String? lookupDescription;
  final int? lookupId;
  final String? lookupName;
  final String? lookupType;
  final int? lookupValue;
  final int? numberPlayers;
  const LookUpValue({
    this.enabledFlag,
    this.lookupDescription,
    this.lookupId,
    this.lookupName,
    this.lookupType,
    this.lookupValue,
    this.numberPlayers,
  });

  LookUpValue copyWith({
    String? enabledFlag,
    String? lookupDescription,
    int? lookupId,
    String? lookupName,
    String? lookupType,
    int? lookupValue,
    int? numberPlayers,
  }) {
    return LookUpValue(
      enabledFlag: enabledFlag ?? this.enabledFlag,
      lookupDescription: lookupDescription ?? this.lookupDescription,
      lookupId: lookupId ?? this.lookupId,
      lookupName: lookupName ?? this.lookupName,
      lookupType: lookupType ?? this.lookupType,
      lookupValue: lookupValue ?? this.lookupValue,
      numberPlayers: numberPlayers ?? this.numberPlayers,
    );
  }

  static const empty = LookUpValue();

  /// Connect the generated [_$LookUpValueFromJson] function to the `fromJson`
  /// factory.
  factory LookUpValue.fromJson(Map<String, dynamic> json) =>
      _$LookUpValueFromJson(json);

  /// Connect the generated [_$LookUpValueToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LookUpValueToJson(this);

  @override
  List<Object?> get props {
    return [
      enabledFlag,
      lookupDescription,
      lookupId,
      lookupName,
      lookupType,
      lookupValue,
      numberPlayers,
    ];
  }
}
