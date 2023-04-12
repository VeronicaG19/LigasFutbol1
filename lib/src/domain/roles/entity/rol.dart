import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rol.g.dart';

@JsonSerializable()
class Rol extends Equatable {
  final String? editable;
  final int orgId;
  final String? roleDescription;
  final int? roleId;
  final String roleName;
  final String? visible;

  const Rol({
    this.editable,
    required this.orgId,
    this.roleDescription,
    this.roleId,
    required this.roleName,
    this.visible,
  });

  static const empty = Rol(orgId: 0, roleName: '');

  factory Rol.fromJson(Map<String, dynamic> json) => _$RolFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RolToJson(this);

  @override
  List<Object?> get props => [
        editable,
        orgId,
        roleDescription,
        roleId,
        roleName,
        visible,
      ];
}
