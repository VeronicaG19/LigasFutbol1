import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_count_interface.g.dart';

///
/// Class by counts services [ResgisterCountInterface]
///
@JsonSerializable()
class ResgisterCountInterface extends Equatable {
  final int? coundt1;
  final String? type;
  const ResgisterCountInterface({
    this.coundt1,
    this.type,
  });

  ResgisterCountInterface copyWith({
    int? coundt1,
    String? type,
  }) {
    return ResgisterCountInterface(
      coundt1: coundt1 ?? this.coundt1,
      type: type ?? this.type,
    );
  }

  static const empty = ResgisterCountInterface();

  bool get isEmpty => this == ResgisterCountInterface.empty;

  bool get isNotEmpty => this != ResgisterCountInterface.empty;

  /// Connect the generated [_$ResgisterCountInterfaceFromJson] function to the `fromJson`
  /// factory.
  factory ResgisterCountInterface.fromJson(Map<String, dynamic> json) =>
      _$ResgisterCountInterfaceFromJson(json);

  /// Connect the generated [_$ResgisterCountInterfaceToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ResgisterCountInterfaceToJson(this);

  String get getInfoMessage =>
      isNotEmpty ? '$coundt1 - Por jugar: $type' : 'Mostrar todos';

  @override
  List<Object?> get props => [coundt1, type];
}
